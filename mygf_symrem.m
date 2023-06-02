function symb = mygf_symrem ( symb1, symb2 )

% Remainder inside a Galois field.


% Initializes the remainder to the dividend.
symb  = symb1;

% Calculates the number of interations.
isize = numel ( symb ) - numel ( symb2 ) + 1;

% Goes through the dividend.
for index = 1: isize
    
    % Compares the two polynomials.
    if symb ( index )
        hits  = index + ( 1: numel ( symb2 ) ) - 1;
        symb ( hits ) = xor ( symb ( hits ), symb2 );
    end
end

% Removes the trailing zeros.
symb  = symb ( isize + 1: end );
