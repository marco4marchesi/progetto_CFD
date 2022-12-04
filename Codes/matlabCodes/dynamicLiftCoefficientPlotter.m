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
user = "doppio fisso"; % choices: "doppio fisso" "luca" ...

if user == "doppio fisso"
    matlabCodesPath = "C:\Users\marco\Desktop\UNI\2 MAGISTRALE\CFD\CFD PROJECT\progetto_CFD\Codes\matlabCodes";
    simulationsFolderPath = "C:\Users\marco\OneDrive - Politecnico di Milano\MAGISTRALE\TerzoSemestre\CFD\PROGETTO CFD DRIVE\SIMULATIONS DRIVE\Simulations";
%     simulationsFolderPath = "C:\Users\marco\Desktop\UNI\2 MAGISTRALE\CFD\CFD PROJECT\progetto_CFD\Simulations\"; % locale
end

if user == "doppio portatile"
    matlabCodesPath = "C:\Users\marco\Desktop\tutto\UNI\2 MAGISTRALE\CFD\CFD PROJECT\progetto_CFD\Codes\matlabCodes";
    simulationsFolderPath = "C:\Users\marco\OneDrive - Politecnico di Milano\MAGISTRALE\TerzoSemestre\CFD\PROGETTO CFD DRIVE\SIMULATIONS DRIVE\Simulations";
%     simulationsFolderPath = "C:\Users\marco\Desktop\UNI\2 MAGISTRALE\CFD\CFD PROJECT\progetto_CFD\Simulations\"; % locale
end

if user == "luca"
    matlabCodesPath = "C:/Users/lucag/Desktop/Universita/Magistrale Secondo Anno/Computational_fluid_dynamics/Progetto_CFD/progetto_CFD/Codes/matlabCodes\";
    simulationsFolderPath = "C:/Users/lucag/Desktop/Universita/Magistrale Secondo Anno/Computational_fluid_dynamics/Progetto_CFD/progetto_CFD/Simulations\";
end

%% init 
clearvars -except matlabCodesPath simulationsFolderPath; 
close all; clc;

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




% %% ------------------------------------ CHOSE SIMULATION (FOLDER) -------------------------------------- %%
% mainFolder = 'FARFIELD3/';
% simuFolder = 'SST/O2/caseG24/cfdG24'; % use single apices because otherwise the erase function does not work as I want
% fileName = "history_G24.csv";
% 
% %% LOGARITMIC PLOT
% 
% testcase = strcat(mainFolder,simuFolder);
% cd(testcase)


cd('\\wsl.localhost\Ubuntu-20.04\SU2REPO\CFD-webeep-files\Lab 4 - Pitching Airfoil\CFD')



%% data extraction and post processing
currentHistory = csvDataLogExtractor("history.csv");

% build alpha function
A = 10;                             % [°] amplitude
time_step= 9.231914044466431e-4;    % [s] timestep of the simulation
omega = 6.28;                       % [rad/s] pitching pulsation of the simulation
alpha_mean = 10;                    % [°] mean angle of the simulation

% extract variables from simulation
time_iter = currentHistory.Time_Iter;
t = time_iter * time_step;
CL = currentHistory.CL;

% compute alpha
alpha = A * sin(omega*t) + alpha_mean;


%% plots
figure
plot(alpha,CL,'r.')
xlabel('\alpha [°]')
ylabel('CL [-]')
title('CL-alpha curve, dynamic simulation')
