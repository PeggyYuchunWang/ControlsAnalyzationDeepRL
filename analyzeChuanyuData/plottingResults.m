%plotting packaged data for single simulation
%by Peggy Wang

clc
clear
close all

load("/Users/pegasus/Documents/AA93/allData/-400.mat")

pushoffset = 50;
pushBegin = 2500;
pushEnd = 2550;
startPoint = 2500;
endPoint = 3500;   

%graph for just push
force = 400;
COM_x = COM(startPoint:endPoint, 1);
startingPos = COM_x(1, 1);
l = length(COM_x);

%zero out starting position
for a = 1:l
    COM_x(a) = COM_x(a) - startingPos;
end

COM_vel_x = COM_vel(startPoint:endPoint, 1);

foot_y = Feet_pos(startPoint:endPoint, 2);
foot_vel_y = Feet_vel(startPoint:endPoint, 2);

COM_acc_x = zeros(l, 1);
foot_acc_y = zeros(l, 1);

dt = 1/500; %time step (double check)

%calculate acceleration by taking velocity/time
for a = 2:l-1
    COM_acc_x(a) = (COM_vel_x(a) - COM_vel_x(a-1))/dt ;
    foot_acc_y(a) = (foot_vel_y(a) - foot_vel_y(a-1))/dt;
end

%moving avg filter for acc
windowSize = 50; 
b = (1/windowSize)*ones(1,windowSize);
c = 1;
COM_acc_x = filter(b,c,COM_acc_x);

% currentx = COM_x(pushoffset:end, 1);
% currenty = COM_vel_x(pushoffset:end, 1);
% currentz = COM_acc_x(pushoffset:end, 1);

currentx = COM_x;
currenty = COM_vel_x;
currentz = COM_acc_x;

% currentfooty = foot_y(pushoffset:end, 1);
% currentfootyvel = foot_vel_y(pushoffset:end, 1);
% currentfootyacc = foot_acc_y(pushoffset:end, 1);

currentfooty = foot_y;
currentfootyvel = foot_vel_y;
currentfootyacc = foot_acc_y;

%max foot tilt height and index
[h, i] = max(currentfooty);

%min foot tilt height (also min velocity) and index
[v, j] = min(currentfooty);


distFoot = abs(h-v);
disp(distFoot);

if distFoot < 0.005
    j = i;
    disp("no foot tilting")
end

figure
subplot(3,1,1)
plot(currentx)
title("COM x Position, Velocity, Acceleration after push")
xlabel("Time (2ms)")
ylabel("COM x Position (m)")
subplot(3,1,2)
plot(currenty)
xlabel("Time (2ms)")
ylabel("Velocity (m/s)")
subplot(3,1,3)
plot(currentz)
xlabel("Time (2ms)")
ylabel("Acceleration (m/s^2)")

%plot foot pos, vel, acc
figure
subplot(3,1,1)
plot(currentfooty)
hold on;
scatter(pushoffset, currentfooty(pushoffset, 1), 30, 'cyan')
title("Foot y Position, Velocity, Acceleration after push")
xlabel("Time (2ms)")
ylabel("y Position (m)")
subplot(3,1,2)
plot(currentfootyvel)
xlabel("Time (2ms)")
ylabel("Velocity (m/s)")
subplot(3,1,3)
plot(currentfootyacc)
xlabel("Time (2ms)")
ylabel("Acceleration (m/s^2)")

%graph for plane
[fitresult, gof] = createFit(currentx, currenty, currentz);

%phase plot COM
figure
start_dot = scatter3(currentx(1, 1), currenty(1, 1), currentz(1,1), 300, 'blue');
hold on;
endpush_dot = scatter3(currentx(pushoffset, 1), currenty(pushoffset, 1), currentz(pushoffset,1), 300, 'cyan');
maxtilt_dot = scatter3(currentx(i, 1), currenty(i, 1), currentz(i, 1), 300, 'magenta');
minvel_dot = scatter3(currentx(j, 1), currenty(j, 1), currentz(j, 1), 300, 'green');
len = length(currentx);
end_dot = scatter3(currentx(len, 1), currenty(len, 1), currentz(len,1), 300, 'red');

plot3(currentx, currenty, currentz);
title("Phase Plot for COM after push")
xlabel('Position (m)')
ylabel('Velocity (m/s)')
zlabel('Acceleration (m/s^2)')

colour_offset = 200;
colours=colormap(parula(colour_offset +length(currentx)));
colours(1:colour_offset,:)=[];
phase_dot_size = 3;

hold on;
grid on;

transp = 0.9;
phase_lines = plot3(currentx, currenty, currentz,'Color',[transp,transp,transp]);
phase_scatter = scatter3(currentx, currenty, currentz,phase_dot_size,colours); 
colorbar('Ticks',[0,1],'TickLabels',{'Start','End'});

legend([phase_scatter,start_dot,end_dot, maxtilt_dot, minvel_dot, endpush_dot],{'Phase trajectory','Starting point','End Point', 'Max Tilt', 'End Foot Tilt', 'End Push'},'Location','NorthWest')
hold off;

figure
start_line = plot3(currentx(1:pushoffset, 1), currenty(1:pushoffset, 1), currentz(1:pushoffset, 1), 'blue');
title("Phase Plot for COM")
xlabel('Position (m)')
ylabel('Velocity (m/s)')
zlabel('Acceleration (m/s^2)')
grid on;
hold on;
pushend_line = plot3(currentx(pushoffset:i, 1), currenty(pushoffset:i, 1), currentz(pushoffset:i, 1), 'green');
maxtilt_line = plot3(currentx(i:j, 1), currenty(i:j, 1), currentz(i:j, 1), 'magenta');
mintilt_line = plot3(currentx(j:end, 1), currenty(j:end, 1), currentz(j:end, 1), 'black');

legend([start_line,pushend_line,maxtilt_line, mintilt_line],{'Push','Foot Tilt','Foot Down', 'Settle'},'Location','NorthWest')