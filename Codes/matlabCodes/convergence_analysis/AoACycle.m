function [CD,CL,CMz] = AoACycle()
%{
cycle on the order of the numerical scheme, first order or second order
--------------------------------------------------------------------------
Author: Marco Marchesi
--------------------------------------------------------------------------
%}

% retrieve subfolders

listingAngles = dir;

angleNames = [];
for i = 1:size(listingAngles,1)
    if convertCharsToStrings(listingAngles(i).name==".")
        continue
    elseif convertCharsToStrings(listingAngles(i).name=="..")
        continue
    end
    angleNames = [angleNames; convertCharsToStrings(listingAngles(i).name)];
end

for idx_A = 1:length(angleNames)

    cd(angleNames(idx_A))

    [CD.(angleNames(idx_A)),CL.(angleNames(idx_A)),CMz.(angleNames(idx_A))] = orderCycle();

    cd("../")
end
