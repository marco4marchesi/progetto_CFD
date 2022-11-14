function [CD,CL,CMz,angles] = casesCycle()
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

sortVector = str2double(erase(casesNames,"case_A"));

[~,idx_sort] = sort(sortVector);
casesNames = casesNames(idx_sort);

if ~isempty(casesNames)
    % initialize for faster performance
    CD = zeros(1,length(casesNames));
    CL = zeros(1,length(casesNames));
    CMz = zeros(1,length(casesNames));

    % array saving cycle
    for idx_C = 1:length(casesNames)

        % move in the simulation folder
        angleCase = erase(casesNames(idx_C),"case_A");
        cd(casesNames(idx_C))

        % extract history.csv data
        currentHistory= csvDataLogExtractor("history_aoa"+angleCase+".csv");

        % simulation name
        CD(idx_C) = currentHistory.CD(end);
        CL(idx_C) = currentHistory.CL(end);
        CMz(idx_C) = currentHistory.CMz(end);
        angle = str2double(angleCase);
        if angle >= 100
            angle = angle /10;
        end
        angles(idx_C) = angle;
        cd("../")
    end
else
    CD = 0;
    CL = 0;
    CMz = 0;
end

