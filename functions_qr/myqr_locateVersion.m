function bitsloc = myqr_locateVersion ( version )

% Based on the definition in standard:
% * ISO/IEC 18004:2015 Section 7.10.


% Defines the size of the QR matrix.
msize   = ( version + 4 ) * 4 + 1;


% Defines the shape of the version block (Fig. 28).
rows    = reshape ( repmat ( 1: 6, [ 3 1 ] ), 1, [] );
rows    = fliplr ( rows );
cols    = reshape ( repmat ( 1: 3, [ 6 1 ] )', 1, [] );
cols    = fliplr ( cols );

% Locates the upper-right version information.
urloc   = sub2ind ( [ msize msize ], rows, msize - 11 + cols );

% The lower-left version information is its transpose.
llloc   = sub2ind ( [ msize msize ], msize - 11 + cols, rows );


% Joins both locations.
bitsloc = cat ( 2, urloc, llloc );
