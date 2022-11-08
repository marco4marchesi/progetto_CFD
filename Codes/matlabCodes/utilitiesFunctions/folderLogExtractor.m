%{ 

folderLogExtractor()

Author: Marco Marchesi - CTR iptl
        marco.marchesi@skywarder.eu

-       Release: 03/09/2022
%}

function extraction = folderLogExtractor(logFolder,options)

%{
HELP:
function to use if you want to extract data into .csv files
INPUT:
- logFolder:  folder where you stored your .csv files

OUTPUT:
- extraction: struct containing other structs containing all .csv data
%}

if nargin < 2
    options = "sec"; % default
end

cd(logFolder)

listing = dir('*plot*.csv');

% it can be improved by changing in a smarter way the "erase" function
for i = 1: size(listing)
    nameStr  = erase(listing(i).name, [logFolder,"_Boardcore__","_HRETestStand__",".csv"]);
    extraction.(nameStr) = csvDataLogExtractor(listing(i).name,options);
end

%%



