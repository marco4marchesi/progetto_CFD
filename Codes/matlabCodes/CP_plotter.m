%{

CP plotter: from 

%}

%% init

clear; close all; clc;

cd("../../Simulations/")

%% select which folder (P for prova, SC for Simulation Case)

% select case folder (where you saved the .csv files)
caseFolder = "./P/P1/caseG1/cfdG1/POL_results";
addpath(genpath(caseFolder))
cd(caseFolder)

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

for i = 1:size(caseNames,1)
    j = str2double(erase(caseNames(i),"sim"))+1; % +1 because pyhton enumerates them from 0

    sim = csvDataLogExtractor(caseFiles(i),"raw");
    CP_vec = sim.Pressure_Coefficient;

    idx_up = find(isnan(CP_vec),1,"last")+1;
    idx_bott = find(isnan(CP_vec),1,"first")-1;

    if isempty(idx_up)
        idx_up = round(length(CP_vec)/2)+1;
    else
        CP_upper(j) = CP_vec(idx_up);
    end

    if isempty(idx_bott)
        idx_bott = round(length(CP_vec)/2)+1;
    else
        CP_bottom(j) = CP_vec(idx_bott);
    end
end

x_vec = linspace(0,1.008,length(CP_bottom));


%% save as a .mat file so that on github we can run the code without pushing the .csv files
save("../CP","CP_bottom","CP_upper","x_vec") 

%% plot

figure('Name','CP for test case')
plot(x_vec,-CP_upper)
hold on; grid on;
plot(x_vec,-CP_bottom)
xlabel('x [m]')
ylabel('CP [-]')
legend('Upper','Bottom')
title('CP over airfoil')
