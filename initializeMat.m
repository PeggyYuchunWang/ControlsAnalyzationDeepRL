%initialize vars to 0
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

forcearray = 0;

save('fitdata', 'p00array', 'p01array', 'p10array', 'errorarray', 'COM_x_array', 'COM_vel_x_array', 'COM_acc_x_array', 'forcearray', '-v7.3');
%whos('-file', 'fitdata.mat')