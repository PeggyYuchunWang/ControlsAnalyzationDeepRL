%save foot tilting
% by Peggy Wang

clc
clear
close all

load("finaldata.mat")

len = length(foot_y_array(1, :));
maxFootHeight = zeros(1, len);
minFootHeight = zeros(1, len);
maxIndex = zeros(1, len);
minIndex = zeros(1, len);

for i = 1:len
    [maxheight, maxind] = max(foot_y_array(i, :));
    [minheight, minind] = min(foot_y_array(i, :));
    maxFootHeight(1, i) = maxheight;
    minFootHeight(1, i) = minheight;
    maxIndex(1, i) = maxind;
    minIndex(1, i) = minind;
end

save('finaldata', 'maxFootHeight', 'minFootHeight', 'maxIndex', 'minIndex', '-append');