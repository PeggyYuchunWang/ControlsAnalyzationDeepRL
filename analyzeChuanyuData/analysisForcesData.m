%analysis w/ respect to forces
%by Peggy Wang

clc
clear
close all

load("/Users/pegasus/Documents/AA93/finalData/finaldata.mat")

plot(forcearray, maxFootHeight);
title("Force vs. Max Foot Tilting Height");
xlabel("Force (N)");
ylabel("Max Foot Tilting Height (m)");
figure
plot(forcearray, maxIndex);
title("Force vs. Max Foot Tilting Time");
xlabel("Force (N)");
ylabel("Max Foot Tilting Time");
figure
plot(forcearray, maxCOMarray);
title("Force vs. Max COM Distance from Origin");
xlabel("Force (N)");
ylabel("Max COM Distance from Origin (m)");
figure
plot(forcearray, maxCOMIndex);
title("Force vs. Max COM Distance Time");
xlabel("Force (N)");
ylabel("Max COM Distance Time");