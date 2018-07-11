% visualize plane
% by Peggy Wang

clc
clear
close all

load("/Users/pegasus/Documents/AA93/finaldata/finaldata.mat")

%100N - 600N
index1 = 78;
index2 = 88;
index3 = 98;
index4 = 108;
index5 = 118;
index6 = 128;

% Ax + By + Cz + D = 0
% A1= seg2p10array(1, index1);
% B1 = seg2p01array(1, index1);
% C1 = -1;
% D1 = seg2p00array(1, index1);
% 
% A2= seg2p10array(1, index2);
% B2 = seg2p01array(1, index2);
% C2 = -1;
% D2 = seg2p00array(1, index2);
% 
% A3= seg2p10array(1, index3);
% B3 = seg2p01array(1, index3);
% C3 = -1;
% D3 = seg2p00array(1, index3);
% 
% A4= seg2p10array(1, index4);
% B4 = seg2p01array(1, index4);
% C4 = -1;
% D4 = seg2p00array(1, index4);
% 
% A5= seg2p10array(1, index5);
% B5 = seg2p01array(1, index5);
% C5 = -1;
% D5 = seg2p00array(1, index5);
% 
% A6= seg2p10array(1, index6);
% B6 = seg2p01array(1, index6);
% C6 = -1;
% D6 = seg2p00array(1, index6);

% A1= seg3p10array(1, index1);
% B1 = seg3p01array(1, index1);
% C1 = -1;
% D1 = seg3p00array(1, index1);
% 
% A2= seg3p10array(1, index2);
% B2 = seg3p01array(1, index2);
% C2 = -1;
% D2 = seg3p00array(1, index2);
% 
% A3= seg3p10array(1, index3);
% B3 = seg3p01array(1, index3);
% C3 = -1;
% D3 = seg3p00array(1, index3);
% 
% A4= seg3p10array(1, index4);
% B4 = seg3p01array(1, index4);
% C4 = -1;
% D4 = seg3p00array(1, index4);
% 
% A5= seg3p10array(1, index5);
% B5 = seg3p01array(1, index5);
% C5 = -1;
% D5 = seg3p00array(1, index5);
% 
% A6= seg3p10array(1, index6);
% B6 = seg3p01array(1, index6);
% C6 = -1;
% D6 = seg3p00array(1, index6);

A1= seg4p10array(1, index1);
B1 = seg4p01array(1, index1);
C1 = -1;
D1 = seg4p00array(1, index1);

A2= seg4p10array(1, index2);
B2 = seg4p01array(1, index2);
C2 = -1;
D2 = seg4p00array(1, index2);

A3= seg4p10array(1, index3);
B3 = seg4p01array(1, index3);
C3 = -1;
D3 = seg4p00array(1, index3);

A4= seg4p10array(1, index4);
B4 = seg4p01array(1, index4);
C4 = -1;
D4 = seg4p00array(1, index4);

A5= seg4p10array(1, index5);
B5 = seg4p01array(1, index5);
C5 = -1;
D5 = seg4p00array(1, index5);

A6= seg4p10array(1, index6);
B6 = seg4p01array(1, index6);
C6 = -1;
D6 = seg4p00array(1, index6);

[x, y] = meshgrid(-1:0.1:1); % Generate x and y data
z1 = -1/C1*(A1*x + B1*y + D1); % Solve for z data
f1 = surf(x,y,z1, 'FaceColor', 'r') %Plot the surface
hold on
z2 = -1/C2*(A2*x + B2*y + D2); % Solve for z data
f2 = surf(x,y,z2, 'FaceColor', 'b')
z3 = -1/C3*(A3*x + B3*y + D3); % Solve for z data
f3 = surf(x,y,z3, 'FaceColor', 'g')
z4 = -1/C4*(A4*x + B4*y + D4); % Solve for z data
f4 = surf(x,y,z4, 'FaceColor', 'c')
z5 = -1/C5*(A5*x + B5*y + D5); % Solve for z data
f5 = surf(x,y,z5, 'FaceColor', 'y')
z6 = -1/C6*(A6*x + B6*y + D6); % Solve for z data
f6 = surf(x,y,z6, 'FaceColor', 'm')

legend([f1,f2,f3, f4, f5, f6],{'100N','200N','300N', '400N', '500N', '600N'},'Location','NorthWest');