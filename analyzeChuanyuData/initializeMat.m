%initialize vars to zero, placeholder, always run first
%by Peggy Wang
clc
clear
close all

seg1p00array = 0;
seg1p01array = 0;
seg1p10array = 0;
seg1rmsearray = 0;

seg2p00array = 0;
seg2p01array = 0;
seg2p10array = 0;
seg2rmsearray = 0;

seg3p00array = 0;
seg3p01array = 0;
seg3p10array = 0;
seg3rmsearray = 0;

seg4p00array = 0;
seg4p01array = 0;
seg4p10array = 0;
seg4rmsearray = 0;

seg5p00array = 0;
seg5p01array = 0;
seg5p10array = 0;
seg5rmsearray = 0;

COM_x_array = zeros(1001, 1);
COM_vel_x_array = zeros(1001, 1);
COM_acc_x_array = zeros(1001, 1);

COM_y_array = zeros(1001, 1);
COM_vel_y_array = zeros(1001, 1);
COM_acc_y_array = zeros(1001, 1);

%record footy position
forcearray = 0;
foot_y_array = zeros(1001, 1);
foot_x_array = zeros(1001, 1);
foot_y_vel_array = zeros(1001, 1);
foot_x_vel_array = zeros(1001, 1);
foot_y_acc_array = zeros(1001, 1);
foot_x_acc_array = zeros(1001, 1);

%uncomment to initialize file
save('fitdata', 'seg1p00array', 'seg1p01array', 'seg1p10array', 'seg1rmsearray', 'COM_x_array', 'COM_vel_x_array', 'COM_acc_x_array', 'forcearray', 'foot_y_array', '-v7.3');
save('fitdata', 'COM_y_array', 'COM_vel_y_array', 'COM_acc_y_array', 'forcearray', 'foot_x_array', 'foot_y_vel_array', 'foot_x_vel_array','foot_y_acc_array', 'foot_x_acc_array', '-append');
save('fitdata', 'seg2p00array', 'seg2p01array', 'seg2p10array', 'seg2rmsearray', 'seg3p00array', 'seg3p01array', 'seg3p10array', 'seg3rmsearray', 'seg4p00array', 'seg4p01array', 'seg4p10array', 'seg4rmsearray', 'seg5p00array', 'seg5p01array', 'seg5p10array', 'seg5rmsearray', '-append');
%whos('-file', 'fitdata.mat')