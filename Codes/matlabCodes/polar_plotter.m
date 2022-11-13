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

if user == "luca"
    matlabCodesPath = "C:/Users/lucag/Desktop/Universita/Magistrale Secondo Anno/Computational_fluid_dynamics/Progetto_CFD/progetto_CFD/Codes/matlabCodes\";
    simulationsFolderPath = "C:/Users/lucag/Desktop/Universita/Magistrale Secondo Anno/Computational_fluid_dynamics/Progetto_CFD/progetto_CFD/Simulations\";
end

%% init 
clearvars -except matlabCodesPath simulationsFolderPath; 
close all; clc;

% add matlab functions to the path
addpath(matlabCodesPath)
addpath(matlabCodesPath+"/polar_plotter")
addpath(matlabCodesPath+"/utillitiesFunctions")

% move to simulation folder
cd(simulationsFolderPath)
matlab_graphics;

%% select which folder (P for prova, SC for Simulation Case)

mainFolder = "PO/";
addpath(genpath(mainFolder))
cd(mainFolder)
%% retrieve values from multiple angles simulations:

[CD,CL,CMz] = turboCycle();

cd(matlabCodesPath)
%% plot values

% elements of the meshes - plug here the values
angles = [  0
            2
            4
            6
            8
            10
            12
            14];

%{ 
graphics: list of options:

- option1:  all plots for CD, CL, CMz in their window, one plot per tab 
- option2:  all plots for CD, CL, CMz in a single window, comparing 1st and 2nd
            order in each tab
- option3:  all plots for CD, CL, CMz in a single window, comparing the
            combinations of turbulence and angles of attack in each tab
%}

savePlots = false;
mkdir("IMAGES_polar")
graphics_option;