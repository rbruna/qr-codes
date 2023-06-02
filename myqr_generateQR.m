function matrix = myqr_generateQR ( msg, level, version )

% Based on the definition in standard:
% * ISO/IEC 18004:2015


% Sets the default options.
if nargin < 3, version = []; end
if nargin < 2, level   = 1;  end

% Decodes the error correction level, if required.
if ischar ( level )
    switch level
        case L, level = 1;
        case M, level = 2;
        case Q, level = 3;
        case H, level = 4;
        otherwise
            error ( 'Invalid error correction level.' )
    end
end

% Checks the level.
if level < 1 || level > 4 || level ~= round ( level )
    error ( [ ...
        'Invalid value provided for the error correction level.\n' ...
        'Valid values are: L, M, Q, H.' ], [] );
end

% Checks the version.
if version < 1 || version > 40 || version ~= round ( version )
    error ( [ ...
        'Invalid value provided for the QR version.\n' ...
        'Valid values are: integers from 1 to 40.' ], [] );
end


% Overwrites the version, if required.
version = myqr_optVersion ( msg, level, version );


% Convers the message into a symbol stream.
symbs   = myqr_msg2bytes ( msg, version );

% Padds the symbol stream to the defined data size.
symbs   = myqr_padStream ( symbs, version, level );

% Adds the error correction to the symbol stream.
symbs   = myqr_addEC ( symbs, version, level );


% Generates the QR matrix.
matrix  = myqr_buildMatrix ( symbs, level, version );


% Adds the quiet zone (4 bits wide).
qrows   = false ( 4, size ( matrix, 2 ) );
qcols   = false ( size ( matrix, 1 ) + 8, 4 );
matrix  = cat ( 1, qrows, matrix, qrows );
matrix  = cat ( 2, qcols, matrix, qcols );
