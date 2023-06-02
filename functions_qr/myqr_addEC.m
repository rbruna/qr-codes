function symbs = myqr_addEC ( symbs, version, level )

% Based on the definition in standard:
% * ISO/IEC 18004:2015

% According to https://tomverbeure.github.io/2022/08/07/Reed-Solomon.html
% Symbol: The smallest piece of information, here a byte.
% Message: The sequence of bytes.
% Message word: The block to calculate EC over. Contains k symbols.
% Alphabet: The set of values for the symbols. Contains q symbols. GF8?
% Code word: Output of the encoder, message word + EC. Contains n symbols.

% Section "A Code Word as a Sequence of Polynomial Coefficients".
% The polynomial is s(x).
% * The first k coefficients will be the data codewords.
% * s (x) at (n-k) values should be zero.
% 
% To create this polynomial:
% 1 Define p (x) from the k data codewords.
% 2 Defines the generator polynomial g (x).
% 3 Divides p(x) x^(n-k) / g (x) to get the remainder r(x).
% 4 Defines s (x) as p (x) x^(n-k) - r (x);


% Sets the default values.
if nargin < 3, level   = 1;  end


% Gets the number and size of the data and error correction blocks.
bsizes  = myqr_getBlockSize ( level, version );
nblock  = size ( bsizes, 1 );

% All error correction blocks have the same size.
ecsize  = bsizes ( 1, 2 );

% Gets the generative polynomial (divisor).
genpol  = myqr_getGenPol ( ecsize );


% Reserves memory for the (interleaved) data and error correction symbols.
isymbs  = nan ( 8, nblock, max ( bsizes ( :, 1 ) ) );
irsymbs = nan ( 8, nblock, ecsize );

% Goes through each block.
for bindex = 1: nblock
    
    % Gets the offset and size of the current block of data.
    boff    = sum ( bsizes ( 1: bindex - 1, 1 ) );
    bsize   = bsizes ( bindex, 1 );
    
    % Gets the current block of data symbols.
    bsymbs  = symbs ( :, boff + ( 1: bsize ) );
    
    % Padds the bits stream to make room for the remainder.
    psymbs  = cat ( 2, bsymbs, false ( 8, ecsize ) );
    
    % Calculates the error correction bits for the block (7.5.2).
    rsymbs  = mygf_wordrem ( psymbs, genpol );
    
    
    % Stores the ( interleaved ) data and error correction blocks.
    isymbs  ( :, bindex, 1: bsize )  = bsymbs;
    irsymbs ( :, bindex, 1: ecsize ) = rsymbs;
end

% Flattens the interleaved symbols matrices.
isymbs    = reshape ( isymbs,  8, [] );
irsymbs   = reshape ( irsymbs, 8, [] );

% Removes the empty symbols.
isymbs    = isymbs ( :, all ( isfinite ( isymbs ), 1 ) );

% Combines the (interleaved) data and error correction symbols.
symbs   = cat ( 2, isymbs, irsymbs );
