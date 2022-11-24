%{

Matlab code for extracting data from history files real time while running
simulations

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
    %     simulationsFolderPath = "C:\Users\marco\OneDrive - Politecnico di Milano\MAGISTRALE\TerzoSemestre\CFD\PROGETTO CFD DRIVE\SIMULATIONS DRIVE\Simulations"; % drive
    simulationsFolderPath = "\\wsl.localhost\Ubuntu-20.04\SU2REPO\progetto_CFD\Simulations";
end

if user == "doppio portatile"
    matlabCodesPath = "C:\Users\marco\Desktop\tutto\UNI\2 MAGISTRALE\CFD\CFD PROJECT\progetto_CFD\Codes\matlabCodes";
    simulationsFolderPath = "C:\Users\marco\OneDrive - Politecnico di Milano\MAGISTRALE\TerzoSemestre\CFD\PROGETTO CFD DRIVE\SIMULATIONS DRIVE\Simulations";
    %     simulationsFolderPath = "C:\Users\marco\Desktop\UNI\2 MAGISTRALE\CFD\CFD PROJECT\progetto_CFD\Simulations\"; % locale
end

if user == "luca"
    matlabCodesPath = "C:/Users/lucag/Desktop/Universita/Magistrale Secondo Anno/Computational_fluid_dynamics/Progetto_CFD/progetto_CFD/Codes/matlabCodes\";
%     simulationsFolderPath = "C:/Users/lucag/Desktop/Universita/Magistrale Secondo Anno/Computational_fluid_dynamics/Progetto_CFD/progetto_CFD/Simulations\";
    simulationsFolderPath= "C:\Users\lucag\Desktop\Universita\Magistrale Secondo Anno\Computational_fluid_dynamics\Progetto_CFD\progetto_CFD\Simulations";
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
mainFolder = 'noTransition/FARFIELD_stretto/';
simuFolder = {'SST/O2/caseG26'}; % use single apices because otherwise the erase function does not work as I want



%% ---------------------------------------- select field ----------------------------------------------- %%
fields = ["rms_P_","Cauchy_CD_","CD","CL"];
target = [1e-13;1e-9];
flagFirst = true;
n = 0;
n_iter = 0;
time = 0;

figure('Name',"Logaritmic convergence real time",'Position',[300,200,800,500])
while(stat==true)
n=n+1;
tic
    %% -------------------------------------- Loop on folder simulations! Let's goooooooooooooooooooo -------------------------%%

    for idx_field = 1: length(fields)

        %% LOGARITMIC PLOT
        

        for idx_f = 1: length(simuFolder)

            testcase = mainFolder+"/"+simuFolder{idx_f};
            idx_G = find((simuFolder{idx_f} == 'G')~=(simuFolder{idx_f} =='A'),1,'last');
            meshNum = str2num(erase(simuFolder{idx_f},simuFolder{idx_f}(1:idx_G)));
            warning('off');
            cd(testcase)
            warning('on');
            %% define from which files do the extraction
            listing = dir;
            flagPO = true;

            for kk = 1: length(listing)
                if contains(listing(kk).name,'cfd')
                    flagPO = false;
                end
            end
            if ~flagPO

                currentHistory = csvDataLogExtractor("cfdG"+meshNum+"/history_G"+meshNum+".csv","raw");
            else

                currentHistory = csvDataLogExtractor("history_aoa"+meshNum+".csv","raw");
            end
            
            evolution.(fields(idx_field)) = [currentHistory.(fields(idx_field))];
            n_iter_step = length(evolution.(fields(1)))-n_iter;

            if contains(fields(idx_field),"rms")
                evolution.(fields(idx_field)) = 10.^evolution.(fields(idx_field));
            end

            %% plot
            subplot(2,2,idx_field)
            try
                plotsss(n,idx_field) = semilogy(evolution.(fields(idx_field))(n_iter+1:n_iter+n_iter_step),'k-','DisplayName',replace(simuFolder{idx_f},'_',' '));
            catch
                stat = false;
            end
            hold on;
            xlabel('Iterations')
            ylabel(replace(fields(idx_field),"_"," "))
            cd("../../../../../")
            
        end
        if not(fields(idx_field) == "CD" || fields(idx_field) == "CL" || contains(fields(idx_field),"CFL"))
            yline(target(idx_field),'r--','DisplayName','Convergence target')
        end
        title(replace(fields(idx_field),"_",""))
        
    end
    n_iter = n_iter+n_iter_step;
    drawnow 
    if flagFirst
        flagFirst = false;
    else
        delete(plotsss(n-1,:))
    end
    sgtitle("Real-time logarithmic plot of "+ simuFolder)
pause(10)
time = time + toc;

end
