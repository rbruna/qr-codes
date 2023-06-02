function symbs = myqr_msg2bytes ( msg, version )

% Based on the definition in standard:
% * ISO/IEC 18004:2015


% Gets the message length.
msize   = numel ( msg );


% Converts the message to Latin 1 (ISO/IEC 8859-1) (Table 6).
msg     = native2unicode ( msg );
msg     = unicode2native ( msg, 'ISO-8859-1' );


% Converts the message into a stream of bits (logicals).
bits    = dec2bin ( msg, 8 )' == '1';
bits    = reshape ( bits, 1, [] );


% Appends the size indicator (8 bits if version < 9, 16 bits otherwise).
isize   = dec2bin ( msize, 8 + 8 * ( version >= 10 ) )' == '1';
isize   = reshape ( isize, 1, [] );
bits    = cat ( 2, isize, bits );


% Appens the byte mode indicator (7.4.5).
imode   = [ 0 1 0 0 ];
bits    = cat ( 2, imode, bits );


% Pads the bits stream to a multiple of 8 bits, if required.
bsize   = numel ( bits );
psize   = 8 * ceil ( bsize / 8 ) - bsize;
bits    = cat ( 2, bits, false ( 1, psize ) );

% Re-draws the bit stream as 8-bit symbols.
symbs   = reshape ( bits, 8, [] );
