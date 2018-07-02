%initialize vars to zero, placeholder, always run first
%by Peggy Wang
clc
clear
close all

p00array = 0;
p01array = 0;
p10array = 0;
errorarray = 0;
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
save('fitdata', 'p00array', 'p01array', 'p10array', 'errorarray', 'COM_x_array', 'COM_vel_x_array', 'COM_acc_x_array', 'forcearray', 'foot_y_array', '-v7.3');
save('fitdata', 'COM_y_array', 'COM_vel_y_array', 'COM_acc_y_array', 'forcearray', 'foot_x_array', 'foot_y_vel_array', 'foot_x_vel_array','foot_y_acc_array', 'foot_x_acc_array', '-append');
%whos('-file', 'fitdata.mat')