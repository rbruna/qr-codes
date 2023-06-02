function word = mygf_wordrem ( word1, word2 )

% Block remainder inside a Galois field.

% Based on:
% * https://tomverbeure.github.io/2022/08/07/Reed-Solomon.html
%   by Tom Verbeure
% * https://en.wikiversity.org/wiki/Reed%E2%80%93Solomon_codes_for_coders#RS_encoding
%   by an unknown author.


% Initializes the remainder to the dividend.
word  = word1;

% Calculates the number of interations.
isize = size ( word, 2 ) - size ( word2, 2 ) + 1;

% Goes through the dividend.
for index1 = 1: isize
    
    % Gets the multiplier for this symbol.
    mult  = word ( :, index1 );
    
    % If the value is zero skips this symbol.
    if ~any ( mult ), continue, end
    
    
    % Initializes the products matrix.
    prods = false ( size ( word ) );
    
    % Updates the remainder.
    for index2 = 1: size ( word2, 2 )
        
        % Gets the current symbol.
        symb  = word2 ( :, index2 );
        
        % Multiplies the symbol by the multiplier.
        prod  = mygf_symprod ( symb, mult );
        
        % Stores the product.
        prods ( :, index1 + index2 - 1 ) = prod;
    end
    
    % Gets the remainder.
    word   = xor ( word, prods );
end

% Removes the trailing zeros.
word   = word ( :, isize + 1: end );
