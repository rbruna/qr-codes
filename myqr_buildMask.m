function mask = myqr_buildMask ( version, mtype )

% Based on the definition in standard:
% * ISO/IEC 18004:2015


% Defines the size of the QR matrix.
msize   = ( version + 4 ) * 4 + 1;


% Gets the per-module index.
iindex  = 0: msize - 1;
idummy  = zeros ( 1, msize );
jindex  = 0: msize - 1;
jdummy  = zeros ( 1, msize );


% Generates the right mask (Table 10).
switch mtype
    case 0, mask    = rem ( iindex' + jindex, 2 ) == 0;
    case 1, mask    = rem ( iindex' + jdummy, 2 ) == 0;
    case 2, mask    = rem ( idummy' + jindex, 3 ) == 0;
    case 3, mask    = rem ( iindex' + jindex, 3 ) == 0;
    case 4, mask    = rem ( floor ( iindex' / 2 ) + floor ( jindex / 3 ), 2 ) == 0;
    case 5, mask    = rem ( iindex' .* jindex, 2 ) + rem ( iindex' .* jindex, 3 ) == 0;
    case 6, mask    = rem ( rem ( iindex' .* jindex, 2 ) + rem ( iindex' .* jindex, 3 ), 2 ) == 0;
    case 7, mask    = rem ( rem ( iindex' + jindex, 2 ) + rem ( iindex' .* jindex, 3 ), 2 ) == 0;
    otherwise
        error ( 'Unknown mask identifier.' )
end
