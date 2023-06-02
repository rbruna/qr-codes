function valid = myqr_listUsable ( matrix )

% Based on the definition in standard:
% * ISO/IEC 18004:2015 section 7.7.


% Gets the size of the QR matrix.
msize  = size ( matrix, 1 );

% Initializes the list of valid cells.
valid  = nan ( 1, sum ( isnan ( matrix (:) ) ) );



% Data is stored starting on the bottom-right corner, un a two-column-wide
% zig-zagging:
% * Start at bottom right.
% * Then immediate left.
% * Then immediate up.
% * Then immediate right.
% * Repeat until the top and skip to the next two-colum.
% * Start at top right.
% * Then immediate left.
% * Then immediate down.
% * Then immediate right.
% * Repeat until the bottom and skip to the next two-colum.


% Starts from botton to top.
upward = true;

% Goes through the columns from right to left.
for cindex = [ msize: -2: 8 6: -2: 1 ]
    
    % Goes through each row.
    for rindex = 1: msize
        
        % If the direction is upwards flips the current row.
        if upward
            rindex = msize - rindex + 1; %#ok<FXSET>
        end
        
        
        % Checks the current cell.
        if isnan ( matrix ( rindex, cindex ) )
            
            % Gets the number of valid cells up to now.
            nvalid = sum ( isfinite ( valid ) );
            
            % Stores the index of the cell in the next position.
            valid ( nvalid + 1 ) = sub2ind ( [ msize msize ], rindex, cindex );
        end
        
        % Checks the cell to the left.
        if isnan ( matrix ( rindex, cindex - 1 ) )
            
            % Gets the number of valid cells up to now.
            nvalid = sum ( isfinite ( valid ) );
            
            % Stores the index of the cell in the next position.
            valid ( nvalid + 1 ) = sub2ind ( [ msize msize ], rindex, cindex - 1 );
        end
    end
    
    % Changes the direction of the next column.
    upward  = ~upward;
end
