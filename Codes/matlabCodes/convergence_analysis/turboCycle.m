function [CD,CL,CMz,meshElem, rms, cauchyCD] = turboCycle()
%{
cycle on the order of the numerical scheme, first order or second order
--------------------------------------------------------------------------
Author: Marco Marchesi
--------------------------------------------------------------------------
%}

% retrieve subfolders
listingTurbolence = dir;

turboNames = [];
for i = 1:size(listingTurbolence,1)
    if contains(convertCharsToStrings(listingTurbolence(i).name),".")
        continue
    end
    turboNames = [turboNames; convertCharsToStrings(listingTurbolence(i).name)];
end

for idx_T = 1:length(turboNames)

    cd(turboNames(idx_T))
    try
    [CD.(turboNames(idx_T)),CL.(turboNames(idx_T)),CMz.(turboNames(idx_T)),meshElem.(turboNames(idx_T)),rms.(turboNames(idx_T)),cauchyCD.(turboNames(idx_T))] = AoACycle();
    catch
    end
    cd("../")
    rmpath(turboNames(idx_T))
end
