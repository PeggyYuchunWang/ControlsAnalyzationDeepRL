% analysis, run after phaseScript.m to remove initialization zero
% placeholders
% by Peggy Wang
clc
clear
close all

load("fitdata.mat")
m = matfile('fitdata.mat','Writable',true);
p00array = m.p00array(1,2:end);
p01array = m.p01array(1,2:end);
p10array = m.p10array(1,2:end);
errorarray = m.errorarray(1,2:end);

COM_x_array = m.COM_x_array(:,2:end);
COM_vel_x_array = m.COM_vel_x_array(:,2:end);
COM_acc_x_array = m.COM_acc_x_array(:,2:end);

forcearray = m.forcearray(:, 2:end);

COM_y_array = m.COM_y_array(:,2:end);
COM_vel_y_array = m.COM_vel_y_array(:,2:end);
COM_acc_y_array = m.COM_acc_y_array(:,2:end);

foot_y_array = m.foot_y_array(:, 2:end);
foot_y_vel_array = m.foot_y_vel_array(:, 2:end);

foot_x_array = m.foot_x_array(:, 2:end);
foot_x_vel_array = m.foot_x_vel_array(:, 2:end);

foot_x_acc_array = m.foot_x_acc_array(:, 2:end);
foot_y_acc_array = m.foot_y_acc_array(:, 2:end);

meanerror = mean(errorarray);
meanp00 = mean(p00array);
meanp01 = mean(p01array);
meanp10 = mean(p10array);

%uncomment to update file
save('finaldata', 'p00array', 'p01array', 'p10array', 'errorarray', 'COM_x_array', 'COM_vel_x_array', 'COM_acc_x_array', 'forcearray', 'foot_y_array','foot_y_vel_array', '-v7.3');
save('finaldata', 'meanerror', 'meanp00', 'meanp01', 'meanp10', 'COM_y_array', 'COM_vel_y_array', 'COM_acc_y_array', 'foot_x_array', 'foot_x_vel_array', 'foot_x_acc_array', 'foot_y_acc_array', '-append');
%whos('-file', 'finaldata.mat')