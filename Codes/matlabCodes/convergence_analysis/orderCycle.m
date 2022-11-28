function [CD,CL,CMz,meshElem,rms,cauchyCD] = orderCycle()
%{
cycle on the order of the numerical scheme, first order or second order
--------------------------------------------------------------------------
Author: Marco Marchesi
--------------------------------------------------------------------------
%}

% retrieve subfolders
listingOrders = dir;
orderNames = [];
for i = 1:size(listingOrders,1)
    if contains(convertCharsToStrings(listingOrders(i).name),".")
        continue
    end
    orderNames = [orderNames; convertCharsToStrings(listingOrders(i).name)];
end

for idx_O = 1:length(orderNames)

    cd(orderNames(idx_O))
    try
    [CD.(orderNames(idx_O)),CL.(orderNames(idx_O)),CMz.(orderNames(idx_O)),meshElem.(orderNames(idx_O)),rms.(orderNames(idx_O)),cauchyCD.(orderNames(idx_O))] = casesCycle();
    catch
    end
    cd("../")
    rmpath(orderNames(idx_O))
end

