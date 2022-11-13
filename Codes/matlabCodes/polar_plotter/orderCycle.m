function [CD,CL,CMz] = orderCycle()
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
    if convertCharsToStrings(listingOrders(i).name==".")
        continue
    elseif convertCharsToStrings(listingOrders(i).name=="..")
        continue
    end
    orderNames = [orderNames; convertCharsToStrings(listingOrders(i).name)];
end

for idx_O = 1:length(orderNames)

    cd(orderNames(idx_O))

    [CD.(orderNames(idx_O)),CL.(orderNames(idx_O)),CMz.(orderNames(idx_O))] = casesCycle();
    
    cd("../")
end

