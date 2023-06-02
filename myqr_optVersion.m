function version = myqr_optVersion ( msg, level, version )

% Based on the definition in standard:
% * ISO/IEC 18004:2015 Table 7.


% Sets the default options.
if nargin < 2, level   = 1;  end
if nargin < 3, version = []; end


% Gets the maximum number of symbols per code (Table 7).
qrsize  = myqr_listSize;
maxsymb = qrsize ( :, 2: end );

% The maximum bytes are #-2 (#-3 for version >10) (Tables 3 and 7).
maxbyte = maxsymb - 2;
maxbyte ( 10: end, : ) = maxbyte ( 10: end, : ) - 1;


% Calculates the optimal version for the desired error correction level.
optver  = find ( maxbyte ( :, level ) >= numel ( msg ), 1 );

% If no version provided, sets it.
if isempty ( version )
    version = optver;
    
% Otherwise overwrites the version, if required.
elseif optver > version
    warning ( 'Version updated to %i to fit the message length.\n', optver );
    version = optver;
end
