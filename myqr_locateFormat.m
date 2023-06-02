function bitsloc = myqr_locateFormat ( version )

% Based on the definition in standard:
% * ISO/IEC 18004:2015 Section 7.9.


% Defines the size of the QR matrix.
msize   = ( version + 4 ) * 4 + 1;


% Calculates the location according to Fig. 25.
loc1    = sub2ind ( [ msize, msize ],  [  9  9  9  9  9  9 ],  1:  6 );
loc2    = sub2ind ( [ msize, msize ],  [  9  9  8 ], [  8  9  9 ] );
loc3    = sub2ind ( [ msize, msize ],  1:  6,  [  9  9  9  9  9  9 ] );
loc3    = fliplr ( loc3 );
loc4    = sub2ind ( [ msize, msize ], msize - 6: msize, [  9  9  9  9  9  9  9 ] );
loc4    = fliplr ( loc4 );
loc5    = sub2ind ( [ msize, msize ], [  9  9  9  9  9  9  9  9 ], msize - 7: msize );

% Concatenates all the locations.
bitsloc = cat ( 2, loc1, loc2, loc3, loc4, loc5 );