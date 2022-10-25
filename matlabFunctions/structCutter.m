%{ 

structCutter()

Author: Marco Marchesi - CTR iptl
        marco.marchesi@skywarder.eu

-       Release: 03/09/2022
%}

function structOut = structCutter(structIn,t0,t1)

%{
HELP:
use this function to cut out unwanted values from struct arrays

INPUT:
- structIn: struct that you want to trim from timestamp t0 to timestamp t1
- t0: initial trim time
- t1: final trim time

OUTPUT: 
- structOut: trimmed struct 

%}

namesStructIn = fieldnames(structIn);

% remove first samples
savingValues1 = structIn.(namesStructIn{1})(structIn.(namesStructIn{1})>t0);
len1 = length(savingValues1);

% remove last samples
savingValues2 = savingValues1(savingValues1<t1);
len2 = len1 - length(savingValues2);

if length(structIn.(namesStructIn{1}))-len1 == 0 || len1 == 0
    error('OCIO! You set time window values out of the timestamp boundaries. Also check if the timestamp is in seconds or microseconds.')
end

for i = 1:size(namesStructIn)
    structOut.(namesStructIn{i}) = structIn.(namesStructIn{i})(end-len1:end-len2);
end

end