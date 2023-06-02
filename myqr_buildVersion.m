function bits = myqr_buildVersion ( version )

% Based on the definition in standard:
% * ISO/IEC 18004:2015 Annex D.


% Builds the version bit stream.
bits    = dec2bin ( version, 6 )' == '1';

% Padds the bit stream to make room for the remainder.
pbits   = cat ( 1, bits (:), false ( 12, 1 ) );

% Calculates the error correction bits.
div     = [ 1  1 1 1 1  0 0 1 0  0 1 0 1 ]';
ecbits  = mygf_symrem ( pbits, div );

% Adds the error correction bits to the stream.
bits    = cat ( 1, bits, ecbits );
