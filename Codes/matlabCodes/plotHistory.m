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
mainFolder = 'PO';
simuFolders = { 'SA/O2_stretto/case_A-4';
                'SA/O2_stretto/case_A-2';
                'SA/O2_stretto/case_A0';
                'SA/O2_stretto/case_A2';
                'SA/O2_stretto/case_A4';
                'SA/O2_stretto/case_A6';
                'SA/O2_stretto/case_A8'}; % use single apices because otherwise the erase function does not work as I want



%% ---------------------------------------- select field ----------------------------------------------- %%
fields = ["rms_P_","Cauchy_CD_","CD","CL","MaxCFL"];
target = [1e-13;1e-9];










%% -------------------------------------- Loop on folder simulations! Let's goooooooooooooooooooo -------------------------%%

for idx_field = 1: length(fields)

    %% LOGARITMIC PLOT
    figure('Name',"Logaritmic convergence history of " + fields(idx_field),'Position',[100,100,800,500])

    for idx_f = 1: length(simuFolders)
        
        testcase = mainFolder+"/"+simuFolders{idx_f};
        idx_G = find((simuFolders{idx_f} == 'G')~=(simuFolders{idx_f} =='A'),1,'last');
        meshNum = str2num(erase(simuFolders{idx_f},simuFolders{idx_f}(1:idx_G)));
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
        flagPO = true;
        for kk = 1: length(listing)
            if contains(listing(i).name,'cfd')
                flagPO = false;
            end
        end
        if ~flagPO
            for k = 1:j+1
                if k <= j
                    currentHistory{k} = csvDataLogExtractor(foldVec(k)+"10000iter/history_G"+meshNum+".csv","raw");
                else
                    currentHistory{k} = csvDataLogExtractor("cfdG"+meshNum+"/history_G"+meshNum+".csv","raw");
                end
            end
        else
            for k = 1:j+1
                if k <= j
                    currentHistory{k} = csvDataLogExtractor(foldVec(k)+"10000iter/history_G"+meshNum+".csv","raw");
                else
                    currentHistory{k} = csvDataLogExtractor("history_aoa"+meshNum+".csv","raw");
                end
            end
        end
        evolution.(fields(idx_field)) = [];
        for j = 1:length(currentHistory)
            evolution.(fields(idx_field)) = [evolution.(fields(idx_field)); currentHistory{j}.(fields(idx_field))(10:end)];
        end
        if contains(fields(idx_field),"rms")
            evolution.(fields(idx_field)) = 10.^evolution.(fields(idx_field));
        end

        %% plot
        semilogy(evolution.(fields(idx_field)),'DisplayName',replace(simuFolders{idx_f},'_',' '))
        hold on;
        xlabel('Iterations')
        ylabel(replace(fields(idx_field),"_"," "))
        legend
        cd("../../../../")
    end
    if not(fields(idx_field) == "CD" || fields(idx_field) == "CL" || contains(fields(idx_field),"CFL"))
        yline(target(idx_field),'r--','DisplayName','Convergence target')
    end
    title("Logarithmic history of " + replace(fields(idx_field),"_","") + " mesh: G"+meshNum)

end


%% compare fields:

% which fields do you want to plot together?
fieldsToCompare = ["Cauchy_CD_","MaxCFL","rms_P_"];

% plot
figure('Name','Comparison')
hold on; grid on;
for i = 1: length(fieldsToCompare)
    subplot(length(fieldsToCompare),1,i)
    semilogy(evolution.(fieldsToCompare(i)),'DisplayName',replace(fieldsToCompare(i),"_"," "))
    legend
end
