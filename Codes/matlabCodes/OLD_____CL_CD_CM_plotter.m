%{

matlab code for extracting data from history files.

put this matlab.m file into the "simulations" folder in order to make it
work properly!

Author: Marco Marchesi
+ this code aims to extract the CD, CL, and CM values from the simulations
and to automatically save them in a vector that contains the number of
elements in the mesh
+ this is done for checking the convergence of the meshes, we need to
investigate whether the mesh returns a better result w.r.t. the precedent
tried mesh




%}

%% init

clear; close all; clc;

matlabCodesPath = pwd;
cd("../../Simulations/")

%% select which folder (P for prova, SC for Simulation Case)

mainFolder = "./SC_TEST";
addpath(genpath(mainFolder))
cd(mainFolder)
%% list folders and extract names

listing = dir;

folderNames = [];
for i = 1:size(listing,1)
    if convertCharsToStrings(listing(i).name==".")
        continue
    elseif convertCharsToStrings(listing(i).name=="..")
        continue
    end
    folderNames = [folderNames; convertCharsToStrings(listing(i).name)];
end

% manually remove the folders that you don't want to use:
folderNamesSave = folderNames;
idx = 0;
for i = 1:length(folderNames)
    if folderNames(i) == "SST_OPT2_6" || folderNames(i) == "SST_OPT2_7" || folderNames(i) == "SST_OPT4_1" || folderNames(i) == "SST_OPT5" || folderNames(i) == "LAMINAR" || folderNames(i) == "LAMINAR2"
        folderNamesSave = folderNamesSave([1:i-idx-1, i-idx+1:end]);
        idx = idx +1;
    end
end
folderNames = folderNamesSave;

%% find all history.csv files and extract data


for idx_F = 1: length(folderNames)

    % set folder from the folder list
    caseFolder = folderNames(idx_F);

    cd(caseFolder)
    % retrieve subfolders
    listingCases = dir;

    casesNames = [];
    for i = 1:size(listingCases,1)
        if contains(convertCharsToStrings(listingCases(i).name),"case")
            casesNames = [casesNames; convertCharsToStrings(listingCases(i).name)];
        else
            continue
        end
    end
    
   

    for idx_C = 1:length(casesNames)
        
        % move in the simulation folder
        cfdCase = erase(casesNames(idx_C),"case");
        cd(casesNames(idx_C) + "/cfd" + cfdCase)
    
        % extract history.csv data
        currentHistory= csvDataLogExtractor("history_"+cfdCase+".csv");

        % simulation name
        CD.(caseFolder)(idx_C) = currentHistory.CD(end);
        CL.(caseFolder)(idx_C) = currentHistory.CL(end);
%         CM.(caseFolder)(idx_C) = currentHistory.CM(end);

        cd("../../")
    end
    cd("../")
end

clearvars i idx_C idx_F listing listingCases

%% plot values


meshElem = [40176
            63412
            104534
            140135
            173996
            209052
            243478
            289868
            ] ;

CDfigures = figure('Name','Drag Coefficient');
CDfigs.h_tabgroup = uitabgroup(CDfigures);

for i = 1:length(folderNames)

    tabName = "tab"+i;
    
    CDfigs.(tabName) = uitab(CDfigs.h_tabgroup,'Title',folderNames(i));
    CDfigs.(tabName).BackgroundColor = 'white';
    axes('parent',CDfigs.(tabName)); 

    plot(meshElem(i),CD.(folderNames(i)),'ro')
    grid on;

end


%% return to the folder of the matlab code
cd(matlabCodesPath)

