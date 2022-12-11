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
    simulationsFolderPath = "C:\Users\marco\OneDrive - Politecnico di Milano\MAGISTRALE\TerzoSemestre\CFD\PROGETTO CFD DRIVE\SIMULATIONS DRIVE\Simulations\";
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




%% ------------------------------------ CHOSE SIMULATION (FOLDER) -------------------------------------- %%
mainFolder = ["TC1";"TC2";"TC1_LM";"TC2_LM";"TC3_LM";"TC4_LM"];
simuFolder = '/HISTORY'; % if some errors occur try using single apices

% do you want to plot ONLY THE LAST PERIOD?
casePeriod = 'last'; % options: {'last', 'first', ''}



%% extract Zanotti dataset

extract_ZANO_exp = readtable(simulationsFolderPath+"../plotDigitizer/DynamicCL_Zanotti_experimental.csv","Delimiter",';');
extract_ZANO_CFD_720TS = readtable(simulationsFolderPath+"../plotDigitizer/DynamicCL_Zanotti_CFD_G1_720TS.csv","Delimiter",';');

for i = 1: size(extract_ZANO_exp,1)
    dynamicCL_Zanotti_exp.alpha(i,1) = str2double(replace(extract_ZANO_exp{i,1}{1},",",".")) ;
    dynamicCL_Zanotti_exp.CL(i,1) = str2double(replace(extract_ZANO_exp{i,2}{1},",","."));
end

% extract area integral
[~,idx_mincfd]  = min(dynamicCL_Zanotti_exp.alpha);
[~,idx_maxcfd]  = max(dynamicCL_Zanotti_exp.alpha);

if idx_mincfd<idx_maxcfd
    area_upEXP = trapz(dynamicCL_Zanotti_exp.alpha(idx_mincfd:idx_maxcfd),dynamicCL_Zanotti_exp.CL(idx_mincfd:idx_maxcfd));
    area_downEXP = trapz(dynamicCL_Zanotti_exp.alpha(idx_maxcfd:end),dynamicCL_Zanotti_exp.CL(idx_maxcfd:end))+trapz(dynamicCL_Zanotti_exp.alpha(1:idx_mincfd),dynamicCL_Zanotti_exp.CL(1:idx_mincfd));
else
    area_downEXP = trapz(dynamicCL_Zanotti_exp.alpha(idx_maxcfd:idx_mincfd),dynamicCL_Zanotti_exp.CL(idx_maxcfd:idx_mincfd));
    area_upEXP = trapz(dynamicCL_Zanotti_exp.alpha(1:idx_maxcfd),dynamicCL_Zanotti_exp.CL(1:idx_maxcfd));
end
area_zanoEXP = area_upEXP-area_downEXP;


% extract area integral
for i = 1: size(extract_ZANO_CFD_720TS,1)
    dynamicCL_Zanotti_CFD.alpha(i,1) = str2double(replace(extract_ZANO_CFD_720TS{i,1}{1},",",".")) ;
    dynamicCL_Zanotti_CFD.CL(i,1) = str2double(replace(extract_ZANO_CFD_720TS{i,2}{1},",","."));
end

% [~,idx_mincfd]  = min(dynamicCL_Zanotti_CFD.alpha);
% [~,idx_maxcfd]  = max(dynamicCL_Zanotti_CFD.alpha);
% 
% 
% if idx_mincfd<idx_maxcfd
%     area_upCFD = trapz(alpha{:,kk}(idx_mincfd(kk):idx_maxcfd(kk)),CL{:,kk}(idx_mincfd(kk):idx_maxcfd(kk)));
%     area_downCFD = trapz(alpha{:,kk}(idx_maxcfd(kk):end),CL{:,kk}(idx_maxcfd(kk):end))+trapz(alpha{:,kk}(1:idx_mincfd(kk)),CL{:,kk}(1:idx_mincfd(kk)));
% 
% else
%     area_downCFD(kk,1) = trapz(alpha{:,kk}(idx_maxcfd(kk):idx_mincfd(kk)),CL{:,kk}(idx_maxcfd(kk):idx_mincfd(kk)));
%     area_upCFD(kk,1) = trapz(alpha{:,kk}(idx_mincfd(kk):end),CL{:,kk}(idx_mincfd(kk):end))+trapz(alpha{:,kk}(1:idx_maxcfd(kk)),CL{:,kk}(1:idx_maxcfd(kk)));
% end
% 
% area_zanoCFD = area_upCFD-area_downCFD;

%% cfd data
for kk = 1:size(mainFolder,1)
testcase = strcat(mainFolder(kk,:),simuFolder);
cd(testcase)


%% data extraction and post processing

% data extraction
listing = dir("*.csv");

history = struct('Inner_Iter',[],'CL',[],'cauchyCL',[]);
for j = 1:length(listing)
currentHistory = csvDataLogExtractor(listing(j).name);
history.Inner_Iter = [history.Inner_Iter; currentHistory.Inner_Iter(currentHistory.Inner_Iter~=0)];
history.CL = [history.CL; currentHistory.CL(currentHistory.Inner_Iter~=0)];
history.cauchyCL = [history.cauchyCL; currentHistory.Cauchy_CL_(currentHistory.Inner_Iter~=0)];
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
        time_step(kk)= 0.02 * chord/fsV;        % [s] timestep of the simulation
        T_period(kk) = 1571;
    case 'TC2'
        time_step(kk)= 5*0.02 * chord/fsV;      % [s] timestep of the simulation
        T_period(kk) = 314;
    case 'TC1_LM'
        time_step(kk)= 0.02 * chord/fsV;        % [s] timestep of the simulation
        T_period(kk) = 1571;
    case 'TC2_LM'
        time_step(kk)= 5*0.02 * chord/fsV;      % [s] timestep of the simulation
        T_period(kk) = 314;
    case 'TC3_LM'
        time_step(kk)= 25*0.02 * chord/fsV;      % [s] timestep of the simulation
        T_period(kk) = 63;
    case 'TC4_LM'
        time_step(kk)= 5*0.02 * chord/fsV;      % [s] timestep of the simulation
        T_period(kk) = 314;
end



time_iter{:,kk} = 1:length(history.Inner_Iter);
inner_iter{:,kk} = history.Inner_Iter;
t{:,kk} = time_iter{:,kk} * time_step(kk)+firstHistoryStep*time_step(kk);
CL{:,kk} = history.CL;

% compute alpha
alpha{:,kk} = A * sin(omega*(t{:,kk})) + alpha_mean; % [°] variable angle of the simulation

cauchyCL{:,kk} = history.cauchyCL;



if length(inner_iter{:,kk}) > T_period(kk)
    switch casePeriod
        case 'last'
    time_iter{:,kk} = time_iter{:,kk}(end-T_period(kk):end);
    inner_iter{:,kk} = inner_iter{:,kk}(end-T_period(kk):end);
    t{:,kk} = t{:,kk}(end-T_period(kk):end);
    alpha{:,kk} = alpha{:,kk}(end-T_period(kk):end);
    cauchyCL{:,kk} = cauchyCL{:,kk}(end-T_period(kk):end);
    CL{:,kk} = CL{:,kk}(end-T_period(kk):end);
%     correction{:,kk} = correction{:,kk}(end-T_period(kk):end);
        case 'first'
    time_iter{:,kk} = time_iter{:,kk}(1:T_period(kk));
    inner_iter{:,kk} = inner_iter{:,kk}(1:T_period(kk));
    t{:,kk} = t{:,kk}(1:T_period(kk));
    alpha{:,kk} = alpha{:,kk}(1:T_period(kk));
    cauchyCL{:,kk} = cauchyCL{:,kk}(1:T_period(kk));
    CL{:,kk} = CL{:,kk}(1:T_period(kk));
%     correction{:,kk} = correction{:,kk}(1:T_period(kk));
    end



%% compute cycle area    
[~,idx_mincfd(kk)]  = min(alpha{:,kk});
[~,idx_maxcfd(kk)]  = max(alpha{:,kk});

if idx_mincfd<idx_maxcfd
    area_up(kk,1) = trapz(alpha{:,kk}(idx_mincfd(kk):idx_maxcfd(kk)),CL{:,kk}(idx_mincfd(kk):idx_maxcfd(kk)));
    area_down(kk,1) = trapz(alpha{:,kk}(idx_maxcfd(kk):end),CL{:,kk}(idx_maxcfd(kk):end))+trapz(alpha{:,kk}(1:idx_mincfd(kk)),CL{:,kk}(1:idx_mincfd(kk)));

else
    area_down(kk,1) = trapz(alpha{:,kk}(idx_maxcfd(kk):idx_mincfd(kk)),CL{:,kk}(idx_maxcfd(kk):idx_mincfd(kk)));
    area_up(kk,1) = trapz(alpha{:,kk}(idx_mincfd(kk):end),CL{:,kk}(idx_mincfd(kk):end))+trapz(alpha{:,kk}(1:idx_maxcfd(kk)),CL{:,kk}(1:idx_maxcfd(kk)));
end


%% compute error
% m = (CL{:,kk}(idx_maxcfd)-dynamicCL_Zanotti_CFD.CL()-(CL{:,kk}(idx_mincfd)-dynamicCL_Zanotti_CFD.CL(idx_minzano)))/(19);
% y = @(x) m*x + (CL{:,kk}(idx_mincfd)-dynamicCL_Zanotti_CFD.CL(idx_minzano));
% 
% corr = y(alpha{:,kk});
% correction{:,kk} = corr';
end
cd("../../")
end

%% compute error on area cycle
area = area_up-area_down;
area_err_perc = (area - area_zanoEXP)/area_zanoEXP*100;



%% plot CL vs alpha of the dynamic simulation
figure('Position',[200,180,800,500])
hold on;
% plot(alpha{:,1},CL{:,1},'color','#FFA500',"DisplayName",replace(mainFolder(1),'_',' '))
% plot(alpha{:,2},CL{:,2},'color','#C100FF',"DisplayName",replace(mainFolder(2),'_',' '))
plot(alpha{:,3},CL{:,3},'color','r',"DisplayName",replace(mainFolder(3),'_',' '))
% plot(alpha{:,4},CL{:,4},'color','g',"DisplayName",replace(mainFolder(4),'_',' '))
% plot(alpha{:,5},CL{:,5},'color','c',"DisplayName",replace(mainFolder(5),'_',' '))
plot(alpha{:,6},CL{:,6},'color','c',"DisplayName",replace(mainFolder(6),'_',' '))

plot(dynamicCL_Zanotti_exp.alpha,dynamicCL_Zanotti_exp.CL, 'k--',"DisplayName",'Zanotti et Al. experiment')
plot(dynamicCL_Zanotti_CFD.alpha,dynamicCL_Zanotti_CFD.CL, 'b--',"DisplayName",'Zanotti et Al. CFD')

xlabel('\alpha [°]')
ylabel('CL [-]')
title('CL-alpha curve, dynamic simulation')
legend

return
%% plot convergence criteria

figure('Position',[200,180,800,500])
subplot(1,2,1)
hold on;
% plot(time_iter{:,1}*time_step(1), cauchyCL{:,1},'color','#FFA500',"DisplayName",replace(mainFolder(1),'_',' '))
% plot(time_iter{:,2}*time_step(2), cauchyCL{:,2},'color','#C100FF',"DisplayName",replace(mainFolder(2),'_',' '))
plot(time_iter{:,3}*time_step(3), cauchyCL{:,3},'color','r',"DisplayName",replace(mainFolder(3),'_',' '))
plot(time_iter{:,4}*time_step(4), cauchyCL{:,4},'color','g',"DisplayName",replace(mainFolder(4),'_',' '))
plot(time_iter{:,5}*time_step(5), cauchyCL{:,5},'color','c',"DisplayName",replace(mainFolder(5),'_',' '))

xlabel('Simulation time')
ylabel('cauhcy CL')
title('cauchy CL over time')
legend

subplot(1,2,2)
hold on;
% plot(time_iter{:,1}*time_step(1), inner_iter{:,1},'color','#FFA500',"DisplayName",replace(mainFolder(1),'_',' '))
% plot(time_iter{:,2}*time_step(2), inner_iter{:,2},'color','#C100FF',"DisplayName",replace(mainFolder(2),'_',' '))
plot(time_iter{:,3}*time_step(3), inner_iter{:,3},'color','r',"DisplayName",replace(mainFolder(3),'_',' '))
plot(time_iter{:,4}*time_step(4), inner_iter{:,4},'color','g',"DisplayName",replace(mainFolder(4),'_',' '))
plot(time_iter{:,5}*time_step(5), inner_iter{:,5},'color','c',"DisplayName",replace(mainFolder(5),'_',' '))

xlabel('Simulation time')
ylabel('Inner iterations')
title('Inner iterations over time')
legend

%%
figure('Position',[200,180,800,500])
subplot(1,2,1)
yyaxis left
plot(time_iter{:,3}*time_step(3), cauchyCL{:,3},'color','r',"DisplayName","cauchy"+replace(mainFolder(3),'_',' '))
yyaxis right
plot(time_iter{:,3}*time_step(3), inner_iter{:,3},'color','g',"DisplayName","iter"+replace(mainFolder(3),'_',' '))
legend
title(replace(mainFolder(3),'_',' '))

subplot(1,2,2)
yyaxis left
plot(time_iter{:,4}*time_step(4), cauchyCL{:,4},'color','r',"DisplayName","cauchy"+replace(mainFolder(4),'_',' '))
yyaxis right
plot(time_iter{:,4}*time_step(4), inner_iter{:,4},'color','g',"DisplayName","iter"+replace(mainFolder(4),'_',' '))
legend
title(replace(mainFolder(4),'_',' '))