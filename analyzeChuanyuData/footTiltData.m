%save foot tilting
% by Peggy Wang

clc
clear
close all

load("finaldata.mat")

len = length(foot_y_array(1, :));
COMstart = COM_x_array(1,1);

maxFootHeight = zeros(1, len);
minFootHeight = zeros(1, len);
maxIndex = zeros(1, len);
minIndex = zeros(1, len);
maxCOMarray = zeros(1, len);
maxCOMIndex = zeros(1, len);

for i = 1:len
    [maxheight, maxind] = max(foot_y_array(:, i));
    [minheight, minind] = min(foot_y_array(:, i));
    maxFootHeight(1, i) = maxheight;
    minFootHeight(1, i) = minheight;
    maxIndex(1, i) = maxind;
    minIndex(1, i) = minind;
    [maxCOM, maxCOMind] = max(COM_x_array(:, i));
    [minCOM, minCOMind] = min(COM_x_array(:, i));
    maxCOMarray(1, i) = abs(maxCOM - minCOM);
    if forcearray(1, i) < 0
        maxCOMIndex(1, i) = minCOMind;
    else
        maxCOMIndex(1, i) = maxCOMind;
    end
end

save('finaldata', 'maxFootHeight', 'minFootHeight', 'maxIndex', 'minIndex', 'maxCOMarray', 'maxCOMIndex', '-append');