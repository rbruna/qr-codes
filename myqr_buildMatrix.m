function matrix = myqr_buildMatrix ( symbs, level, version )

% Based on the definition in standard:
% * ISO/IEC 18004:2015


% Creates the patterns for the QR matrix (6.3).
matrix  = myqr_buildPatterns ( version );


% Initializes the format information (7.9).
fbits   = myqr_buildFormat ( level, 0 );

% Locates the format information.
bitsloc = myqr_locateFormat ( version );

% Adds the format to the matrix.
matrix ( bitsloc ) = cat ( 2, fbits, fbits );


% Adds the version information, if required (7.10).
if version >= 7
    
    % Calculates the version information (7.10).
    vbits   = myqr_buildVersion ( version );
    
    % Includes the version information in the QR matrix.
    bitsloc = myqr_locateVersion ( version );
    matrix ( bitsloc ) = cat ( 2, vbits, vbits );
end


% Lists the usables data modules and the remainder bits.
valid   = myqr_listUsable ( matrix );

% Converts the symbols into a stream of bits.
bits    = reshape ( symbs, 1, [] );

% Padds the bit stream with the remainder bits, if required (Table 1).
nvalid  = numel ( valid );
nbits   = numel ( bits );
bits    = cat ( 2, bits, false ( 1, nvalid - nbits ) );


% Reserves memory for the penalty scores.
pscore  = zeros ( 7, 1 );

% Iterates though the mask types.
for mtype = 0: 7
    
    % Generates the data mask (7.8).
    mask    = myqr_buildMask ( version, mtype );
    
    % Applies the mask to the data.
    mbits   = xor ( bits, mask ( valid ) );
    
    % Introduces the masked bit stream in the matrix.
    matrix ( valid ) = mbits;
    
    
    % Generates the new format information (7.9).
    fbits   = myqr_buildFormat ( level, mtype );
    
    % Locates the format information.
    bitsloc = myqr_locateFormat ( version );
    
    % Updates the format information.
    matrix ( bitsloc ) = cat ( 2, fbits, fbits );
    
    
    % Calculates the penalty score.
    pscore ( mtype + 1 ) = myqr_getPenalty ( matrix );
end


% Selects the mask with the lower penalty.
[ ~, index ] = min ( pscore );
mtype   = index - 1;

% Generates the data mask (7.8).
mask    = myqr_buildMask ( version, mtype );

% Applies the mask to the data.
mbits   = xor ( bits, mask ( valid ) );

% Introduces the masked bit stream in the matrix.
matrix ( valid ) = mbits;


% Generates the new format information (7.9).
fbits   = myqr_buildFormat ( level, mtype );

% Locates the format information.
bitsloc = myqr_locateFormat ( version );

% Updates the format information.
matrix ( bitsloc ) = cat ( 2, fbits, fbits );
