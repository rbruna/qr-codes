function matrix = myqr_buildPatterns ( version )

% Based on the definition in standard:
% * ISO/IEC 18004:2015


% Defines the size of the QR matrix.
msize   = ( version + 4 ) * 4 + 1;

% Initializes the matrix to NaN.
matrix  = nan ( msize );


% Builds the finder pattern (6.3.3).
fpatt   = [ ...
    1 1 1 1 1 1 1;
    1 0 0 0 0 0 1;
    1 0 1 1 1 0 1;
    1 0 1 1 1 0 1;
    1 0 1 1 1 0 1;
    1 0 0 0 0 0 1;
    1 1 1 1 1 1 1 ];

% Builds the alignment pattern.
apatt   = [ ...
    1 1 1 1 1;
    1 0 0 0 1;
    1 0 1 0 1;
    1 0 0 0 1;
    1 1 1 1 1 ];


% Adds the finder patterns (6.3.3).
fxpos   = 4;
fypos   = 4;
matrix ( ( -3: +3 ) + fypos, ( -3: +3 ) + fxpos ) = fpatt;
fxpos   = 4;
fypos   = msize - 3;
matrix ( ( -3: +3 ) + fypos, ( -3: +3 ) + fxpos ) = fpatt;
fxpos   = msize - 3;
fypos   = 4;
matrix ( ( -3: +3 ) + fypos, ( -3: +3 ) + fxpos ) = fpatt;


% Adds the separators (6.3.4).
matrix (  1:  8,  8 ) = 0;
matrix (  8,  1:  8 ) = 0;
matrix (  8, msize -  7: msize ) = 0;
matrix ( msize -  7: msize,  8 ) = 0;
matrix (  1:  8, msize -  7 ) = 0;
matrix ( msize -  7,  1:  8 ) = 0;


% Adds the timing patterns (6.3.5).
matrix (  9:  2: msize -  8,  7 ) = 1;
matrix ( 10:  2: msize -  8,  7 ) = 0;
matrix (  7,  9:  2: msize -  8 ) = 1;
matrix (  7, 10:  2: msize -  8 ) = 0;


% Adds the alignment patterns, if required (6.3.6).
if version > 1
    
    % Gets the number of markers.
    nmark   = floor ( ( msize + 11 ) / 28 ) + 1;
    
    % Gets the spacing between the markers.
    mdist   = round ( ( msize - 13 ) / ( nmark - 1 ) );
    mdist   = 2 * ceil ( mdist / 2 );
    
    % Distributes the markers evenly between 7 and end-6 (Table E.1).
    apos    = msize - 6: -mdist: 10;
    apos    = fliplr ( apos );
    
    % Adds the first marker at 7.
    apos    = cat ( 2, 7, apos );
    
    
    % Adds the alignment patterns every so many rows and columns.
    for axpos = apos
        for aypos = apos
            
            % Skips the areas occupied by the tree finder patterns.
            if axpos < 10 && aypos < 10, continue, end
            if axpos < 10 && aypos > msize - 9, continue, end
            if axpos > msize - 9 && aypos < 10, continue, end
            
            % Adds the alignment patterns.
            matrix ( ( -2: +2 ) + aypos, ( -2: +2 ) + axpos ) = apatt;
        end
    end
end


% Adds the dark module to pad the format (Fig. 25).
matrix ( msize - 7,  9 ) = 1;
