%trim down data and save
clc
clear
close all

load("fitdata.mat")

startIndex = 1;
endIndex = 89;

seg1p00array = seg1p00array(:, startIndex:endIndex);
seg1p01array = seg1p01array(:, startIndex:endIndex);
seg1p10array = seg1p10array(:, startIndex:endIndex);
seg1rmsearray = seg1rmsearray(:, startIndex:endIndex);

seg2p00array = seg2p00array(:, startIndex:endIndex);
seg2p01array = seg2p01array(:, startIndex:endIndex);
seg2p10array = seg2p10array(:, startIndex:endIndex);
seg2rmsearray = seg2rmsearray(:, startIndex:endIndex);

seg3p00array = seg3p00array(:, startIndex:endIndex);
seg3p01array = seg3p01array(:, startIndex:endIndex);
seg3p10array = seg3p10array(:, startIndex:endIndex);
seg3rmsearray = seg3rmsearray(:, startIndex:endIndex);

seg4p00array = seg4p00array(:, startIndex:endIndex);
seg4p01array = seg4p01array(:, startIndex:endIndex);
seg4p10array = seg4p10array(:, startIndex:endIndex);
seg4rmsearray = seg4rmsearray(:, startIndex:endIndex);

COM_x_array = COM_x_array(:, startIndex:endIndex);
COM_y_array = COM_y_array(:, startIndex:endIndex);
COM_vel_x_array = COM_vel_x_array(:, startIndex:endIndex);
COM_vel_y_array = COM_vel_y_array(:, startIndex:endIndex);
COM_acc_x_array = COM_acc_x_array(:, startIndex:endIndex);
COM_acc_y_array = COM_acc_y_array(:, startIndex:endIndex);

forcearray = forcearray(:, startIndex:endIndex);

foot_x_array = foot_x_array(:, startIndex:endIndex);
foot_y_array = foot_y_array(:, startIndex:endIndex);
foot_x_vel_array = foot_x_vel_array(:, startIndex:endIndex);
foot_y_vel_array = foot_y_vel_array(:, startIndex:endIndex);
foot_x_acc_array = foot_x_acc_array(:, startIndex:endIndex);
foot_y_acc_array = foot_y_acc_array(:, startIndex:endIndex);

save('fitdata2', 'seg1p00array', 'seg1p01array', 'seg1p10array', 'seg1rmsearray', 'COM_x_array', 'COM_vel_x_array', 'COM_acc_x_array', 'forcearray', 'foot_y_array','foot_y_vel_array', '-v7.3');
save('fitdata2', 'COM_y_array', 'COM_vel_y_array', 'COM_acc_y_array', 'foot_x_array', 'foot_x_vel_array', 'foot_x_acc_array', 'foot_y_acc_array', '-append');
save('fitdata2', 'seg2p00array', 'seg2p01array', 'seg2p10array', 'seg2rmsearray', 'seg3p00array', 'seg3p01array', 'seg3p10array', 'seg3rmsearray', 'seg4p00array', 'seg4p01array', 'seg4p10array', 'seg4rmsearray', '-append');
% a1=load('fitdata2.mat');
% f1=fieldnames(a1);
% a2=load('fitdata.mat');
% f2=fieldnames(a2);
% l = length(f1);
% for i = 1:l
%     a1.(f1{i}) = [a1.(f1{i}),a2.(f2{i})];
% end
% save('finaldata', '-struct', 'a1');