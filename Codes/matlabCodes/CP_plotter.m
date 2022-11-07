%{

CP plotter: from the plot overlines exported by paraview

Author: Marco Marchesi

---------------------- HOW TO USE THIS CODE: -----------------------------

if it's the first time you use this code follow the following steps before
running the code, otherwise it will return errors:

+   set the "matlabCodesPath" folder equal to the path where you have this
    script. 
    To do so you have to change the line in the INIT section  (lines 20 -
    40) where you see your name. If you don't see your name just copy-paste
    one if cycle and set your "matlabCodesPath" variable.

+   set the "simulationsFolderPath" to the folder where you have all you
    simulations saved. The last folder should be "Simulation/". if it's not
    like that try asking for help to the author.


%}

%% init

% user: set who is running the code so that the folder is chosen:
user = "doppio fisso"; % choices: "doppio fisso" "luca" ...

if user == "doppio fisso"
    matlabCodesPath = "C:\Users\marco\Desktop\UNI\2 MAGISTRALE\CFD\CFD PROJECT\progetto_CFD\Codes\matlabCodes";
    simulationsFolderPath = "C:\Users\marco\OneDrive - Politecnico di Milano\MAGISTRALE\TerzoSemestre\CFD\PROGETTO CFD DRIVE\SIMULATIONS DRIVE\Simulations";
end

if user == "luca"
    matlabCodesPath = "C:/Users/lucag/Desktop/Universit133/Magistrale Secondo Anno/Computational_fluid_dynamics/Progetto_CFD/progetto_CFD/Codes/matlabCodes";
    simulationsFolderPath = "C:/Users/lucag/Desktop/Universita/Magistrale Secondo Anno/Computational_fluid_dynamics/Progetto_CFD/progetto_CFD/Simulations";
end


clearvars -except matlabCodesPath simulationsFolderPath; 
close all; clc;

currentFolder = pwd;
if not(strcmp(currentFolder, matlabCodesPath))
    cd(matlabCodesPath)
end

cd(simulationsFolderPath)
matlab_graphics;

%% select case folder (where you saved the .csv files)
% select which folder (P for prova, SC for Simulation Case)

caseFolder = "SC/SST/A14/O1/caseG3/POL_resultsG3";
addpath(genpath(caseFolder))
cd(caseFolder)

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

%% EXTRACTION   
for i = 1:size(caseNames,1)
    j = str2double(erase(caseNames(i),"sim"))+1; % +1 because pyhton enumerates them from 0

    sim = csvDataLogExtractor(caseFiles(i),"raw");

    % extract variables 
    CP_vec = sim.Pressure_Coefficient;
    Y_PLUS_vec = sim.Y_Plus;

    % find indeces for the parameters that we need
    idx_up = find(isnan(CP_vec),1,"last")+1;
    idx_bott = find(isnan(CP_vec),1,"first")-1;

    if isempty(idx_up)
        idx_up = round(length(CP_vec)/2)+1;
    end
    if isempty(idx_bott)
        idx_bott = round(length(CP_vec)/2)+1;
    end

    % save values for upper quantities
    CP_upper(j) = CP_vec(idx_up);
    Y_PLUS_upper(j) = Y_PLUS_vec(idx_up);
        
    % save values for bottom quantities
    CP_bottom(j) = CP_vec(idx_bott);
    Y_PLUS_bottom(j) = Y_PLUS_vec(idx_bott);
    
end

x_vec = linspace(0,1.008,size(caseNames,1));


%% save as a .mat file so that on github we can run the code without pushing the .csv files
% save("../CP","CP_bottom","CP_upper","x_vec") 
% save("../Y_PLUS","Y_PLUS_bottom","Y_PLUS_upper","x_vec") 


%% PLOTS
close all;
exportFigures = false;

%%% PRESSURE COEFFICIENT
    CP_FIGURE = figure('Name','CP for test case');
    plot(x_vec,-CP_upper,'green')
    hold on; grid on;
    plot(x_vec,-CP_bottom,'blue')
    yline(0,'r--')
    xlabel('x [-]')
    ylabel('CP [-]')
    legend('Upper','Bottom')
    title('CP over airfoil')
if exportFigures
    exportgraphics(CP_FIGURE,"CP_distribution.pdf")
end

%%% Y PLUS
    % generate meshgrid for plane
    x_mesh = [-10, +10];
    
    y_mesh1 = [0,1];
    y_mesh2 = [1,2.5];
    y_mesh3 = [2.5, 100];
    
    [X_surf, Y_surf1] = meshgrid(x_mesh, y_mesh1);
    [~, Y_surf2] = meshgrid(x_mesh, y_mesh2);
    [~, Y_surf3] = meshgrid(x_mesh, y_mesh3);
    
    Z_surf = zeros(size(X_surf, 1));
    
    % generate figure
    YPLUS_FIGURE = figure('Name','Y\_PLUS for test case');
    plot(x_vec,Y_PLUS_upper)
    hold on; grid on;
    plot(x_vec,Y_PLUS_bottom)
    surf(X_surf, Y_surf1, Z_surf,'FaceAlpha',0.1,'FaceColor','green')
    surf(X_surf, Y_surf2, Z_surf,'FaceAlpha',0.1,'FaceColor','white')
    surf(X_surf, Y_surf3, Z_surf,'FaceAlpha',0.1,'FaceColor','red')
    yline(0,'r--')
    xlabel('x [-]')
    ylabel('Y\_plus [-]')
    legend('Upper','Bottom')
    title('Y\_PLUS over airfoil')
    xlim([min(x_vec)-0.05, max(x_vec)+0.05])
    ylim([min(min(Y_PLUS_bottom),min(Y_PLUS_upper))-0.05, max(max(Y_PLUS_bottom),max(Y_PLUS_upper))+0.05])
    
if exportFigures
    exportgraphics(YPLUS_FIGURE,"YPLUS_distribution.pdf")
end

