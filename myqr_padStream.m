function symbs = myqr_padStream ( symbs, version, level )

% Based on the definition in standard:
% * ISO/IEC 18004:2015 Section 7.5.2.


% Indentifies the data length per EC level and version (Table 7).
qrsize  = myqr_listSize;
maxsymb = qrsize ( :, 2: end );

% Calculates the padding size to fill the data symbols.
ssize   = maxsymb ( version, level );
psize   = ssize - size ( symbs, 2 );

% Generates the padding pattern.
psymb   = [ 1 1 1 0 1 1 0 0; 0 0 0 1 0 0 0 1 ]';

% Generates the padding symbols.
psymb   = repmat ( psymb, 1, ceil ( psize / size ( psymb, 2 ) ) );
psymb   = psymb ( :, 1: psize );

% Padds the symbol stream to the defined data size.
symbs   = cat ( 2, symbs, psymb );
