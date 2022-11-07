%{

matlab code for extracting data from history files.

put this matlab.m file into the "simulations" folder in order to make it
work properly!

--------------------------------------------------------------------------
Author: Marco Marchesi
--------------------------------------------------------------------------

+   this code aims to extract the CD, CL, and CM values from the simulations
    and to automatically save them in a vector that contains the number of
    elements in the mesh

+   this is done for checking the convergence of the meshes, we need to
    investigate whether the mesh returns a better result w.r.t. the precedent
    tried mesh

%}

%% init

% user: set who is running the code so that the folder is chosen:
user = "doppio fisso"; % choices: "doppio fisso" "luca" ...

if user == "doppio fisso"
    matlabCodesPath = "C:\Users\marco\Desktop\UNI\2 MAGISTRALE\CFD\CFD PROJECT\progetto_CFD\Codes\matlabCodes";
    simulationsFolderPath = "C:\Users\marco\OneDrive - Politecnico di Milano\MAGISTRALE\TerzoSemestre\CFD\PROGETTO CFD DRIVE\SIMULATIONS DRIVE\Simulations";
end

if user == "luca"
    matlabCodesPath = "pippo";
    simulationsFolderPath = "paperino";
end

% 
clearvars -except matlabCodesPath simulationsFolderPath; 
close all; clc;

addpath(genpath(matlabCodesPath))


currentFolder = pwd;
if not(strcmp(currentFolder, matlabCodesPath))
    cd(matlabCodesPath)
end

cd(simulationsFolderPath)
matlab_graphics;

%% select which folder (P for prova, SC for Simulation Case)

mainFolder = "SC/";
addpath(genpath(mainFolder))
cd(mainFolder)

%% retrieve all the CD, CL, CMz values
[CD,CL,CMz] = turboCycle();

cd(matlabCodesPath)

%% plot values

% elements of the meshes - plug here the values
meshElem = [88546
            136104
            209052
            289868
            392644
            549126
            782484];


%{ 
graphics: list of options:

- option1:  all plots for CD, CL, CMz in their window, one plot per tab 
- option2:  all plots for CD, CL, CMz in their window, comparing 1st and 2nd
            order on each tab
- option3:  ---
%}

savePlots = false;
mkdir("IMAGES")
graphics_option2;






