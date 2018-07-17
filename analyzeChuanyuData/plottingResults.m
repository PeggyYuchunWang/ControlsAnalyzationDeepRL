%plotting packaged data for single simulation
%by Peggy Wang

clc
clear
close all

load("../allData/400.mat")

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
COM_x = COM_x - startingPos;
l = length(COM_x);

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
windowSize = 15;
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

currentfooty = foot_y - foot_y(1, 1);
currentfootyvel = foot_vel_y;
currentfootyacc = foot_acc_y;

%max foot tilt height and index
h = max(currentfooty);

plateau = find(currentfooty > h-.002 & currentfooty < h+.002);
i = min(plateau);
k = max(plateau);

%min foot tilt height (also min velocity) and index
[v, j] = min(currentfooty);

distFoot = abs(h-v);
disp(distFoot);

if distFoot < 0.005
    i = pushoffset;
    j = i;
    k = i;
    disp("no foot tilting")
end

figure
subplot(3,1,1)
plot(currenttime, currentx)
hold on;
title("COM x Position, Velocity, Acceleration after push");
tilt_max = scatter(currenttime(i, 1), currentx(i, 1), 30, 'magenta');
tilt_plateau = scatter(currenttime(k, 1), currentx(k, 1), 30, 'blue');
tilt_done = scatter(currenttime(j, 1), currentx(j, 1), 30, 'green');
push_done = scatter(currenttime(pushoffset, 1), currentx(pushoffset, 1), 30, 'cyan');
legend([push_done, tilt_max, tilt_plateau, tilt_done],{'Push Done','Foot Tilt Max Height', 'Foot Tilt Max Plateau', 'Tilt Done'},'Location','NorthWest')
xlabel("Time (s)")
ylabel("COM x Position (m)")

subplot(3,1,2)
plot(currenttime, currenty)
hold on;
scatter(currenttime(i, 1), currenty(i, 1), 30, 'magenta')
scatter(currenttime(k, 1), currenty(k, 1), 30, 'blue')
scatter(currenttime(j, 1), currenty(j, 1), 30, 'green')
scatter(currenttime(pushoffset, 1), currenty(pushoffset, 1), 30, 'cyan')
xlabel("Time (s)")
ylabel("Velocity (m/s)")

subplot(3,1,3)
plot(currenttime, currentz)
hold on;
scatter(currenttime(i, 1), currentz(i, 1), 30, 'magenta')
scatter(currenttime(k, 1), currentz(k, 1), 30, 'blue')
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
tiltplat = scatter(currenttime(k, 1), currentfooty(k, 1), 30, 'blue');
donetilt = scatter(currenttime(j, 1), currentfooty(j, 1), 30, 'green');
push = scatter(currenttime(pushoffset, 1), currentfooty(pushoffset, 1), 30, 'cyan');
title("Foot y Position, Velocity, Acceleration after push")
legend([push, maxtilt, tiltplat, donetilt],{'Push Done','Foot Tilt Max Height', 'Tilt Plateau', 'Tilt Done'},'Location','NorthWest')
xlabel("Time (s)")
ylabel("y Position (m)")

subplot(3,1,2)
plot(currenttime, currentfootyvel)
hold on;
scatter(currenttime(i, 1), currentfootyvel(i, 1), 30, 'magenta')
scatter(currenttime(k, 1), currentfootyvel(k, 1), 30, 'blue')
scatter(currenttime(j, 1), currentfootyvel(j, 1), 30, 'green')
scatter(currenttime(pushoffset, 1), currentfootyvel(pushoffset, 1), 30, 'cyan')
xlabel("Time (s)")
ylabel("Velocity (m/s)")

subplot(3,1,3)
plot(currenttime, currentfootyacc)
hold on;
scatter(currenttime(i, 1), currentfootyacc(i, 1), 30, 'magenta')
scatter(currenttime(k, 1), currentfootyacc(k, 1), 30, 'blue')
scatter(currenttime(j, 1), currentfootyacc(j, 1), 30, 'green')
scatter(currenttime(pushoffset, 1), currentfootyacc(pushoffset, 1), 30, 'cyan')
xlabel("Time (s)")
ylabel("Acceleration (m/s^2)")

%phase plot COM
figure
start_dot = scatter3(currentx(1, 1), currenty(1, 1), currentz(1,1), 300, 'blue');
hold on;
maxtilt_dot = scatter3(currentx(i, 1), currenty(i, 1), currentz(i, 1), 300, 'magenta');
plat_dot = scatter3(currentx(k, 1), currenty(k, 1), currentz(k, 1), 300, 'black');
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

legend([phase_scatter,start_dot,end_dot, maxtilt_dot, plat_dot, minvel_dot, endpush_dot],{'Phase trajectory','Starting point','End Point', 'Max Tilt', 'Tilt Plateau', 'End Foot Tilt', 'End Push'},'Location','NorthWest')
hold off;

figure
start_line = plot3(currentx(1:pushoffset, 1), currenty(1:pushoffset, 1), currentz(1:pushoffset, 1), 'blue', 'Linewidth',2);
title("Phase Plot for COM")
xlabel('Position (m)')
ylabel('Velocity (m/s)')
zlabel('Acceleration (m/s^2)')
grid on;
hold on;
pushend_line = plot3(currentx(pushoffset:i, 1), currenty(pushoffset:i, 1), currentz(pushoffset:i, 1), 'green', 'Linewidth',2);
maxtilt_line = plot3(currentx(i:k, 1), currenty(i:k, 1), currentz(i:k, 1), 'cyan', 'Linewidth',2);
tilt_plateau = plot3(currentx(k:j, 1), currenty(k:j, 1), currentz(k:j, 1), 'magenta', 'Linewidth',2);
mintilt_line = plot3(currentx(j:end, 1), currenty(j:end, 1), currentz(j:end, 1), 'black', 'Linewidth',2);

legend([start_line,pushend_line,maxtilt_line, tilt_plateau, mintilt_line],{'Push','Foot Tilt','Tilt Plateau', 'Foot Down', 'Settle'},'Location','NorthWest');

figure
start_line = plot3(currentx(1:pushoffset, 1), currenty(1:pushoffset, 1), currentfooty(1:pushoffset, 1), 'blue', 'Linewidth',2);
title("Phase Plot with Foot Tilt Height")
xlabel('Position (m)')
ylabel('Velocity (m/s)')
zlabel('Foot Height (m)')
grid on;
hold on;
pushend_line = plot3(currentx(pushoffset:i, 1), currenty(pushoffset:i, 1), currentfooty(pushoffset:i, 1), 'green', 'Linewidth',2);
maxtilt_line = plot3(currentx(i:k, 1), currenty(i:k, 1), currentfooty(i:k, 1), 'cyan', 'Linewidth',2);
tilt_plateau = plot3(currentx(k:j, 1), currenty(k:j, 1), currentfooty(k:j, 1), 'magenta', 'Linewidth',2);
mintilt_line = plot3(currentx(j:end, 1), currenty(j:end, 1), currentfooty(j:end, 1), 'black', 'Linewidth',2);

legend([start_line,pushend_line,maxtilt_line, tilt_plateau, mintilt_line],{'Push','Foot Tilt','Foot Down', 'Tilt Plateau','Settle'},'Location','NorthWest');

%% trying to fit lines
segment1x = currentx(1:pushoffset, 1);
segment1y = currenty(1:pushoffset, 1);
segment1z = currentz(1:pushoffset, 1);
segment2x = currentx(pushoffset:i, 1);
segment2y = currenty(pushoffset:i, 1);
segment2z = currentz(pushoffset:i, 1);
segment3x = currentx(i:k, 1);
segment3y = currenty(i:k, 1);
segment3z = currentz(i:k, 1);
segment4x = currentx(k:j, 1);
segment4y = currenty(k:j, 1);
segment4z = currentz(k:j, 1);
segment5x = currentx(j:end, 1);
segment5y = currenty(j:end, 1);
segment5z = currentz(j:end, 1);

figure
plot3(segment1x, segment1y, segment1z, 'Linewidth',2);
title("Push segment")
xlabel('Position (m)')
ylabel('Velocity (m/s)')
zlabel('Acceleration (m/s^2)')

[fitresult1, gof] = createFit1(segment1x, segment1y, segment1z);
z1 = fitresult1.p00 + fitresult1.p10.*segment1x + fitresult1.p01*segment1y;
rmse = sqrt(sum((segment1z - z1).^2));

figure
orig1 = plot(currenttime(1:pushoffset, 1), segment1z);
hold on;
plane1 = plot(currenttime(1:pushoffset, 1), z1);
title("Push Segment Error");
xlabel("Time (s)");
ylabel("Acceleration (m/s^2)");
legend([orig1, plane1],{'Original', 'Plane Fit'},'Location','NorthWest');

disp("segment1");

disp(fitresult1.p00);
disp(fitresult1.p10);
disp(fitresult1.p01);

disp(rmse);

[x1, x2] = size(segment2x);
if x1 > 3
    figure
    plot3(segment2x, segment2y, segment2z, 'Linewidth',2);
    title("Tilt Up")
    xlabel('Position (m)')
    ylabel('Velocity (m/s)')
    zlabel('Acceleration (m/s^2)')
    [fitresult2, gof] = createFit2(segment2x, segment2y, segment2z);
    z2 = fitresult2.p00 + fitresult2.p10.*segment2x + fitresult2.p01*segment2y;
    rmse = sqrt(sum((segment2z - z2).^2));
    
    figure
    orig2 = plot(currenttime(pushoffset:i, 1), segment2z);
    hold on;
    plane2 = plot(currenttime(pushoffset:i, 1), z2);
    title("Foot Tilt Up Segment Error");
    xlabel("Time (s)");
    ylabel("Acceleration (m/s^2)");
    legend([orig2, plane2],{'Original', 'Plane Fit'},'Location','NorthWest');
    
    disp("segment2");
    
    disp(fitresult2.p00);
    disp(fitresult2.p10);
    disp(fitresult2.p01);
    disp(rmse);
end


[x1, x2] = size(segment3x);
if x1 > 3
    figure
    plot3(segment3x, segment3y, segment3z, 'Linewidth',2);    
    title("Tilt Plateau");
    xlabel('Position (m)')
    ylabel('Velocity (m/s)')
    zlabel('Acceleration (m/s^2)')
    [fitresult3, gof] = createFit3(segment3x, segment3y, segment3z);
    z3 = fitresult3.p00 + fitresult3.p10.*segment3x + fitresult3.p01*segment3y;
    rmse = sqrt(sum((segment3z - z3).^2));
    figure
    plot([segment3z, z3]);
    disp("segment3");
    disp(rmse);
end

[x1, x2] = size(segment4x);
if x1 > 3
    figure
    plot3(segment4x, segment4y, segment4z, 'Linewidth',2);
    title("Tilt Down")
    xlabel('Position (m)')
    ylabel('Velocity (m/s)')
    zlabel('Acceleration (m/s^2)')
    [fitresult4, gof] = createFit4(segment4x, segment4y, segment4z);
    z4 = fitresult4.p00 + fitresult4.p10.*segment4x + fitresult4.p01*segment4y;
    rmse = sqrt(sum((segment4z - z4).^2));
    figure
    plot([segment4z, z4]);
    disp("segment4");
    disp(rmse);
end

figure
plot3(segment5x, segment5y, segment5z, 'Linewidth',2);
title("Settle")
xlabel('Position (m)')
ylabel('Velocity (m/s)')
zlabel('Acceleration (m/s^2)')
[fitresult5, gof] = createFit5(segment5x, segment5y, segment5z);
z5 = fitresult5.p00 + fitresult5.p10.*segment5x + fitresult5.p01*segment5y;
rmse = sqrt(sum((segment5z - z5).^2));
figure
plot([segment5z, z5]);
disp("segment5");
disp(rmse);

%Ax + By + Cz + D = 0
% A1 = -91.1482;
% B1 = -8.2093;
% C1 = -1;
% D1 = 1.5202;
% 
% A2 = 556.1433;
% B2 = 101.6383;
% C2 = -1;
% D2 = -19.9090;
% 
% figure
% [x, y] = meshgrid(-1:0.1:1); % Generate x and y data
% z1 = -1/C1*(A1*x + B1*y + D1); % Solve for z data
% f1 = surf(x,y,z1, 'FaceColor', 'r') %Plot the surface
% hold on
% z2 = -1/C2*(A2*x + B2*y + D2); % Solve for z data
% f2 = surf(x,y,z2, 'FaceColor', 'b')

% figure
% plot(currenttime, Feet_pos(startPoint:endPoint, 1), 'Linewidth',2);
% title("Foot x position");
% xlabel("Time (s)")
% ylabel("Foot x Position (m)")
% slideDist = max(Feet_pos(startPoint:endPoint, 1)) - min(Feet_pos(startPoint:endPoint, 1));
% disp(slideDist);