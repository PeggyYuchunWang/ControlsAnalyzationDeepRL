%plotting data
%by Peggy Wang

clc
clear
close all

%load("/Users/pegasus/Documents/AA93/finalData/finaldata.mat")
load("/Users/pegasus/Documents/AA93/DDPG_PD_3/2017_06_23_16.55.02/no_force/run_log.mat")

index = 101; %400 force
pushoffset = 50;
% currentx = COM_x_array(pushoffset:end, index);
% currenty = COM_vel_x_array(pushoffset:end, index);
% currentz = COM_acc_x_array(pushoffset:end, index);
% currentfoot = footy_array(pushoffset:end, index);
% currentfootvel = footvel_array(pushoffset:end, index);

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

COM_acc_x = zeros(l, 1);

dt = 1/500; %time step (double check)

%calculate acceleration by taking velocity/time
for a = 2:l-1
    COM_acc_x(a) = (COM_vel_x(a) - COM_vel_x(a-1))/dt ;
end

%moving avg filter for acc
windowSize = 50; 
b = (1/windowSize)*ones(1,windowSize);
c = 1;
COM_acc_x = filter(b,c,COM_acc_x);

currentx = COM_x(pushoffset:end, 1);
currenty = COM_vel_x(pushoffset:end, 1);
currentz = COM_acc_x(pushoffset:end, 1);

footy = Feet_pos(startPoint:endPoint, 2);
currentfoot = footy(pushoffset:end, 1);
footZero = footy(1, 1);

footvel = Feet_vel(startPoint:endPoint, 2);
currentfootvel = footvel(pushoffset:end, 1);

figure
subplot(4,1,1)
plot(currentx)
xlabel("time")
ylabel("position")
subplot(4,1,2)
plot(currenty)
xlabel("time")
ylabel("velocity")
subplot(4,1,3)
plot(currentz)
xlabel("time")
ylabel("acceleration")
subplot(4, 1, 4)
plot(footy)
xlabel("time")
ylabel("foot y position")

figure
plot(footy)
xlabel("time")
ylabel("foot y position")

% graph for all

[fitresult, gof] = createFit(currentx, currenty, currentz);

figure
start_dot = scatter3(currentx(1, 1), currenty(1, 1), currentz(1,1), 300, 'blue');
hold on;
len = length(currentx);
end_dot = scatter3(currentx(len, 1), currenty(len, 1), currentz(len,1), 300, 'red');

for k=1:length(currentfoot)
    if currentfoot(k,1) > footZero
        footDown = scatter3(currentx(k, 1), currenty(k, 1), currentz(k,1), 300, 'green');
    elseif currentfoot(k,1) < footZero
        footUp = scatter3(currentx(k, 1), currenty(k, 1), currentz(k,1), 300, 'magenta');
    end
end

plot3(currentx, currenty, currentz);
xlabel('position')
ylabel('velocity')
zlabel('acceleration')

colour_offset = 2000;
colours=colormap(parula(colour_offset +length(currentx)));
colours(1:colour_offset,:)=[];
phase_dot_size = 3;

hold on;
grid on;

transp = 0.9;
phase_lines = plot3(currentx, currenty, currentz,'Color',[transp,transp,transp]);
phase_scatter = scatter3(currentx, currenty, currentz,phase_dot_size,colours); 
colorbar('Ticks',[0,1],'TickLabels',{'Start','End'});

legend([phase_scatter,start_dot,end_dot, footDown, footUp],{'Phase trajectory','Starting point','End Point', 'Foot Down', 'Foot Up'},'Location','NorthWest')

hold off;

%animation
%figure
% for j = 1:length(currentx)
%     hold on
%     plot3(currentx(j, 1), currenty(j,1), currentz(j,1))
%     drawnow
%     pause(0.2)
% end

%z = ax + by + c
% a = p10array(1, index);
% b = p01array(1, index);
% c = p00array(1, index);
% 
% totalerror = 0;
% l = length(currentz);
% 
% for i = 1:l
%     equation = a * currentx(i,:) + b * currenty(i,:) + c;
%     totalerror = totalerror + abs(currentz(i,:) - equation);
% end
% 
% error = totalerror/l;