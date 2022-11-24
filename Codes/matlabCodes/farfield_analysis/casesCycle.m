function [CD,CL,CMz,iter,cauchyCD,meshElem] = casesCycle()
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
    CD = zeros(length(casesNames),1);
    CL = zeros(length(casesNames),1);
    CMz = zeros(length(casesNames),1);
    iter = zeros(length(casesNames),1);
    cauchyCD = zeros(length(casesNames),1);
    meshElem = zeros(length(casesNames),1);

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
        try
            currentHistory= csvDataLogExtractor("history_G"+meshNum+".csv");
        % simulation name
            CD(idx_C) = currentHistory.CD(end);
            CL(idx_C) = currentHistory.CL(end);
            CMz(idx_C) = currentHistory.CMz(end);
            iter(idx_C) = currentHistory.Inner_Iter(end) + restart_counter*9999;
            cauchyCD(idx_C) = currentHistory.Cauchy_CD_(end);
        catch
            % simulation name
        CD(idx_C) = 0;
        CL(idx_C) = 0;
        CMz(idx_C) = 0;
        iter(idx_C) = 0;
        cauchyCD(idx_C) = 0;
        end
        cd("../")
        rmpath("cfdG"+meshNum)
        %% extract mesh elements
        cd("meshG"+meshNum)
        % open the file
        fid=fopen("meshG"+num2str(meshNum)+".su2","r"); 
        % set linenum to the desired line number that you want to import
        linenum = 2;
        % use '%s' if you want to read in the entire line or use '%f' if you want to read only the first numeric value
        meshRead = textscan(fid,'%s',1,'delimiter','\n', 'headerlines',linenum-1);
%         fclose(fid)
        idx_num = find(meshRead{1}{1}=='=',1,'first');
        meshElem(idx_C) = str2num(convertCharsToStrings(meshRead{1}{1}(idx_num+2:end)));
        cd("../../")
        rmpath(genpath(casesNames(idx_C)))
    end
else
    CD = 0;
    CL = 0;
    CMz = 0;
    iter = 0;
    cauchyCD = 0;
    meshElem = 0;
end

