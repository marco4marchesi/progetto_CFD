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
    matlabCodesPath = "C:\Users\marco\Desktop\UNI\2 MAGISTRALE\CFD\CFD PROJECT\progetto_CFD\Codes\matlabCodes\";
%     simulationsFolderPath = "C:\Users\marco\OneDrive - Politecnico di Milano\MAGISTRALE\TerzoSemestre\CFD\PROGETTO CFD DRIVE\SIMULATIONS DRIVE\Simulations\"; % one drive
    simulationsFolderPath = "C:\Users\marco\Desktop\UNI\2 MAGISTRALE\CFD\CFD PROJECT\progetto_CFD\Simulations\"; % locale
end

if user == "luca"
    matlabCodesPath = "C:/Users/lucag/Desktop/Universita/Magistrale Secondo Anno/Computational_fluid_dynamics/Progetto_CFD/progetto_CFD/Codes/matlabCodes\";
    simulationsFolderPath = "C:/Users/lucag/Desktop/Universita/Magistrale Secondo Anno/Computational_fluid_dynamics/Progetto_CFD/progetto_CFD/Simulations\";
end


clearvars -except matlabCodesPath simulationsFolderPath; 
close all; clc;

addpath(genpath(matlabCodesPath))


cd(simulationsFolderPath)
matlab_graphics;

%% PROFILE EXTRACTION   
NACA_23012_points = readtable(matlabCodesPath+"../pythonCodes/Naca_23012_points.dat");
x_profile = NACA_23012_points.Var1;
y_profile = NACA_23012_points.Var2;

%% select case folder (where you saved the .csv files)
% select which folder (P for prova, SC for Simulation Case)

caseFolder = "SC/SA/A9/O1/caseG3/";
addpath(genpath(caseFolder))
cd(caseFolder+"POL_results_CP")

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

x_vec = linspace(0,1.008,size(caseNames,1));

for i = 1:size(caseNames,1)
    j = str2double(erase(caseNames(i),"sim"))+1; % +1 because pyhton enumerates them from 0

    sim = csvDataLogExtractor(caseFiles(i),"raw");

    % extract variables 
    CP_vec = sim.Pressure_Coefficient;

    % find indeces for the parameters that we need
    idx_up = find(isnan(CP_vec),1,"last")+1;
    idx_bott = find(isnan(CP_vec),1,"first")-1;

    if isempty(idx_up) || idx_up > length(CP_vec)
        idx_up = floor(length(CP_vec)/2)+1;
    end
    if isempty(idx_bott) || idx_bott == 0
        idx_bott = floor(length(CP_vec)/2)+1;
    end

    % save values for upper quantities
    CP_top(j) = CP_vec(idx_up);
         
    % save values for bottom quantities
    CP_bottom(j) = CP_vec(idx_bott);
    
end


%% save as a .mat file so that on github we can run the code without pushing the .csv files
% save("../CP","CP_bottom","CP_upper","x_vec") 


%% PLOTS
close all;
cd(simulationsFolderPath + caseFolder)

%----------------------- export figures? --------------------------------%
exportFigures = true;
if exportFigures
    mkdir("IMAGES")
end

%%% PRESSURE COEFFICIENT
    CP_FIGURE = figure('Name','CP for test case');
    plot(x_vec,-CP_top,'red')
    hold on; grid minor;
    plot(x_vec,-CP_bottom,'blue')
    plot(x_profile,5*y_profile,'k--','LineWidth',0.8)
    yline(0,'r--')
    xlabel('x [-]')
    ylabel('CP [-]')
    legend('Top','Bottom')
    title('CP over airfoil')

    if exportFigures
        exportgraphics(CP_FIGURE,"IMAGES/CP_distribution.pdf")
        exportgraphics(CP_FIGURE,"IMAGES/CP_distribution.png")
    end

