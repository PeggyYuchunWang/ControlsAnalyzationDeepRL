%trim down data and save
clc
clear
close all

load("/Users/pegasus/Documents/AA93/analyzeChuanyuData/fitdata.mat")

startIndex = 1;
endIndex = 97;

p00array = p00array(:, startIndex:endIndex);
p01array = p01array(:, startIndex:endIndex);
p10array = p10array(:, startIndex:endIndex);
errorarray = errorarray(:, startIndex:endIndex);

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

save('fitdata', 'p00array', 'p01array', 'p10array', 'errorarray', 'COM_x_array', 'COM_vel_x_array', 'COM_acc_x_array', 'forcearray', 'foot_y_array','foot_y_vel_array', '-v7.3');
save('fitdata', 'COM_y_array', 'COM_vel_y_array', 'COM_acc_y_array', 'foot_x_array', 'foot_x_vel_array', 'foot_x_acc_array', 'foot_y_acc_array', '-append');