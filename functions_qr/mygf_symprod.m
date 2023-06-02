function symb = mygf_symprod ( symb1, symb2, prime )

% Multiplication inside a Galois field.


% Defines the default field primitive polynomial.
if nargin < 3
    prime = [ 1 0 0 0 1 1 1 0 1 ]';
end


% Gets the symbol multiplication by a convolution (much faster).
% symb  = conv ( symb1, symb2 );
symb  = conv2 ( symb1, symb2 );

% Replaces the additions by XOR.
symb  = rem ( symb, 2 ) == 1;


% % Reserves memory for the convolution.
% symb  = false ( size1 + size2 - 1, 1 );
% 
% % Iterates through the first symbol.
% for index = find ( bits1' )
%     
%     % XORs the shifted word with the product.
%     hits  = index + ( 1: size2 ) - 1;
%     symb ( hits ) = xor ( symb ( hits ), symb2 );
% end


% Gets the remainder of the division by the field primitive polynomial.
symb  = mygf_symrem ( symb, prime );
