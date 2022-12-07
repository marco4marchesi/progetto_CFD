%{

Matlab code for extracting data from history files of multiple angles simulations.

--------------------------------------------------------------------------
Author: Marco Marchesi
--------------------------------------------------------------------------

+   this code aims to extract the CD, CL, and CM ---curves--- w.r.t. the angle of 
    attack from the simulations and to automatically save them in a vector that 
    contains the number of elements in the mesh

+   this is done for checking the convergence of the meshes, we need to
    investigate whether the mesh returns a better result w.r.t. the precedent
    tried mesh

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
user = "doppio portatile"; % choices: "doppio fisso" "luca" ...

if user == "doppio fisso"
    matlabCodesPath = "C:\Users\marco\Desktop\UNI\2 MAGISTRALE\CFD\CFD PROJECT\progetto_CFD\Codes\matlabCodes";
    simulationsFolderPath = "C:\Users\marco\OneDrive - Politecnico di Milano\MAGISTRALE\TerzoSemestre\CFD\PROGETTO CFD DRIVE\SIMULATIONS DRIVE\Simulations";
%     simulationsFolderPath = "C:\Users\marco\Desktop\UNI\2 MAGISTRALE\CFD\CFD PROJECT\progetto_CFD\Simulations\"; % locale
end

if user == "doppio portatile"
    matlabCodesPath = "C:\Users\marco\Desktop\tutto\UNI\2 MAGISTRALE\CFD\CFD PROJECT\progetto_CFD\Codes\matlabCodes";
    simulationsFolderPath = "C:\Users\marco\OneDrive - Politecnico di Milano\MAGISTRALE\TerzoSemestre\CFD\PROGETTO CFD DRIVE\SIMULATIONS DRIVE\Simulations\";
%     simulationsFolderPath = "C:\Users\marco\Desktop\UNI\2 MAGISTRALE\CFD\CFD PROJECT\progetto_CFD\Simulations\"; % locale
end

if user == "luca"
    matlabCodesPath = "C:/Users/lucag/Desktop/Universita/Magistrale Secondo Anno/Computational_fluid_dynamics/Progetto_CFD/progetto_CFD/Codes/matlabCodes\";
    simulationsFolderPath = "C:/Users/lucag/Desktop/Universita/Magistrale Secondo Anno/Computational_fluid_dynamics/Progetto_CFD/progetto_CFD/Simulations\";
end

%% init 
clearvars -except matlabCodesPath simulationsFolderPath; 
% close all; clc;

% add matlab functions to the path
rmpath(matlabCodesPath+"/convergence_analysis")
rmpath(matlabCodesPath+"/polar_plotter")
rmpath(matlabCodesPath+"/farfield_analysis")
addpath(matlabCodesPath)
addpath(matlabCodesPath+"/dynamic_lift_coefficient")
addpath(matlabCodesPath+"/utilitiesFunctions")
% move to simulation folder
cd(simulationsFolderPath)
matlab_graphics;




%% ------------------------------------ CHOSE SIMULATION (FOLDER) -------------------------------------- %%
mainFolder = ['TC1';'TC2'];
% simuFolder = ''; % use single apices because otherwise the erase function does not work as I want

%% LOGARITMIC PLOT

for kk = 1:size(mainFolder,1)
testcase = strcat(mainFolder(kk,:));%,simuFolder);
cd(testcase)





%% data extraction and post processing

% data extraction
listing = dir("*.csv");

history = struct('Inner_Iter',[],'CL',[]);
for j = 1:length(listing)
currentHistory = csvDataLogExtractor(listing(j).name);
history.Inner_Iter = [history.Inner_Iter; currentHistory.Inner_Iter];
history.CL = [history.CL; currentHistory.CL];
end
firstHistoryStep = str2double(listing(1).name(end-8:end-4));

% simulation parameters (build alpha function)

A = 10;                             % [°] amplitude
omega = 13.5;                       % [rad/s] pitching pulsation of the simulation
alpha_mean = 10;                    % [°] mean angle of the simulation
chord = 1.00898;                    % [m] airfoil chord length
fsV = 68.05093;                     % [m/s] freestream velocity

switch mainFolder(kk,:) 
    case 'TC1'
        time_step= 0.02 * chord/fsV;        % [s] timestep of the simulation
    case 'TC2'
        time_step= 5*0.02 * chord/fsV;        % [s] timestep of the simulation
    case 'TC3'
        time_step= 0;
    case 'TC4'
        time_step= 0;
end
% extract variables from simulation
<<<<<<< HEAD
time_iter = currentHistory.Time_Iter;
CL = currentHistory.CL;
CL_avg = currentHistory.tavg_CL_;

% compute alpha
t = time_iter * time_step;
alpha = A * sin(omega*t) + alpha_mean;
=======
time_iter{:,kk} = 1:(length(history.Inner_Iter)-mod(length(history.Inner_Iter),2))/2;
t{:,kk} = time_iter{:,kk} * time_step;
CL{:,kk} = history.CL(2:2:end);

% compute alpha
alpha{:,kk} = A * sin(omega*(t{:,kk}+firstHistoryStep*time_step)) + alpha_mean; % [°] variable angle of the simulation
cd('../')
end
%% extract Zanotti dataset


extract_exp = readtable(simulationsFolderPath+"../plotDigitizer/DynamicCL_Zanotti_experimental.csv","Delimiter",';');
extract_CFD_720TS = readtable(simulationsFolderPath+"../plotDigitizer/DynamicCL_Zanotti_CFD_G1_720TS.csv","Delimiter",';');

for i = 1: size(extract_exp,1)
    dynamicCL_Zanotti_exp.alpha(i,1) = str2double(replace(extract_exp{i,1}{1},",",".")) ;
    dynamicCL_Zanotti_exp.CL(i,1) = str2double(replace(extract_exp{i,2}{1},",","."));
end

for i = 1: size(extract_CFD_720TS,1)
    dynamicCL_Zanotti_CFD.alpha(i,1) = str2double(replace(extract_CFD_720TS{i,1}{1},",",".")) ;
    dynamicCL_Zanotti_CFD.CL(i,1) = str2double(replace(extract_CFD_720TS{i,2}{1},",","."));
end
>>>>>>> cba0880e43c436cde468b5b1fcff970c2be8d834

% compute error

%% plots
figure
hold on;
plot(alpha{:,1},CL{:,1},'color','#FFA500',"DisplayName","Our simulation, dt small")

plot(alpha{:,2},CL{:,2},'color','#C100FF',"DisplayName","Our simulation, dt higher")

plot(dynamicCL_Zanotti_exp.alpha,dynamicCL_Zanotti_exp.CL, 'k--',"DisplayName",'Zanotti et Al. experiment')
plot(dynamicCL_Zanotti_CFD.alpha,dynamicCL_Zanotti_CFD.CL, 'b--',"DisplayName",'Zanotti et Al. CFD')

xlabel('\alpha [°]')
ylabel('CL [-]')
title('CL-alpha curve, dynamic simulation')
<<<<<<< HEAD


%% plots
figure
plot(alpha,CL_avg,'r.')
xlabel('\alpha [°]')
ylabel('CL [-]')
title('CL-alpha curve, dynamic simulation')

=======
legend
>>>>>>> cba0880e43c436cde468b5b1fcff970c2be8d834
