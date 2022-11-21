%{

Matlab code for extracting data from history files of SINGLE mesh simulations.

--------------------------------------------------------------------------
Author: Marco Marchesi
--------------------------------------------------------------------------

+   this code aims to extract the CD, CL, and CM values from the simulations
    and to automatically save them in a vector that contains the number of
    elements in the mesh

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

+   set

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
clc; close all;


% add matlab functions to the path
rmpath(matlabCodesPath+"/polar_plotter")
rmpath(matlabCodesPath+"/farfield_analysis")
addpath(matlabCodesPath)
addpath(matlabCodesPath+"/convergence_analysis")
addpath(matlabCodesPath+"/utilitiesFunctions")

% move to simulation folder
cd(simulationsFolderPath)
matlab_graphics;










%% ------------------------------------ CHOSE SIMULATION (FOLDER) -------------------------------------- %% 
mesh = "21";
simuFolders = [ "SST_different_CFL_max"
                "SST_restart_mesh_piccola"];

%% ---------------------------------------- select field ----------------------------------------------- %%
field = "Cauchy_CD_";
target = 1e-9;











%% -------------------------------------- Loop on folder simulations! Let's goooooooooooooooooooo -------------------------%%


%% NORMAL PLOT
figure('Name',"Convergence history of " + field,'Position',[100,100,800,500])
    
for idx_f = 1: length(simuFolders)

    testcase = "FARFIELD2/"+simuFolders(idx_f)+"/O2/caseG"+mesh;
    cd(testcase)
    
    %% define from which files do the extraction
    foldVec = ["first","second","third","fourth","fifth","sixth","seventh"]; % i frankly doubt you will have more than that
    
    listing = dir;
    j = 0;
    % extract how many restart of 10000 iterations have been done:
    for i = 1:size(listing,1)
        if contains(convertCharsToStrings(listing(i).name),"10000")
            j= j+1;
        end
    end
    for k = 1:j+1
        if k <= j
            currentHistory{k} = csvDataLogExtractor(foldVec(k)+"10000iter/history_G"+mesh+".csv","raw");
        else
            currentHistory{k} = csvDataLogExtractor("cfdG"+mesh+"/history_G"+mesh+".csv","raw");
        end
    end
    
    evolution.(field) = [];
    for j = 1:length(currentHistory)
        evolution.(field) = [evolution.(field); currentHistory{j}.(field)(10:end)];
    end


    %% plot
    if contains(field,"rms")
        plot(10.^evolution.(field),'DisplayName',replace(simuFolders(idx_f),'_',' '))
        hold on;
        xlabel('Iterations')
        ylabel(field)
    else   
        plot(evolution.(field),'DisplayName',replace(simuFolders(idx_f),'_',' '))
        hold on;
        xlabel('Iterations')
        ylabel(field)
    end
    cd("../../../../")
    rmpath(testcase)
end
yline(target,'r--','DisplayName','Convergence target')
legend
title("Convergence history of " + replace(field,"_"," "))














clearvars currentHistory evolution j
%% LOGARITMIC PLOT
figure('Name',"Logaritmic convergence history of " + field,'Position',[100,100,800,500])
    
for idx_f = 1: length(simuFolders)

    testcase = "FARFIELD2/"+simuFolders(idx_f)+"/O2/caseG"+mesh;
    cd(testcase)
    
    %% define from which files do the extraction
    foldVec = ["first","second","third","fourth","fifth","sixth","seventh"]; % i frankly doubt you will have more than that
    
    listing = dir;
    % extract how many restart of 10000 iterations have been done:
    j = 0;
    for i = 1:size(listing,1)
        if contains(convertCharsToStrings(listing(i).name),"10000")
            j= j+1;
        end
    end
    for k = 1:j+1
        if k <= j
            currentHistory{k} = csvDataLogExtractor(foldVec(k)+"10000iter/history_G"+mesh+".csv","raw");
        else
            currentHistory{k} = csvDataLogExtractor("cfdG"+mesh+"/history_G"+mesh+".csv","raw");
        end
    end
    
    evolution.(field) = [];
    for j = 1:length(currentHistory)
        evolution.(field) = [evolution.(field); currentHistory{j}.(field)(10:end)];
    end


    %% plot
    if contains(field,"rms")
        semilogy(10.^evolution.(field),'DisplayName',replace(simuFolders(idx_f),'_',' '))
        hold on;
        xlabel('Iterations')
        ylabel(field)
        
        legend
    else   
        semilogy(evolution.(field),'DisplayName',replace(simuFolders(idx_f),'_',' '))
        hold on;
        xlabel('Iterations')
        ylabel(field)
        legend
    end
    cd("../../../../")
end
yline(target,'r--','DisplayName','Convergence target')
title("Logarithmic history of " + replace(field,"_"," "))
