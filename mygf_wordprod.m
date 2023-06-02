function word = mygf_wordprod ( word1, word2 )

% Word multiplication.
% 
% Equivalent to a convolution inside a Galois field.

% Based on:
% * https://tomverbeure.github.io/2022/08/07/Reed-Solomon.html
%   by Tom Verbeure
% * https://en.wikiversity.org/wiki/Reed%E2%80%93Solomon_codes_for_coders#RS_encoding
%   by an unknown author.


% Gets the size of the inputs.
size1 = size ( word1, 2 );
size2 = size ( word2, 2 );


% Initializes the convolution.
word  = false ( 8, size1 + size2 - 1 );

% Goes through each pair of entries.
for aindex = 1: size1
    for bindex = 1: size2
        
        % Calculates the product symbol.
        symb  = mygf_symprod ( word1 ( :, aindex ), word2 ( :, bindex ) );
        
        % Stores the product.
        index = aindex + bindex - 1;
        word ( :, index ) = xor ( word ( :, index ), symb );
    end
end
