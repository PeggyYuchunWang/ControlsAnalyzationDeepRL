%plotting packaged data for single simulation
%by Peggy Wang

clc
clear
close all

load("/Users/pegasus/Documents/AA93/allData/400.mat")

timearray = zeros(5000,1);
for t = 1:length(timearray)
    timearray(t, 1) = .002 * t;
end

pushoffset = 50;
pushBegin = 2500;
pushEnd = 2550;
startPoint = 2500;
endPoint = 3500;

currenttime = timearray(startPoint:endPoint, 1);

%graph for just push
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

dt = 1/500; %time step

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
    i = pushoffset;
    j = i;
    disp("no foot tilting")
end

figure
subplot(3,1,1)
plot(currenttime, currentx)
hold on;
title("COM x Position, Velocity, Acceleration after push");
tilt_max = scatter(currenttime(i, 1), currentx(i, 1), 30, 'magenta');
tilt_done = scatter(currenttime(j, 1), currentx(j, 1), 30, 'green');
push_done = scatter(currenttime(pushoffset, 1), currentx(pushoffset, 1), 30, 'cyan');
legend([push_done, tilt_max, tilt_done],{'Push Done','Foot Tilt Max Height','Tilt Done'},'Location','NorthWest')
xlabel("Time (s)")
ylabel("COM x Position (m)")

subplot(3,1,2)
plot(currenttime, currenty)
hold on;
scatter(currenttime(i, 1), currenty(i, 1), 30, 'magenta')
scatter(currenttime(j, 1), currenty(j, 1), 30, 'green')
scatter(currenttime(pushoffset, 1), currenty(pushoffset, 1), 30, 'cyan')
xlabel("Time (s)")
ylabel("Velocity (m/s)")

subplot(3,1,3)
plot(currenttime, currentz)
hold on;
scatter(currenttime(i, 1), currentz(i, 1), 30, 'magenta')
scatter(currenttime(j, 1), currentz(j, 1), 30, 'green')
scatter(currenttime(pushoffset, 1), currentz(pushoffset, 1), 30, 'cyan')
xlabel("Time (s)")
ylabel("Acceleration (m/s^2)")

%plot foot pos, vel, acc
figure
subplot(3,1,1)
plot(currenttime, currentfooty)
hold on;
maxtilt = scatter(currenttime(i, 1), currentfooty(i, 1), 30, 'magenta');
donetilt = scatter(currenttime(j, 1), currentfooty(j, 1), 30, 'green');
push = scatter(currenttime(pushoffset, 1), currentfooty(pushoffset, 1), 30, 'cyan');
title("Foot y Position, Velocity, Acceleration after push")
legend([push, maxtilt, donetilt],{'Push Done','Foot Tilt Max Height','Tilt Done'},'Location','NorthWest')
xlabel("Time (s)")
ylabel("y Position (m)")

subplot(3,1,2)
plot(currenttime, currentfootyvel)
hold on;
scatter(currenttime(i, 1), currentfootyvel(i, 1), 30, 'magenta')
scatter(currenttime(j, 1), currentfootyvel(j, 1), 30, 'green')
scatter(currenttime(pushoffset, 1), currentfootyvel(pushoffset, 1), 30, 'cyan')
xlabel("Time (s)")
ylabel("Velocity (m/s)")

subplot(3,1,3)
plot(currenttime, currentfootyacc)
hold on;
scatter(currenttime(i, 1), currentfootyacc(i, 1), 30, 'magenta')
scatter(currenttime(j, 1), currentfootyacc(j, 1), 30, 'green')
scatter(currenttime(pushoffset, 1), currentfootyacc(pushoffset, 1), 30, 'cyan')
xlabel("Time (s)")
ylabel("Acceleration (m/s^2)")

%graph for plane, uncomment to show graph
%[fitresult, gof] = createFit(currentx, currenty, currentz);

%phase plot COM
figure
start_dot = scatter3(currentx(1, 1), currenty(1, 1), currentz(1,1), 300, 'blue');
hold on;
maxtilt_dot = scatter3(currentx(i, 1), currenty(i, 1), currentz(i, 1), 300, 'magenta');
minvel_dot = scatter3(currentx(j, 1), currenty(j, 1), currentz(j, 1), 300, 'green');
endpush_dot = scatter3(currentx(pushoffset, 1), currenty(pushoffset, 1), currentz(pushoffset,1), 300, 'cyan');
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
start_line = plot3(currentx(1:pushoffset, 1), currenty(1:pushoffset, 1), currentz(1:pushoffset, 1), 'blue', 'Linewidth',3);
title("Phase Plot for COM")
xlabel('Position (m)')
ylabel('Velocity (m/s)')
zlabel('Acceleration (m/s^2)')
grid on;
hold on;
pushend_line = plot3(currentx(pushoffset:i, 1), currenty(pushoffset:i, 1), currentz(pushoffset:i, 1), 'green', 'Linewidth',3);
maxtilt_line = plot3(currentx(i:j, 1), currenty(i:j, 1), currentz(i:j, 1), 'magenta', 'Linewidth',3);
mintilt_line = plot3(currentx(j:end, 1), currenty(j:end, 1), currentz(j:end, 1), 'black', 'Linewidth',3);

legend([start_line,pushend_line,maxtilt_line, mintilt_line],{'Push','Foot Tilt','Foot Down', 'Settle'},'Location','NorthWest');

figure
start_line = plot3(currentx(1:pushoffset, 1), currenty(1:pushoffset, 1), currentfooty(1:pushoffset, 1), 'blue', 'Linewidth',2);
title("Phase Plot with Foot Tilt Height")
xlabel('Position (m)')
ylabel('Velocity (m/s)')
zlabel('Foot Height (m)')
grid on;
hold on;
pushend_line = plot3(currentx(pushoffset:i, 1), currenty(pushoffset:i, 1), currentfooty(pushoffset:i, 1), 'green', 'Linewidth',2);
maxtilt_line = plot3(currentx(i:j, 1), currenty(i:j, 1), currentfooty(i:j, 1), 'magenta', 'Linewidth',2);
mintilt_line = plot3(currentx(j:end, 1), currenty(j:end, 1), currentfooty(j:end, 1), 'black', 'Linewidth',2);

legend([start_line,pushend_line,maxtilt_line, mintilt_line],{'Push','Foot Tilt','Foot Down', 'Settle'},'Location','NorthWest');

%% trying to fit lines
segment1x = currentx(1:pushoffset, 1);
segment1y = currenty(1:pushoffset, 1);
segment1z = currentz(1:pushoffset, 1);
segment2x = currentx(pushoffset:i, 1);
segment2y = currenty(pushoffset:i, 1);
segment2z = currentz(pushoffset:i, 1);
segment3x = currentx(i:j, 1);
segment3y = currenty(i:j, 1);
segment3z = currentz(i:j, 1);
segment4x = currentx(j:end, 1);
segment4y = currenty(j:end, 1);
segment4z = currentz(j:end, 1);

figure
plot3(segment1x, segment1y, segment1z, 'Linewidth',2);
title("Push segment")
xlabel("position")
ylabel("velocity")
zlabel("acceleration")

[fitresult1, gof] = createFit1(segment1x, segment1y, segment1z);
z1 = fitresult1.p00 + fitresult1.p10.*segment1x + fitresult1.p01*segment1y;
rmse = sqrt(sum((segment1z - z1).^2));
disp("segment1");
disp(rmse);

[x1, x2] = size(segment2x);
if x1 > 3
    figure
    plot3(segment2x, segment2y, segment2z, 'Linewidth',2);
    title("Tilt Up")
    xlabel("position")
    ylabel("velocity")
    zlabel("acceleration")
    [fitresult2, gof] = createFit2(segment2x, segment2y, segment2z);
    z2 = fitresult2.p00 + fitresult2.p10.*segment2x + fitresult2.p01*segment2y;
    rmse = sqrt(sum((segment2z - z2).^2));
    figure
    plot([segment2z, z2]);
    disp("segment2");
    disp(rmse);
end


[x1, x2] = size(segment3x);
if x1 > 3
    figure
    plot3(segment3x, segment3y, segment3z, 'Linewidth',2);    
    title("Tilt Down");
    xlabel("position");
    ylabel("velocity");
    zlabel("acceleration");
    [fitresult3, gof] = createFit3(segment3x, segment3y, segment3z);
    z3 = fitresult3.p00 + fitresult3.p10.*segment3x + fitresult3.p01*segment3y;
    rmse = sqrt(sum((segment3z - z3).^2));
    figure
    plot([segment3z, z3]);
    disp("segment3");
    disp(rmse);
end

figure
plot3(segment4x, segment4y, segment4z, 'Linewidth',2);
title("Settle")
xlabel("position")
ylabel("velocity")
zlabel("acceleration")
[fitresult4, gof] = createFit4(segment4x, segment4y, segment4z);
z4 = fitresult4.p00 + fitresult4.p10.*segment4x + fitresult4.p01*segment4y;
rmse = sqrt(sum((segment4z - z4).^2));
figure
plot([segment4z, z4]);
disp("segment4");
disp(rmse);

circlex = zeros(201, 1);
circley = zeros(201, 1);
for i=1:100
    circlex(i,1) = -1.02 + .02 * i;
    circley(i,1) = -sqrt(1-circlex(i,1)^2);
end
for i=101:201
    circlex(i,1) = 1.02 - .02 * (i-100);
    circley(i,1) = sqrt(1-circlex(i,1)^2);
end
figure
plot(circlex, circley)

% figure
% plot(currenttime, Feet_pos(startPoint:endPoint, 1), 'Linewidth',2);
% title("Foot x position");
% xlabel("Time (s)")
% ylabel("Foot x Position (m)")
% slideDist = max(Feet_pos(startPoint:endPoint, 1)) - min(Feet_pos(startPoint:endPoint, 1));
% disp(slideDist);