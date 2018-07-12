% plot phase graph of COM x position, velocity, acceleration, can save data
% into mat file in loop
% By Peggy Wang
% make/change colors for start and end
% double check timestep and acceleration (each timestep = ? seconds)

% assume x is first element of array
clc
clear
close all

dir = "/Users/pegasus/Documents/AA93/allData/";

for f=-670:10:700

    file = int2str(f);
    path = strcat(dir, file, ".mat");
    load(path);

    pushBegin = 2500;
    pushEnd = 2550;
    startPoint = 2500;
    endPoint = 3500;
    pushoffset = 50;

    %graph for just push
    force = force(1,1);
    COM_x = COM(startPoint:endPoint, 1);
    startingPos = COM_x(1, 1);
    l = length(COM_x);

    COM_y = COM(startPoint:endPoint, 2);
    COM_vel_y = COM_vel(startPoint:endPoint, 2);

    %zero out starting position
    for a = 1:l
        COM_x(a) = COM_x(a) - startingPos;
    end
    COM_vel_x = COM_vel(startPoint:endPoint, 1);

    footy = Feet_pos(startPoint:endPoint, 2);
    footx = Feet_pos(startPoint:endPoint, 1);
    footyvel = Feet_vel(startPoint:endPoint, 2);
    footxvel = Feet_vel(startPoint:endPoint, 1);

    COM_acc_x = zeros(l, 1);
    COM_acc_y = zeros(l, 1);
    foot_acc_x = zeros(l, 1);
    foot_acc_y = zeros(l, 1);

    dt = 1/500; %time step (double check)

    %calculate acceleration by taking velocity/time
    for a = 2:l-1
        COM_acc_x(a) = (COM_vel_x(a) - COM_vel_x(a-1))/dt;
        COM_acc_y(a) = (COM_vel_y(a) - COM_vel_y(a-1))/dt;
        foot_acc_x(a) = (footxvel(a) - footxvel(a-1))/dt;
        foot_acc_y(a) = (footyvel(a) - footyvel(a-1))/dt;
    end

    %moving avg filter for acc
    windowSize = 20;
    b = (1/windowSize)*ones(1,windowSize);
    c = 1;
    COM_acc_x = filter(b,c,COM_acc_x);
    COM_acc_y = filter(b,c,COM_acc_y);
    foot_acc_x = filter(b,c,foot_acc_x);
    foot_acc_y = filter(b,c,foot_acc_y);
    
    currentx = COM_x;
    currenty = COM_vel_x;
    currentz = COM_acc_x;

    %max foot tilting height
    h = max(footy);
    
    plateau = find(footy > h-.004 & footy < h+.004);
    i = min(plateau);
    k = max(plateau);

    %min foot tilt height (also min velocity) and index
    [v, j] = min(footy);

    distFoot = abs(h-v);

    if distFoot < 0.005
        i = pushoffset;
        j = i;
        k = i;
    end

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

    [fitresult1, gof] = createFit1(segment1x, segment1y, segment1z);
    z1 = fitresult1.p00 + fitresult1.p10.*segment1x + fitresult1.p01*segment1y;
    rmse1 = sqrt(sum((segment1z - z1).^2));

    [x1, x2] = size(segment2x);
    if x1 > 3
        [fitresult2, gof] = createFit2(segment2x, segment2y, segment2z);
        z2 = fitresult2.p00 + fitresult2.p10.*segment2x + fitresult2.p01*segment2y;
        rmse2 = sqrt(sum((segment2z - z2).^2));
    else
        fitresult2.p00 = 0;
        fitresult2.p10 = 0;
        fitresult2.p01 = 0;
        z2 = 0;
        rmse2 = 0;
    end


    [x1, x2] = size(segment3x);
    if x1 > 3
        [fitresult3, gof] = createFit3(segment3x, segment3y, segment3z);
        z3 = fitresult3.p00 + fitresult3.p10.*segment3x + fitresult3.p01*segment3y;
        rmse3 = sqrt(sum((segment3z - z3).^2));
    else
        fitresult3.p00 = 0;
        fitresult3.p10 = 0;
        fitresult3.p01 = 0;
        z3 = 0;
        rmse3 = 0;
    end
    
    [x1, x2] = size(segment4x);
    if x1 > 3
        [fitresult4, gof] = createFit4(segment4x, segment4y, segment4z);
        z4 = fitresult4.p00 + fitresult4.p10.*segment4x + fitresult4.p01*segment4y;
        rmse4 = sqrt(sum((segment4z - z4).^2));
    else
        fitresult4.p00 = 0;
        fitresult4.p10 = 0;
        fitresult4.p01 = 0;
        z4 = 0;
        rmse4 = 0;
    end

    [fitresult5, gof] = createFit5(segment5x, segment5y, segment5z);
    z5 = fitresult5.p00 + fitresult5.p10.*segment5x + fitresult5.p01*segment5y;
    rmse5 = sqrt(sum((segment5z - z5).^2));

    %uncomment to save to file
    m = matfile('fitdata.mat','Writable',true);

    seg1p00array = cat(2, m.seg1p00array, fitresult1.p00);
    seg1p01array = cat(2, m.seg1p01array, fitresult1.p01);
    seg1p10array = cat(2, m.seg1p10array, fitresult1.p10);
    seg1rmsearray = cat(2, m.seg1rmsearray, rmse1);

    seg2p00array = cat(2, m.seg2p00array, fitresult2.p00);
    seg2p01array = cat(2, m.seg2p01array, fitresult2.p01);
    seg2p10array = cat(2, m.seg2p10array, fitresult2.p10);
    seg2rmsearray = cat(2, m.seg2rmsearray, rmse2);

    seg3p00array = cat(2, m.seg3p00array, fitresult3.p00);
    seg3p01array = cat(2, m.seg3p01array, fitresult3.p01);
    seg3p10array = cat(2, m.seg3p10array, fitresult3.p10);
    seg3rmsearray = cat(2, m.seg3rmsearray, rmse3);

    seg4p00array = cat(2, m.seg4p00array, fitresult4.p00);
    seg4p01array = cat(2, m.seg4p01array, fitresult4.p01);
    seg4p10array = cat(2, m.seg4p10array, fitresult4.p10);
    seg4rmsearray = cat(2, m.seg4rmsearray, rmse4);
    
    seg5p00array = cat(2, m.seg5p00array, fitresult5.p00);
    seg5p01array = cat(2, m.seg5p01array, fitresult5.p01);
    seg5p10array = cat(2, m.seg5p10array, fitresult5.p10);
    seg5rmsearray = cat(2, m.seg5rmsearray, rmse5);

    COM_x_array = cat(2, m.COM_x_array, COM_x);
    COM_vel_x_array = cat(2, m.COM_vel_x_array, COM_vel_x);
    COM_acc_x_array = cat(2, m.COM_acc_x_array, COM_acc_x);

    COM_y_array = cat(2, m.COM_y_array, COM_y);
    COM_vel_y_array = cat(2, m.COM_vel_y_array, COM_vel_y);
    COM_acc_y_array = cat(2, m.COM_acc_y_array, COM_acc_y);

    forcearray = cat(2, m.forcearray, force);

    foot_y_array = cat(2, m.foot_y_array, footy);
    foot_y_vel_array = cat(2, m.foot_y_vel_array, footyvel);
    foot_x_array = cat(2, m.foot_x_array, footx);
    foot_x_vel_array = cat(2, m.foot_x_vel_array, footxvel);
    foot_x_acc_array = cat(2, m.foot_x_acc_array, foot_acc_x);
    foot_y_acc_array = cat(2, m.foot_y_acc_array, foot_acc_y);

    save('fitdata', 'seg1p00array', 'seg1p01array', 'seg1p10array', 'seg1rmsearray', 'COM_x_array', 'COM_vel_x_array', 'COM_acc_x_array', 'forcearray','foot_y_array', 'foot_y_vel_array', '-v7.3');
    save('fitdata', 'COM_y_array', 'COM_vel_y_array', 'COM_acc_y_array', 'foot_x_array', 'foot_x_vel_array', 'foot_x_acc_array', 'foot_y_acc_array', '-append');
    save('fitdata', 'seg2p00array', 'seg2p01array', 'seg2p10array', 'seg2rmsearray', 'seg3p00array', 'seg3p01array', 'seg3p10array', 'seg3rmsearray', 'seg4p00array', 'seg4p01array', 'seg4p10array', 'seg4rmsearray', 'seg5p00array', 'seg5p01array', 'seg5p10array', 'seg5rmsearray', '-append');
    %whos('-file', 'fitdata.mat')

end