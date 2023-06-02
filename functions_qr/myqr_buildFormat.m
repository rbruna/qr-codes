function mbits = myqr_buildFormat ( level, mtype )

% Based on the definition in standard:
% * ISO/IEC 18004:2015 Annex C.


% Rewrites the EC level in bit format.
blevel  = dec2bin ( level - 1, 2 )' == '1';
blevel  = xor ( blevel, [ 0 1 ]' );

% Rewrites the mask identifier in bit format.
bmtype  = dec2bin ( mtype, 3 )' == '1';

% Builds the format bit stream by joining the EC level and the mask.
bits    = cat ( 1, blevel, bmtype );

% Padds the bit stream to make room for the remainder.
pbits   = cat ( 1, bits (:), false ( 10, 1 ) );

% Calculates the error correction bits.
div     = [ 1 0 1  0 0 1 1  0 1 1 1 ]';
ecbits  = mygf_symrem ( pbits, div );

% Adds the error correction bits to the stream.
bits    = cat ( 1, bits, ecbits );

% Applies the format mask.
mask    = [ 1 0 1 0 1  0 0 0 0 0  1 0 0 1 0 ]';
mbits   = xor ( bits, mask );
