% analysis
% by Peggy Wang
clc
clear
close all

load("/Users/pegasus/Documents/AA93/fitdata.mat")
m = matfile('fitdata.mat','Writable',true);
p00array = m.p00array(1,2:end);
p01array = m.p01array(1,2:end);
p10array = m.p10array(1,2:end);
errorarray = m.errorarray(1,2:end);

COM_x_array = m.COM_x_array(:,2:end);
COM_vel_x_array = m.COM_vel_x_array(:,2:end);
COM_acc_x_array = m.COM_acc_x_array(:,2:end);
forcearray = m.forcearray(:, 2:end);

meanerror = mean(errorarray);
meanp00 = mean(p00array);
meanp01 = mean(p01array);
meanp10 = mean(p10array);

save('finaldata', 'p00array', 'p01array', 'p10array', 'errorarray', 'COM_x_array', 'COM_vel_x_array', 'COM_acc_x_array', 'forcearray', '-v7.3');
save('finaldata', 'meanerror', 'meanp00', 'meanp01', 'meanp10', '-append');
%whos('-file', 'finaldata.mat')