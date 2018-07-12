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

segment = 5;
%Ax + By + Cz + D = 0

if segment == 1
    A1= seg1p10array(1, index1);
    B1 = seg1p01array(1, index1);
    C1 = -1;
    D1 = seg1p00array(1, index1);

    A2= seg1p10array(1, index2);
    B2 = seg1p01array(1, index2);
    C2 = -1;
    D2 = seg1p00array(1, index2);

    A3= seg1p10array(1, index3);
    B3 = seg1p01array(1, index3);
    C3 = -1;
    D3 = seg1p00array(1, index3);

    A4= seg1p10array(1, index4);
    B4 = seg1p01array(1, index4);
    C4 = -1;
    D4 = seg1p00array(1, index4);

    A5= seg1p10array(1, index5);
    B5 = seg1p01array(1, index5);
    C5 = -1;
    D5 = seg1p00array(1, index5);

    A6= seg1p10array(1, index6);
    B6 = seg1p01array(1, index6);
    C6 = -1;
    D6 = seg1p00array(1, index6);

elseif segment == 2
    A1= seg2p10array(1, index1);
    B1 = seg2p01array(1, index1);
    C1 = -1;
    D1 = seg2p00array(1, index1);

    A2= seg2p10array(1, index2);
    B2 = seg2p01array(1, index2);
    C2 = -1;
    D2 = seg2p00array(1, index2);

    A3= seg2p10array(1, index3);
    B3 = seg2p01array(1, index3);
    C3 = -1;
    D3 = seg2p00array(1, index3);

    A4= seg2p10array(1, index4);
    B4 = seg2p01array(1, index4);
    C4 = -1;
    D4 = seg2p00array(1, index4);

    A5= seg2p10array(1, index5);
    B5 = seg2p01array(1, index5);
    C5 = -1;
    D5 = seg2p00array(1, index5);

    A6= seg2p10array(1, index6);
    B6 = seg2p01array(1, index6);
    C6 = -1;
    D6 = seg2p00array(1, index6);
elseif segment == 3
    A1= seg3p10array(1, index1);
    B1 = seg3p01array(1, index1);
    C1 = -1;
    D1 = seg3p00array(1, index1);

    A2= seg3p10array(1, index2);
    B2 = seg3p01array(1, index2);
    C2 = -1;
    D2 = seg3p00array(1, index2);

    A3= seg3p10array(1, index3);
    B3 = seg3p01array(1, index3);
    C3 = -1;
    D3 = seg3p00array(1, index3);

    A4= seg3p10array(1, index4);
    B4 = seg3p01array(1, index4);
    C4 = -1;
    D4 = seg3p00array(1, index4);

    A5= seg3p10array(1, index5);
    B5 = seg3p01array(1, index5);
    C5 = -1;
    D5 = seg3p00array(1, index5);

    A6= seg3p10array(1, index6);
    B6 = seg3p01array(1, index6);
    C6 = -1;
    D6 = seg3p00array(1, index6);

elseif segment == 4
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

elseif segment == 5
    A1= seg5p10array(1, index1);
    B1 = seg5p01array(1, index1);
    C1 = -1;
    D1 = seg5p00array(1, index1);

    A2= seg5p10array(1, index2);
    B2 = seg5p01array(1, index2);
    C2 = -1;
    D2 = seg5p00array(1, index2);

    A3= seg5p10array(1, index3);
    B3 = seg5p01array(1, index3);
    C3 = -1;
    D3 = seg5p00array(1, index3);

    A4= seg5p10array(1, index4);
    B4 = seg5p01array(1, index4);
    C4 = -1;
    D4 = seg5p00array(1, index4);

    A5= seg5p10array(1, index5);
    B5 = seg5p01array(1, index5);
    C5 = -1;
    D5 = seg5p00array(1, index5);

    A6 = seg5p10array(1, index6);
    B6 = seg5p01array(1, index6);
    C6 = -1;
    D6 = seg5p00array(1, index6);
end

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

circlex = zeros(201, 1);
circley = zeros(201, 1);
for i=1:100
    circlex(i,1) = -1.02 + .02 * i;
    circley(i,1) = -sqrt(1-circlex(i,1)^2);
end
for i=101:201
    circlex(i,1) = 1.02 - .02 * (i-100);
    circley(i,1) = sqrt(1-circlex(i,1)^2);
end
% figure
% plot(circlex, circley);
circle1z = seg1p00array(1, index1) + seg5p10array(1, index1) * circlex + seg5p01array(1, index1) * circley;
figure
c1 = plot3(circlex, circley, circle1z, 'Linewidth',2 );
hold on;
circle2z = seg2p00array(1, index2) + seg2p10array(1, index2) * circlex + seg2p01array(1, index2) * circley;
c2 = plot3(circlex, circley, circle2z, 'Linewidth',2 );
circle3z = seg3p00array(1, index3) + seg3p10array(1, index3) * circlex + seg3p01array(1, index3) * circley;
c3 = plot3(circlex, circley, circle3z, 'Linewidth',2 );
circle4z = seg4p00array(1, index4) + seg4p10array(1, index4) * circlex + seg4p01array(1, index4) * circley;
c4 = plot3(circlex, circley, circle4z, 'Linewidth',2 );
circle5z = seg5p00array(1, index5) + seg5p10array(1, index5) * circlex + seg5p01array(1, index5) * circley;
c5 = plot3(circlex, circley, circle5z, 'Linewidth',2 );
% circle6z = seg6p00array(1, index6) + seg6p10array(1, index6) * circlex + seg6p01array(1, index6) * circley;
% c6 = plot3(circlex, circley, circle6z);

legend([c1,c2,c3, c4, c5],{'100N','200N','300N', '400N', '500N', '600N'},'Location','NorthWest');

P = [1, 0, 0; 0, 1, 0; 0, 0, 0];

points1 = [circlex, circley, circle1z].';
transform1 = mtimes(P, points1);
trans1x = transform1(1, :);
trans1y = transform1(2, :);
trans1z = transform1(3, :);

points2 = [circlex, circley, circle2z].';
transform2 = mtimes(P, points2);
trans2x = transform2(1, :);
trans2y = transform2(2, :);
trans2z = transform2(3, :);

points3 = [circlex, circley, circle3z].';
transform3 = mtimes(P, points3);
trans3x = transform3(1, :);
trans3y = transform3(2, :);
trans3z = transform3(3, :);

points4 = [circlex, circley, circle4z].';
transform4 = mtimes(P, points4);
trans4x = transform4(1, :);
trans4y = transform4(2, :);
trans4z = transform4(3, :);

points5 = [circlex, circley, circle5z].';
transform5 = mtimes(P, points5);
trans5x = transform5(1, :);
trans5y = transform5(2, :);
trans5z = transform5(3, :);

% points6 = [circlex, circley, circle6z].';
% transform6 = mtimes(P, points6);
% trans6x = transform6(1, :);
% trans6y = transform6(2, :);
% trans6z = transform6(3, :);

figure
t1 = plot3(trans1x, trans1y, trans1z, 'Linewidth',2 );
hold on;
t2 = plot3(trans2x, trans2y, trans2z, 'Linewidth',2 );
t3 = plot3(trans3x, trans3y, trans3z, 'Linewidth',2 );
t4 = plot3(trans4x, trans4y, trans4z, 'Linewidth',2 );
t5 = plot3(trans5x, trans5y, trans5z, 'Linewidth',2 );
%t6 = plot3(trans6x, trans6y, trans6z);

%legend([t1,t2,t3, t4, t5],{'100N','200N','300N', '400N', '500N'},'Location','NorthWest');