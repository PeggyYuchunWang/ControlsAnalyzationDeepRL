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

%record footy position - default [-1.01741148291964], figure out what else
forcearray = 0;
footy_array = zeros(1001, 1);

%uncomment to initialize file
save('fitdata', 'p00array', 'p01array', 'p10array', 'errorarray', 'COM_x_array', 'COM_vel_x_array', 'COM_acc_x_array', 'forcearray', 'footy_array', '-v7.3');
%whos('-file', 'fitdata.mat')