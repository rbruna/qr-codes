function genpol = myqr_getGenPol ( order )

% Creates a generative polynomial of the desired order.

% Based on:
% * https://en.wikiversity.org/wiki/Reed%E2%80%93Solomon_codes_for_coders#RS_encoding
%   by an unknown author.


% Intializes the generative polinomial to the 8-bit for 1.
genpol  = false ( 8, 1 );
genpol ( 8 ) = true;

% Generates the polynomial by convolution.
for i = 1: order
    
    % Generates the new polynomial.
    newpol  = false ( i, 2 );
    newpol ( 1, 2 ) = true;
    newpol ( i, 1 ) = true;
    
    % Multiplies both polynomials.
    genpol  = mygf_wordprod ( genpol, newpol );
end
