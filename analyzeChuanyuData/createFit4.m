function [fitresult, gof] = createFit4(segment4x, segment4y, segment4z)
%CREATEFIT4(SEGMENT4X,SEGMENT4Y,SEGMENT4Z)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : segment4x
%      Y Input : segment4y
%      Z Output: segment4z
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 12-Jul-2018 16:48:29


%% Fit: 'untitled fit 1'.
[xData, yData, zData] = prepareSurfaceData( segment4x, segment4y, segment4z );

% Set up fittype and options.
ft = fittype( 'poly11' );

% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft );

% Plot fit with data.
figure( 'Name', 'Foot Tilt Down' );
h = plot( fitresult, [xData, yData], zData );
legend( h, 'Foot Tilt Down', 'COM x Position vs. Velocity, Acceleration', 'Location', 'NorthEast' );
% Label axes
title("Foot Tilt Down Phase Affine Fit")
xlabel("Position (m)")
ylabel("Velocity (m/s)")
zlabel("Acceleration (m/s^2)")
grid on
view( -47.9, -25.2 );


