%analysis w/ respect to forces
%by Peggy Wang

clc
clear
close all

load("../finalData/finaldata.mat")

plot(forcearray, maxFootHeight);
title("Force vs. Max Foot Tilting Height");
xlabel("Force (N)");
ylabel("Max Foot Tilting Height (m)");

figure
startInd = 27;
endInd = 138;
plot(forcearray(1, startInd:endInd), maxFootHeight(1, startInd:endInd));
title("Normalized Force vs. Max Foot Tilting Height");
xlabel("Force (N)");
ylabel("Max Foot Tilting Height (m)");

% figure
% plot(forcearray, maxIndex);
% title("Force vs. Max Foot Tilting Time");
% xlabel("Force (N)");
% ylabel("Max Foot Tilting Time");

figure
plot(forcearray, maxCOMarray);
title("Force vs. Max COM Distance from Origin");
xlabel("Force (N)");
ylabel("Max COM Distance from Origin (m)");

% figure
% plot(forcearray, maxCOMIndex);
% title("Force vs. Max COM Distance Time");
% xlabel("Force (N)");
% ylabel("Max COM Distance Time");

% figure
% plot(forcearray, errorarray);
% title("Force vs. Fit Plane Error");
% xlabel("Force (N)");
% ylabel("Fit Plane Error");