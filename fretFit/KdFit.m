function [fitresult, gof] = KdFit(At, Delta)
%KdFit(AT,DELTA)
%  Data for 'untitled fit 1' fit:
%      X Input : At
%      Y Output: Delta
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

[xData, yData] = prepareCurveData( At, Delta );

% Set up fittype and options.
ft = fittype( 'a+(ab-a)/100.*(x+50+k-sqrt((x+50+k).*(x+50+k)-200.*x))', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.DiffMaxChange = 0.01;
opts.DiffMinChange = 1e-09;
opts.Display = 'Off';
opts.Lower = [0 0 0];
opts.MaxFunEvals = 1600;
opts.MaxIter = 1400;
opts.StartPoint = [0.5 1 90];
opts.TolFun = 1e-07;
opts.TolX = 1e-07;
opts.Upper = [1 1 100];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Create a figure for the plots.
figure( 'Name', 'untitled fit 1' );

% Plot fit with data.
subplot( 2, 1, 1 );
h = plot( fitresult, xData, yData );
legend( h, 'Delta vs. At', 'Kd fit', 'Location', 'NorthEast' );
% Label axes
xlabel At
ylabel Delta
grid on

% Plot residuals.
subplot( 2, 1, 2 );
h = plot( fitresult, xData, yData, 'residuals' );
legend( h, 'untitled fit 1 - residuals', 'Zero Line', 'Location', 'NorthEast' );
% Label axes
xlabel At
ylabel Delta
grid on


