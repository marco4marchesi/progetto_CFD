%{
Set graphical values for better looking plots
%}

%% interpreter:

set(0, 'defaultTextInterpreter', 'tex')
set(0, 'defaultAxesTickLabelInterpreter', 'tex')

%% figure properties:

set(0, 'defaultFigureColormap',turbo(256));
set(0, 'defaultFigureColor', [1; 1; 1]);

%% surfaces:
% transparency
set(0, 'defaultSurfaceEdgeAlpha', 0.3);

%% lines:

defaultLineWidth = 1.5;

% plots
set(0, 'defaultLineLineWidth', defaultLineWidth);
% stairs
set(0, 'defaultStairLineWidth', defaultLineWidth); % needs a different command for no reason apparently

%% legend:
set(0, 'defaultLegendLocation','best');

%% axes:

% grid 
set(0, 'defaultAxesXMinorGrid', 'on');
set(0, 'defaultAxesYMinorGrid', 'on');
% font
set(0, 'defaultAxesFontName', 'Palatino Linotype', 'defaultTextFontName', 'Palatino Linotype');
% color
set(0, 'defaultAxesColor', 'none');
% fontSize
set(groot,'DefaultAxesFontSize',16);
