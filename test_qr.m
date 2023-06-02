clc
clear
close all


% Adds the functions folder to the path.
addpath ( sprintf ( '%s/functions_qr', pwd ) );


% Sets the QR version and error corection level.
% The version determines the size of the QR matrix.
% If an icon is added, higher EC levels (H or 4) should be used.
version = 3;
level   = 4;


% Sets the message.
msg     = 'https://meg.ucm.es/';


% Generates the QR matrix.
QRcode  = myqr_generateQR ( msg, level, version );


% Loads the icon.
icon    = imread ( 'miniC3N.png' );

% Padds the logo to make it square.
ih      = size ( icon, 1 );
iw      = size ( icon, 2 );
isize   = max ( ih, iw );
padd    = 255 * ones ( floor ( ( isize - ih ) / 2 ), iw, 3 );
icon    = cat ( 1, padd, icon, padd );
padd    = 255 * ones ( isize, floor ( ( isize - iw ) / 2 ), 3 );
icon    = cat ( 2, padd, icon, padd );


% Gets the size of the QR matrix.
msize   = size ( QRcode, 1 );

% Defines the logo region as 45% of the QR or leaving 9 px at each side.
isize   = floor ( ( msize - 8 ) * 0.45 );
isize   = min ( isize, msize - 26 );
isize   = 2 * ceil ( isize / 2 ) - 1;

% Blanks the logo region.
off     = ( msize - isize ) / 2;
QRcode ( off + ( 1: isize ), off + ( 1: isize ) ) = false;


% Adds a 1% of the QR padding to the logo.
isize   = isize - ( msize - 8 ) * 0.01;


% Creates the figure and the axes.
figure ( 'Units', 'centimeters', 'Position', [  0  1 15 15 ] )
axes ( ...
    'Units', 'centimeters', ...
    'Position', [  0  0 15 15 ], ...
    'XLim', [ 0.5 msize + 0.5 ], ...
    'YLim', [ 0.5 msize + 0.5 ], ...
    'YDir', 'reverse', ...
    'NextPlot', 'add' )
axis equal off

% Plots the (blanked) QR code.
imagesc ( QRcode, [ 0 1 ] );
colormap ( [ 1 1 1; 0 0 0 ] );

% Plots the icon in the center.
off     = ( msize - isize ) / 2;
image ( icon, 'XData', off + [ 1 isize ], 'YData', off + [ 1 isize ] );


% Saves the QR code as a PNG figure.
print ( '-dpng', '-r150', 'QR code test.png' )
