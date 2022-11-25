function [CD,CL,CMz,meshElem] = turboCycle()
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

    [CD.(turboNames(idx_T)),CL.(turboNames(idx_T)),CMz.(turboNames(idx_T)),meshElem.(turboNames(idx_T))] = AoACycle();

    cd("../")
    rmpath(turboNames(idx_T))
end
