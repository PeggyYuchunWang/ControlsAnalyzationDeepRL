% plot phase graph of COM x position, velocity, acceleration, can save data
% into mat file in loop
% By Peggy Wang
% make/change colors for start and end
% double check timestep and acceleration (each timestep = ? seconds)

% assume x is first element of array
clc
clear
close all

load("/Users/pegasus/Documents/AA93/DDPG_PD_3/2017_06_23_16.55.02/no_force/run_log.mat")
pushBegin = 2500;
pushEnd = 2550;
startPoint = 2500;
endPoint = 3500;

%graph for just push
force = force(1,1);
COM_x = COM(startPoint:endPoint, 1);
startingPos = COM_x(1, 1);
l = length(COM_x);

%zero out starting position
for a = 1:l
    COM_x(a) = COM_x(a) - startingPos;
end
COM_vel_x = COM_vel(startPoint:endPoint, 1);

COM_acc_x = zeros(l, 1);

dt = 1/500; %time step (double check)

%calculate acceleration by taking velocity/time
for a = 2:l-1
    COM_acc_x(a) = (COM_vel_x(a) - COM_vel_x(a-1))/dt ;
end

%moving avg filter for acc
windowSize = 20; 
b = (1/windowSize)*ones(1,windowSize);
c = 1;
COM_acc_x = filter(b,c,COM_acc_x);

footy = Feet_pos(startPoint:endPoint, 2);
footvel = Feet_vel(startPoint:endPoint, 2);

%uncomment to show graphs
% plot3(COM_x, COM_vel_x, COM_acc_x);
% hold on
% scatter3([COM_x(1, 1)], [COM_vel_x(1, 1)], [COM_acc_x(1,1)], 30, 'red')
% scatter3([COM_x(50, 1)], [COM_vel_x(50, 1)], [COM_acc_x(50,1)], 50, 'green')
% scatter3([COM_x(l-500, 1)], [COM_vel_x(l-500, 1)], [COM_acc_x(l-500,1)], 500, 'green')
% xlabel('position')
% ylabel('velocity')
% zlabel('acceleration')

% figure
% subplot(3,1,1)
% plot(COM_x)
% subplot(3,1,2)
% plot(COM_vel_x)
% subplot(3,1,3)
% plot(COM_acc_x)
% graph for all
% 
[fitresult, gof] = createFit(COM_x, COM_vel_x, COM_acc_x);

p00 = fitresult.p00;
p10 = fitresult.p10;
p01 = fitresult.p01;
totalerror = 0;

for i = 1:l
    zorig = COM_acc_x(i, 1);
    zfit = p00 + COM_x(i, 1) * p10 + p01*COM_vel_x(i, 1);
    totalerror = totalerror + abs(zorig - zfit);
end

error = totalerror/l;

%uncomment to save to file
m = matfile('fitdata.mat','Writable',true);
newp00array = p00;
newp01array = p01;
newp10array = p10;
newerrorarray = error;

p00array = cat(2, m.p00array, newp00array);
p01array = cat(2, m.p01array, newp01array);
p10array = cat(2, m.p10array, newp10array);
errorarray = cat(2, m.errorarray, newerrorarray);

COM_x_array = cat(2, m.COM_x_array, COM_x);
COM_vel_x_array = cat(2, m.COM_vel_x_array, COM_vel_x);
COM_acc_x_array = cat(2, m.COM_acc_x_array, COM_acc_x);

forcearray = cat(2, m.forcearray, force);

footy_array = cat(2, m.footy_array, footy);
footvel_array = cat(2, m.footvel_array, footvel);

save('fitdata', 'p00array', 'p01array', 'p10array', 'errorarray', 'COM_x_array', 'COM_vel_x_array', 'COM_acc_x_array', 'forcearray','footy_array', 'footvel_array', '-v7.3');
%whos('-file', 'fitdata.mat')