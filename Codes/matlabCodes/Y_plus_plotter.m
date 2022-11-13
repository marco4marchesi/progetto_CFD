%{

Y+ plotter: from the plot overlines exported by paraview

--------------------------------------------------------------------------
Author: Marco Marchesi
--------------------------------------------------------------------------
This code aims to plot the Y+ distribution around an aerodynamic profile.

Necessary inputs:
-   a folder containing all the PlotOverLines exported from paraview at
    specific locations. 
    NOTE: You have to know if the export has been done with a linspace on x
    coordinates or using the coordinates of the points of the profile. This
    is crucial for the code to work! - for CP it is most likely to be the
    linspace,  for Y+ it is most likely to be the coordinates of the
    profile.

---------------------- HOW TO USE THIS CODE: -----------------------------

if it's the first time you use this code follow the following steps before
running the code, otherwise it will return errors:

+   set the "matlabCodesPath" folder equal to the path where you have this
    script. 
    To do so you have to change the line in the INIT section  (lines 20 -
    40) where you see your name. If you don't see your name just copy-paste
    one "if" and set your "matlabCodesPath" variable.

+   set the "simulationsFolderPath" to the folder where you have all you
    simulations saved. The last folder should be "Simulation/". if it's not
    like that try asking for help to the author.


%}

%% select user
% user: set who is running the code so that the folder is chosen:
user = "doppio fisso"; % choices: "doppio fisso" "luca" ...

if user == "doppio fisso"
    matlabCodesPath = "C:\Users\marco\Desktop\UNI\2 MAGISTRALE\CFD\CFD PROJECT\progetto_CFD\Codes\matlabCodes\";
%     simulationsFolderPath = "C:\Users\marco\OneDrive - Politecnico di Milano\MAGISTRALE\TerzoSemestre\CFD\PROGETTO CFD DRIVE\SIMULATIONS DRIVE\Simulations\"; % one drive
    simulationsFolderPath = "C:\Users\marco\Desktop\UNI\2 MAGISTRALE\CFD\CFD PROJECT\progetto_CFD\Simulations\"; % locale
end

if user == "luca"
    matlabCodesPath = "C:/Users/lucag/Desktop/Universita/Magistrale Secondo Anno/Computational_fluid_dynamics/Progetto_CFD/progetto_CFD/Codes/matlabCodes\";
    simulationsFolderPath = "C:/Users/lucag/Desktop/Universita/Magistrale Secondo Anno/Computational_fluid_dynamics/Progetto_CFD/progetto_CFD/Simulations\";
end

%% init
clearvars -except matlabCodesPath simulationsFolderPath; 
close all; clc;

% add matlab functions to the path
addpath(genpath(matlabCodesPath))

% move to simulation folder
cd(simulationsFolderPath)
matlab_graphics;

%% select case folder (where you saved the .csv files)
% select which folder (P for prova, SC for Simulation Case)

caseFolder = "SC/SA/A9/O1/caseG3/";
addpath(genpath(caseFolder))
cd(caseFolder+"POL_results_Y_plus") % if you used the right naming for folders, you should not touch this line. Be careful if you need to modify it, it may mean that you are doing something wrong, ask the author.

%% list folders and extract names
listing = dir;

caseNames = [];
caseFiles = [];
for i = 1:size(listing,1)
    if convertCharsToStrings(listing(i).name==".")
        continue
    elseif convertCharsToStrings(listing(i).name=="..")
        continue
    end
    caseFiles = [caseFiles; convertCharsToStrings(listing(i).name)];
    caseNames = [caseNames; erase(convertCharsToStrings(listing(i).name),".csv")];
end

clearvars listing

%% PROFILE EXTRACTION   
NACA_23012_points = readtable(matlabCodesPath+"../pythonCodes/Naca_23012_points.dat");
x_profile = NACA_23012_points.Var1;
y_profile = NACA_23012_points.Var2;

idx_invert = find(y_profile<0,1,"first");
%%
for i = 1:size(caseNames,1)
    j = str2double(erase(caseNames(i),"sim"))+1; % +1 because pyhton enumerates them from 0

    sim = csvDataLogExtractor(caseFiles(i),"raw");

    % extract variables 
    Y_PLUS_vec = sim.Y_Plus;
    
    if j < idx_invert
        % find indeces for the parameters that we need
        idx = find(isnan(Y_PLUS_vec),1,"last")+1;
        if isempty(idx) || idx == length(x_profile)
            idx = 1;
        end
        % save values for upper quantities
        Y_PLUS_top(j) = Y_PLUS_vec(idx);
    else
        % find indeces for the parameters that we need
        idx = find(isnan(Y_PLUS_vec),1,"first")-1;
        if isempty(idx) || idx == 0
            idx = 1;
        end
        % save values for bottom quantities
        Y_PLUS_bottom(j) = Y_PLUS_vec(idx);
    end
    
end

Y_PLUS_bottom = Y_PLUS_bottom(idx_invert:end);


%% save as a .mat file so that on github we can run the code without pushing the .csv files
% save("../Y_PLUS","Y_PLUS_bottom","Y_PLUS_upper","x_vec") 

cd(matlabCodesPath)
%% PLOTS

Y_PLUS_top_plot = Y_PLUS_top(Y_PLUS_top~=0);
Y_PLUS_bottom_plot = Y_PLUS_bottom(Y_PLUS_bottom~=0);

x_top = x_profile(1:idx_invert-1);
x_top_plot = x_top(Y_PLUS_top~=0);

x_bottom = x_profile(idx_invert:end);
x_bottom_plot = x_bottom(Y_PLUS_bottom~=0);


% close all;
cd(simulationsFolderPath + caseFolder)

%----------------------- export figures? --------------------------------
exportFigures = false;
if exportFigures
    mkdir("IMAGES")
end

%%% Y PLUS
    % generate meshgrid for plane
    x_mesh = [-10, +10];
    
    y_mesh1 = [-1,1];
    y_mesh2_1 = [1,2.5];
    y_mesh2_2 = -[1,2.5];
    y_mesh3_1 = [2.5, 100];
    y_mesh3_2 = -[2.5, 100];
    
    [X_surf, Y_surf1] = meshgrid(x_mesh, y_mesh1);
    [~, Y_surf2_1] = meshgrid(x_mesh, y_mesh2_1);
    [~, Y_surf2_2] = meshgrid(x_mesh, y_mesh2_2);
    [~, Y_surf3_1] = meshgrid(x_mesh, y_mesh3_1);
    [~, Y_surf3_2] = meshgrid(x_mesh, y_mesh3_2);  
    Z_surf = zeros(size(X_surf, 1));
    
    % generate figure
    YPLUS_FIGURE = figure('Name','Y\_PLUS for test case');
    hold on; grid on;
    surf(X_surf, Y_surf1, Z_surf,'FaceAlpha',0.1,'FaceColor','green')
    surf(X_surf, Y_surf2_1, Z_surf,'FaceAlpha',0.1,'FaceColor','yellow')
    surf(X_surf, Y_surf3_1, Z_surf,'FaceAlpha',0.1,'FaceColor','red')
    surf(X_surf, Y_surf2_2, Z_surf,'FaceAlpha',0.1,'FaceColor','yellow')
    surf(X_surf, Y_surf3_2, Z_surf,'FaceAlpha',0.1,'FaceColor','red')    
    plot(x_top_plot,Y_PLUS_top_plot,'red')
    plot(x_bottom_plot,-Y_PLUS_bottom_plot,'blue')
    plot(x_profile,5*y_profile,'k--','LineWidth',0.8)
    yline(0,'r--')
    xlabel('x_{profile} [-]')
    ylabel('Y^+ [-]')
    grid on;
    lgd = legend('0<Y^+<1','1<Y^+<2.5','Y^+>2.5','','','Top','Bottom');
    lgd.FontSize = 10;
    title('Y^+ over airfoil')
    xlim([min(x_profile)-0.05, max(x_profile)+0.05])
%     ylim([-max(Y_PLUS_bottom)-0.05, max(Y_PLUS_top)+0.05])
    ylim([-3, 3])
    if exportFigures
        exportgraphics(YPLUS_FIGURE,"IMAGES/YPLUS_distribution.pdf")
        exportgraphics(YPLUS_FIGURE,"IMAGES/YPLUS_distribution.png")

    end


