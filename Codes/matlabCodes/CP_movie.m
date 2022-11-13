%{

CP movie: from the plot overlines exported by paraview, for dynamic
simulations.

--------------------------------------------------------------------------
Author: Marco Marchesi
--------------------------------------------------------------------------

This code aims to plot the pressure coefficient distribution around an
aerodynamic profile.

Necessary inputs:
-   a folder containing other folders, one for each time step, each folder containing all the PlotOverLines exported from paraview at
    specific locations and at that specific timestep.

    NOTE: You have to know if the export has been done with a linspace on x
    coordinates or using the coordinates of the points of the profile. This
    is crucial for the code to work! - for CP it is most likely to be the
    linspace,  for Y+ it is most likely to be the coordinates of the
    profile.

---------------------- HOW TO USE THIS CODE: -----------------------------

if it's the first time you use this code follow the following steps before
running the code, otherwise it will return errors:

+   set the "matlabCodesPath" folder equal to the path where you have this
    script. 
    To do so you have to change the line in the INIT section  (lines 20 -
    40) where you see your name. If you don't see your name just copy-paste
    one "if" and set your "matlabCodesPath" variable.

+   set the "simulationsFolderPath" to the folder where you have all you
    simulations saved. The last folder should be "Simulation/". if it's not
    like that try asking for help to the author.


%}

%% select user

% user: set who is running the code so that the folder is chosen:
user = "doppio fisso"; % choices: "doppio fisso" "luca" ...

if user == "doppio fisso"
    matlabCodesPath = "C:\Users\marco\Desktop\UNI\2 MAGISTRALE\CFD\CFD PROJECT\progetto_CFD\Codes\matlabCodes\";
%     simulationsFolderPath = "C:\Users\marco\OneDrive - Politecnico di Milano\MAGISTRALE\TerzoSemestre\CFD\PROGETTO CFD DRIVE\SIMULATIONS DRIVE\Simulations\"; % one drive
    simulationsFolderPath = "C:\Users\marco\Desktop\UNI\2 MAGISTRALE\CFD\CFD PROJECT\progetto_CFD\Simulations\"; % locale
end

if user == "luca"
    matlabCodesPath = "C:/Users/lucag/Desktop/Universita/Magistrale Secondo Anno/Computational_fluid_dynamics/Progetto_CFD/progetto_CFD/Codes/matlabCodes\";
    simulationsFolderPath = "C:/Users/lucag/Desktop/Universita/Magistrale Secondo Anno/Computational_fluid_dynamics/Progetto_CFD/progetto_CFD/Simulations\";
end

%% init
clearvars -except matlabCodesPath simulationsFolderPath; 
close all; clc;

% add matlab functions to the path
addpath(genpath(matlabCodesPath))

% move to simulation folder
cd(simulationsFolderPath)
matlab_graphics;

%% PROFILE EXTRACTION   
NACA_23012_points = readtable(matlabCodesPath+"../pythonCodes/Naca_23012_points.dat");
x_profile = NACA_23012_points.Var1;
y_profile = NACA_23012_points.Var2;

L = max(x_profile);
c_fourth = L/4;
x_profile = x_profile-c_fourth;
coordinates_profile = [x_profile';y_profile'];


%% select case folder (where you saved the .csv files)
% select the case folder: it has to contain only folders named with the
% timestamps

caseFolder = "SC/SA/A9/O1/caseG3/";
addpath(genpath(caseFolder))
cd(caseFolder+"POL_results_CP")


%% external cycle
listingCase

for i = 1:size(listingCase,1)
    if convertCharsToStrings(listingCase(i).name==".")
        continue
    elseif convertCharsToStrings(listingCase(i).name=="..")
        continue
    end
    caseFiles = [caseFiles; convertCharsToStrings(listingCase(i).name)];
end


%% generate rotated vectors
N_saves = length(caseFiles); % number of files saved

% --------------- set these parameters equal to the ones set in the .cfg file ----------- %

N_iter_per_save = 10; %iterations per save (in cfg file: OUTPUT_WRT_FREQ= 10)
dt = 9.231914044466431e-04; % delta time per iteration (in cfg file: TIME_STEP= 9.231914044466431e-04)
omega = 6.28; %[rad/s] (in cfg: PITCHING_OMEGA= 0.0 0.0 6.28) -> set in rad/s
amplitude = deg2rad(10); %[rad] (in cfg: PITCHING_AMPL= 0.0 0.0 10.0)-> set in degrees

% --------------------------------------------------------------------------------------- %

t_vec = dt*N_iter_per_save*linspace(0,N_saves-1,N_saves);
alpha = -amplitude*sin(t_vec*omega);

x_profile_dynamic = zeros(N_saves,length(x_profile));
y_profile_dynamic = zeros(N_saves,length(x_profile));
for i = 1:length(alpha)
R = [cos(alpha(i)) -sin(alpha(i))
    sin(alpha(i)) cos(alpha(i))];
coordinates_rot = R*coordinates_profile;
x_profile_dynamic(i,:) = coordinates_rot(1,:);
y_profile_dynamic(i,:) = coordinates_rot(2,:);
end


for idx_4 = 1:size(caseFiles,1)
    idx_5 = str2double(erase(timesNames(idx_4),"time"))+1; % +1 because pyhton enumerates them from 0

    % move in the folder of the specified timestamp
    cd(caseFiles(idx_4))

    % list folders and extract names
    listingTimes = dir;
    
    timesNames = [];
    timesFiles = [];
    for idx_1 = 1:size(listingTimes,1)
        if convertCharsToStrings(listingTimes(idx_1).name==".")
            continue
        elseif convertCharsToStrings(listingTimes(idx_1).name=="..")
            continue
        end
        timesFiles = [timesFiles; convertCharsToStrings(listingTimes(idx_1).name)];
        timesNames = [timesNames; erase(convertCharsToStrings(listingTimes(idx_1).name),".csv")];
    end
    

    %% EXTRACTION   
    
    for idx_2 = 1:size(timesNames,1)
        idx_3 = str2double(erase(timesNames(idx_2),"sim"))+1; % +1 because pyhton enumerates them from 0
    
        sim = csvDataLogExtractor(timesFiles(idx_2),"raw");
    
        % extract variables 
        CP_vec = sim.Pressure_Coefficient;
    
        % find indeces for the parameters that we need
        idx_up = find(isnan(CP_vec),1,"last")+1;
        idx_bott = find(isnan(CP_vec),1,"first")-1;
    
        if isempty(idx_up) || idx_up > length(CP_vec)
            idx_up = floor(length(CP_vec)/2)+1;
        end
        if isempty(idx_bott) || idx_bott == 0
            idx_bott = floor(length(CP_vec)/2)+1;
        end
    
        % save values for upper quantities
        CP_top(idx_5,idx_3) = CP_vec(idx_up);
             
        % save values for bottom quantities
        CP_bottom(idx_5,idx_3) = CP_vec(idx_bott);
        
    end
    cd("../")
end
%% save as a .mat file so that on github we can run the code without pushing the .csv files
% save("../CP","CP_bottom","CP_upper","x_vec") 


%% PLOTS
close all;
cd(simulationsFolderPath + caseFolder)

% vector containing the position of the plotoverlines (defined the same way
% as python code)

x_vec = linspace(0,1.008,size(timesNames,1));

%----------------------- export figures? --------------------------------%
exportFigures = false;
if exportFigures
    mkdir("IMAGES")
end

%%% PRESSURE COEFFICIENT
    CP_FIGURE = figure('Name','CP for test case');
   

    if exportFigures
        exportgraphics(CP_FIGURE,"IMAGES/CP_distribution.pdf")
        exportgraphics(CP_FIGURE,"IMAGES/CP_distribution.png")
    end

CP_FIGURE = figure;
CP_FIGURE.Visible = 'off';
for j = 1:N_saves
    plot(x_vec,-CP_top,'red')
    hold on; grid minor;
    plot(x_vec,-CP_bottom,'blue')
    plot(x_profile,5*y_profile,'k--','LineWidth',0.8)
    yline(0,'r--')
    xlabel('x [-]')
    ylabel('-CP [-]')
    lgd = legend('Top','Bottom');
    lgd.FontSize = 10;
    title('CP over airfoil')
    xlim([-1.5,1.5]);
    ylim([-1.5,1.5]);
    drawnow
    M(j) = getframe;
end
CP_FIGURE.Visible = 'on';
movie(M);


cd(matlabCodesPath)
