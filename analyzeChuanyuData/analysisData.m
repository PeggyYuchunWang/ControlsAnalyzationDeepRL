% analysis, run after phaseScript.m to remove initialization zero
% placeholders
% by Peggy Wang
clc
clear
close all

load("fitdata.mat")
m = matfile('fitdata.mat','Writable',true);
seg1p00array = m.seg1p00array(1,2:end);
seg1p01array = m.seg1p01array(1,2:end);
seg1p10array = m.seg1p10array(1,2:end);
seg1rmsearray = m.seg1rmsearray(1,2:end);

seg2p00array = m.seg2p00array(1,2:end);
seg2p01array = m.seg2p01array(1,2:end);
seg2p10array = m.seg2p10array(1,2:end);
seg2rmsearray = m.seg2rmsearray(1,2:end);

seg3p00array = m.seg3p00array(1,2:end);
seg3p01array = m.seg3p01array(1,2:end);
seg3p10array = m.seg3p10array(1,2:end);
seg3rmsearray = m.seg3rmsearray(1,2:end);

seg4p00array = m.seg4p00array(1,2:end);
seg4p01array = m.seg4p01array(1,2:end);
seg4p10array = m.seg4p10array(1,2:end);
seg4rmsearray = m.seg4rmsearray(1,2:end);

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

%uncomment to update file
save('finaldata', 'seg1p00array', 'seg1p01array', 'seg1p10array', 'seg1rmsearray', 'COM_x_array', 'COM_vel_x_array', 'COM_acc_x_array', 'forcearray', 'foot_y_array','foot_y_vel_array', '-v7.3');
save('finaldata', 'COM_y_array', 'COM_vel_y_array', 'COM_acc_y_array', 'foot_x_array', 'foot_x_vel_array', 'foot_x_acc_array', 'foot_y_acc_array', '-append');
save('fitdata', 'seg2p00array', 'seg2p01array', 'seg2p10array', 'seg2rmsearray', 'seg3p00array', 'seg3p01array', 'seg3p10array', 'seg3rmsearray', 'seg4p00array', 'seg4p01array', 'seg4p10array', 'seg4rmsearray', '-append');
whos('-file', 'finaldata.mat')