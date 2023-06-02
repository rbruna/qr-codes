function bsize = myqr_getBlockSize ( level, version )

% Lists the number of data and error symbols and the number of blocks.
nblocks = myqr_listBlocks;
ssizes  = myqr_listSize;

% Gets the values for the defined EE level and version.
tsymb   = ssizes ( version, 1 );
dsymb   = ssizes ( version, level + 1 );
esymb   = tsymb - dsymb;
nblock  = nblocks ( version, level );


% Gets the size of the data and error blocks.
dblock  = ceil ( dsymb / nblock );
eblock  = ceil ( esymb / nblock );

% Prepares the block definition.
bsize   = repmat ( [ dblock eblock ], nblock, 1 );


% Gets the number of short blocks.
sblock  = dblock * nblock - dsymb;

% Corrects the short blocks.
bsize ( 1: sblock, 1 ) = dblock - 1;
