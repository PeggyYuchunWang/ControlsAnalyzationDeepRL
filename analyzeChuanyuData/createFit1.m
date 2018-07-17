function [fitresult, gof] = createFit1(segment1x, segment1y, segment1z)
%CREATEFIT1(SEGMENT1X,SEGMENT1Y,SEGMENT1Z)
%  Create a fit.
%
%  Data for 'Push Segment' fit:
%      X Input : segment1x
%      Y Input : segment1y
%      Z Output: segment1z
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 10-Jul-2018 09:33:14


%% Fit: 'Push Segment'.
[xData, yData, zData] = prepareSurfaceData( segment1x, segment1y, segment1z );

% Set up fittype and options.
ft = fittype( 'poly11' );

% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft );

% Plot fit with data.
figure( 'Name', 'Push Segment' );
h = plot( fitresult, [xData, yData], zData );
legend( h, 'Push Phase', 'COM x Position vs. Velocity, Acceleration', 'Location', 'NorthEast' );
% Label axes
title("Push Phase Affine Fit")
xlabel("Position (m)")
ylabel("Velocity (m/s)")
zlabel("Acceleration (m/s^2)")
grid on
view( -42.3, 6.0 );


