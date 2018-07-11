function [fitresult, gof] = createFit(currentx, currenty, currentz)
%CREATEFIT1(COM_X,COM_VEL_X,COM_ACC_X)
%  Create a fit.
%
%  Data for 'Push' fit:
%      X Input : COM_x
%      Y Input : COM_vel_x
%      Z Output: COM_acc_x
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 26-Jun-2018 12:18:53


%% Fit: 'Push'.
[xData, yData, zData] = prepareSurfaceData(currentx(50:end, 1), currenty(50:end, 1), currentz(50:end, 1));

% Set up fittype and options.
ft = fittype( 'poly11' );

% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft );

% Plot fit with data.
% figure( 'Name', 'Push' );
% h = plot( fitresult, [xData, yData], zData );
% legend( h, 'Push', 'Acceleration vs. Position, Velocity', 'Location', 'NorthEast' );
% % Label axes
% xlabel Position
% ylabel Velocity
% zlabel Acceleration
% grid on
% view( 0.1, -12.4 );


