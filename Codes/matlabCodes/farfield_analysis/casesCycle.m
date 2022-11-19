function [CD,CL,CMz,iter,cauchyCD] = casesCycle()
%{
cycle on the cases considered for POLAR construction, basically on the N angles used, first order or second order
--------------------------------------------------------------------------
Author: Marco Marchesi
--------------------------------------------------------------------------
%}
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

if ~isempty(casesNames)
    sortVector = str2double(erase(casesNames,"caseG"));
    [~,idx_sort] = sort(sortVector);
    casesNames = casesNames(idx_sort);

    % initialize for faster performance
    CD = zeros(1,length(casesNames));
    CL = zeros(1,length(casesNames));
    CMz = zeros(1,length(casesNames));
    


    % array saving cycle
    for idx_C = 1:length(casesNames)

        % move in the simulation folder
        meshNum = erase(casesNames(idx_C),"caseG");
        cd(casesNames(idx_C));

        % count how many restart happened for reaching max iterations
        listingCFD = dir;
        restart_counter = 0;
        for i = 1:size(listingCFD,1)
            if contains(convertCharsToStrings(listingCFD(i).name),"10000")
                restart_counter = restart_counter +1;
            end
        end
        
        cd("cfdG"+meshNum)


        % extract history.csv data
        currentHistory= csvDataLogExtractor("history_G"+meshNum+".csv");

        % simulation name
        CD(idx_C) = currentHistory.CD(end);
        CL(idx_C) = currentHistory.CL(end);
        CMz(idx_C) = currentHistory.CMz(end);
        iter(idx_C) = currentHistory.Inner_Iter(end) + restart_counter*9999;
        cauchyCD(idx_C) = currentHistory.Cauchy_CD_(end);
        cd("../../")
        rmpath(casesNames(idx_C)+"/cfdG"+meshNum)
    end
else
    CD = 0;
    CL = 0;
    CMz = 0;
    iter = 0;
    cauchyCD = 0;
end

