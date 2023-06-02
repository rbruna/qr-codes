function pscore = myqr_getPenalty ( matrix )

% Based on the definition in standard:
% * ISO/IEC 18004:2015 Section 7.8.3.


% Feature 1: adjancent modules (Table 11, Note 1).

% Initializes the adjancency matrixes.
vlines = ones ( size ( matrix ) );
hlines = ones ( size ( matrix ) );

% Counts the adjencent modules per rows.
for index = 2: size ( vlines, 1 )
    hits = matrix ( index, : ) == matrix ( index - 1, : );
    vlines ( index, hits ) = vlines ( index - 1, hits ) + 1;
    vlines ( index - 1, hits ) = NaN;
end

% Counts the adjencent modules per columns.
for index = 2: size ( hlines, 1 )
    hits = matrix ( :, index ) == matrix ( :, index - 1 );
    hlines ( hits, index ) = hlines ( hits, index - 1 ) + 1;
    hlines ( hits, index - 1 ) = NaN;
end

% Trims the adjancency at 5.
vlines = max ( vlines - 4, 0 );
hlines = max ( hlines - 4, 0 );

% Calculates the associated penalty score.
score1 = sum ( vlines (:) * 3 ) + sum ( hlines (:) * 3 );


% Feature 2: 2x2 blocks of modules of the same color (Table 11, Note 2).

% Checks the matrix for 2x2 modules.
check  = conv2 ( 2 * matrix - 1, ones (2) );

% Hits are values with (absolute) value of 4.
hits   = sum ( check (:) == 4 );

% Calculates the associated penalty score.
score2 = 3 * hits;


% Feature 3: 1:1:3:1:1 patterns flanked by 4 white modules.

% Defines the 1:1:3:1:1 + 4 pattern.
patt1  = [ 1 0 1 1 1 0 1 0 0 0 0 ];
patt2  = [ 0 0 0 0 1 0 1 1 1 0 1 ];

% Checks the matrix for the pattern both vertically and horizontally.
check1 = conv2 ( 2 * matrix - 1, 2 * patt1 - 1 );
check2 = conv2 ( 2 * matrix - 1, 2 * patt2 - 1 );
check3 = conv2 ( 2 * matrix - 1, 2 * patt1' - 1 );
check4 = conv2 ( 2 * matrix - 1, 2 * patt2' - 1 );

% The hits are locations with a value of 11.
hits1  = any ( check1 (:) == 11 );
hits2  = any ( check2 (:) == 11 );
hits3  = any ( check3 (:) == 11 );
hits4  = any ( check4 (:) == 11 );

% Calculates the associated penalty score.
score3 = 40 * ( hits1 || hits2 || hits3 || hits4 );


% Feature 4: proportion of dark modules (Table 11, Note 4). 

% Gets the ratio of black to white modules.
ratio  = sum ( matrix (:) == 1 ) / numel ( matrix );

% Gets the 5-percents of derivation form 50%.
deriv  = floor ( 100 * abs ( ratio - 0.5 ) );

% Calculates the associated penalty score.
score4 = 10 * deriv;


% The total penalty is the summation of all four penalty scores.
pscore = score1 + score2 + score3 + score4;
