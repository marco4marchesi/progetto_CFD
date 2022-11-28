function [CD,CL,CMz,meshElem,rms,cauchyCD] = AoACycle()
%{
cycle on the order of the numerical scheme, first order or second order
--------------------------------------------------------------------------
Author: Marco Marchesi
--------------------------------------------------------------------------
%}

% retrieve subfolders
warning('off')
listingAngles = dir;

angleNames = [];
for i = 1:size(listingAngles,1)
    if contains(convertCharsToStrings(listingAngles(i).name),".")
        continue
    end
    angleNames = [angleNames; convertCharsToStrings(listingAngles(i).name)];
end

for idx_A = 1:length(angleNames)
    
    cd(angleNames(idx_A))
    try
    [CD.(angleNames(idx_A)),CL.(angleNames(idx_A)),CMz.(angleNames(idx_A)),meshElem.(angleNames(idx_A)),rms.(angleNames(idx_A)),cauchyCD.(angleNames(idx_A))] = orderCycle();
    catch
    end
    cd("../")
    rmpath(angleNames(idx_A))
end
