function nblocks = myqr_listBlocks

% Based on the definition in standard:
% * ISO/IEC 18004:2015 Table 9.

% Defines number of data and error blocks per version and EC level.
nblocks = [
     1  1  1  1;
     1  1  1  1;
     1  1  2  2;
     1  2  2  4;
     1  2  4  4;
     2  4  4  4;
     2  4  6  5;
     2  4  6  6;
     2  5  8  8;
     4  5  8  8;
     
     4  5  8 11;
     4  8 10 11;
     4  9 12 16;
     4  9 16 16;
     6 10 12 18;
     6 10 17 16;
     6 11 16 19;
     6 13 18 21;
     7 14 21 25;
     8 16 20 25;
     
     8 17 23 25;
     9 17 23 34;
     9 18 25 30;
    10 20 27 32;
    12 21 29 35;
    12 23 34 37;
    12 25 34 40;
    13 26 35 42;
    14 28 38 45;
    15 29 40 48;
    
    16 31 43 51;
    17 33 45 54;
    18 35 48 57;
    19 37 51 60;
    19 38 53 63;
    20 40 56 66;
    21 43 59 70;
    22 45 62 74;
    24 47 65 77;
    25 49 68 81 ];
