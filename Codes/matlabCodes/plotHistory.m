%{

Matlab code for extracting data from history files of multiple mesh simulations.

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

%% 
mesh = "27";
testcase = "FARFIELD2/SST/O2/caseG"+mesh;
cd(testcase)

%% define from which files do the extraction
% currentHistory{1} = csvDataLogExtractor("first10000iter/history_G"+mesh+".csv","raw");
% currentHistory{2} = csvDataLogExtractor("second10000iter/history_G"+mesh+".csv","raw");
% currentHistory{3} = csvDataLogExtractor("third10000iter/history_G"+mesh+".csv","raw");

if exist('currentHistory','var')==1
    counter = length(currentHistory)+1;
else
    counter = 1;
end
currentHistory{counter} = csvDataLogExtractor("cfdG"+mesh+"/history_G"+mesh+".csv","raw");

%% select field
fields = ["Cauchy_CD_";"rms_P_";"CD";"CL"];
% target for the field chosen
target = [1e-7,-9,1e-3,1];

idx = 1;
for i = idx
    evolution.(fields(i)) = [];
    for j = 1:length(currentHistory)
        evolution.(fields(i)) = [evolution.(fields(i)); currentHistory{j}.(fields(i))(10:end)];
    end
end
%% plot
figure('Name',"Convergence history",'Position',[100,100,800,500])
for i = idx
    plot(evolution.(fields(i)),'DisplayName',fields(i))
    hold on;
    xlabel('Iterations')
    ylabel(fields(i))
    if contains(fields(i),"rms")
        yline(10.^target(i),'r--','DisplayName','Convergence target')
    else
        yline(target(i),'r--','DisplayName','Convergence target')
    end
    xlim([0,length(evolution.(fields(i)))])
    title("Convergence history of " + fields(i))
    legend
end

% evolution.(field+"_filtered") = movmean()
figure('Name',"Convergence history logarithmic",'Position',[100,100,800,500])
for i = idx%:length(fields)
%     subplot(2,1,i)
    if contains(fields(i),"rms")
        semilogy(10.^(movmean(evolution.(fields(i)),100)),'DisplayName',fields(i))
    else
        semilogy(movmean(evolution.(fields(i)),100),'DisplayName',fields(i))
    end
    hold on;
    xlabel('Iterations')
    ylabel(fields(i))
    if contains(fields(i),"rms")
        yline(10.^target(i),'r--','DisplayName','Convergence target')
        ylim([10.^target(i)/10,10.^target(i)*100])
    else
        yline(target(i),'r--','DisplayName','Convergence target')
        ylim([target(i)/10,target(i)*1000])
    end
    xlim([0,length(evolution.(fields(i)))])
    title("Filtered logarithmic history of " + fields(i))
    legend

end
