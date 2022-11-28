function [CD,CL,CMz,meshElem,rms, cauchyCD] = casesCycle()
%{
cycle on the cases considered, basically on the N meshes used, first order or second order
--------------------------------------------------------------------------
Author: Marco Marchesi
--------------------------------------------------------------------------
%}
% retrieve subfolders
listingCases = dir;
casesNames = [];
flagIncompressible=false;
for i = 1:size(listingCases,1)
    if contains(convertCharsToStrings(listingCases(i).name),"case") && not(contains(convertCharsToStrings(listingCases(i).name),"old"))
        casesNames = [casesNames; convertCharsToStrings(listingCases(i).name)];
    else
        continue
    end

    if contains(convertCharsToStrings(listingCases(i).name),"rms_P_")
        flagIncompressible = true;
    end
end
        
if ~isempty(casesNames)
    % initialize for faster performance
    CD = zeros(length(casesNames),1);
    CL = zeros(length(casesNames),1);
    CMz = zeros(length(casesNames),1);
    meshElem = zeros(length(casesNames),1);
    rms = zeros(length(casesNames),1);
    cauchyCD= zeros(length(casesNames),1);
    % array saving cycle
    for idx_C = 1:length(casesNames)

        % move in the simulation folder
        meshNum = erase(casesNames(idx_C),"caseG");
        cd(casesNames(idx_C)+"/cfdG"+meshNum)

        % extract history.csv data
        currentHistory= csvDataLogExtractor("history_G"+meshNum+".csv");

        % simulation name
        CD(idx_C) = currentHistory.CD(end);
        CL(idx_C) = currentHistory.CL(end);
        CMz(idx_C) = currentHistory.CMz(end);
        if flagIncompressible
            rms(idx_C) = currentHistory.rms_P_(end);

        else
            rms(idx_C) = currentHistory.rms_Rho_(end);
        end
        cauchyCD(idx_C) = currentHistory.Cauchy_CD_(end);
        cd("../")
        warning('off')
        rmpath("cfdG"+meshNum)
        %% extract mesh elements
        cd("meshG"+meshNum)
        % open the file
        fid=fopen("meshG"+num2str(meshNum)+".su2","r"); 
        % set linenum to the desired line number that you want to import
        linenum = 2;
        % use '%s' if you want to read in the entire line or use '%f' if you want to read only the first numeric value
        meshRead = textscan(fid,'%s',1,'delimiter','\n', 'headerlines',linenum-1);
        idx_num = find(meshRead{1}{1}=='=',1,'first');
        meshElem(idx_C) = str2num(convertCharsToStrings(meshRead{1}{1}(idx_num+2:end)));
        cd("../../")
        rmpath(genpath(casesNames(idx_C)))
    end
else
    CD = 0;
    CL = 0;
    CMz = 0;
end

