%{
compute the rotated coordinates in time: this has to be translated in
python then...
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

%% import profile coordinates:
% profile coordinates
NACA_23012_points = readtable(matlabCodesPath+"../pythonCodes/Naca_23012_points.dat");
x_profile = NACA_23012_points.Var1;
y_profile = NACA_23012_points.Var2;
y_POL1 = y_profile-1e-2;
y_POL2 = y_profile+1e-2;
% linspace coordinates

L = max(x_profile);
c_fourth = L/4;
x_vec = linspace(0,L,101);
y_vec = zeros(1,101);



% %% generate rotated vectors - FOR CP
% N_saves = 63; % number of files saved
% N_iter_per_save = 10; %iterations per save (in cfg file: OUTPUT_WRT_FREQ= 10)
% dt = 9.231914044466431e-04; % delta time per iteration (in cfg file: TIME_STEP= 9.231914044466431e-04)
% omega = 6.28; %[rad/s] (in cfg: PITCHING_OMEGA= 0.0 0.0 6.28)
% 
% amplitude = deg2rad(10); %[°] (in cfg: PITCHING_AMPL= 0.0 0.0 10.0)
% t_vec = dt*N_iter_per_save*linspace(0,N_saves-1,N_saves);
% alpha = -amplitude*sin(t_vec*omega);
% 
% x_vec = x_vec-c_fourth;
% coordinates_vec = [x_vec;y_vec];
% 
% x_vec_dynamic = zeros(N_saves,length(x_vec));
% y_vec_dynamic = zeros(N_saves,length(x_vec));
% 
% for i = 1:length(alpha)
% R = [cos(alpha(i)) -sin(alpha(i))
%      sin(alpha(i))  cos(alpha(i))];
% coordinates_vec_rot = R*coordinates_vec;
% x_vec_dynamic(i,:) = coordinates_vec_rot(1,:);
% y_vec_dynamic(i,:) = coordinates_vec_rot(2,:);
% end
% x_vec_dynamic= x_vec_dynamic + c_fourth; % replace it to center
% h1 = figure('Name','Test movie vector','Position',[100,100,1500,1000]);
% h1.Visible = 'off';
% for j = 1:N_saves
%     plot(x_vec_dynamic(j,:),y_vec_dynamic(j,:))
%     hold on;
%     plot(c_fourth,0,'d','MarkerFaceColor','yellow')
%     xlim([-1.5,1.5]);
%     ylim([-1.5,1.5]);
%     hold off
%     
%     drawnow
%     M(j) = getframe;
% end
% h1.Visible = 'on';
% movie(M);


%% generate rotated vectors - FOR Y+
N_saves = 63; % number of files saved
N_iter_per_save = 10; %iterations per save (in cfg file: OUTPUT_WRT_FREQ= 10)
dt = 9.231914044466431e-04; % delta time per iteration (in cfg file: TIME_STEP= 9.231914044466431e-04)
omega = 6.28; %[rad/s] (in cfg: PITCHING_OMEGA= 0.0 0.0 6.28)

amplitude = deg2rad(10); %[°] (in cfg: PITCHING_AMPL= 0.0 0.0 10.0)
t_vec = dt*N_iter_per_save*linspace(0,N_saves-1,N_saves);
alpha = -amplitude*sin(t_vec*omega);

x_profile = x_profile-c_fourth;
coordinates_profile = [x_profile';y_profile'];
coordinates_POL1 = [x_profile'; y_POL1'];
coordinates_POL2 = [x_profile'; y_POL2'];

x_profile_dynamic = zeros(N_saves,length(x_profile));
y_profile_dynamic = zeros(N_saves,length(x_profile));

x_POL1_dynamic = zeros(N_saves,length(x_profile));
y_POL1_dynamic = zeros(N_saves,length(x_profile));

x_POL2_dynamic = zeros(N_saves,length(x_profile));
y_POL2_dynamic = zeros(N_saves,length(x_profile));

for i = 1:length(alpha)
% rotation matrix
R = [cos(alpha(i)) -sin(alpha(i))
    sin(alpha(i)) cos(alpha(i))];
coordinates_rot = R*coordinates_profile;
coordinates_POL1_rot = R*coordinates_POL1;
coordinates_POL2_rot = R*coordinates_POL2;

% save coordinates
x_profile_dynamic(i,:) = coordinates_rot(1,:);
y_profile_dynamic(i,:) = coordinates_rot(2,:);

x_POL1_dynamic(i,:) = coordinates_POL1_rot(1,:); 
y_POL1_dynamic(i,:) = coordinates_POL1_rot(2,:);

x_POL2_dynamic(i,:) = coordinates_POL2_rot(1,:); 
y_POL2_dynamic(i,:) = coordinates_POL2_rot(2,:);
end

x_profile_dynamic = x_profile_dynamic + c_fourth;
x_POL1_dynamic = x_POL1_dynamic + c_fourth;
x_POL2_dynamic = x_POL2_dynamic + c_fourth;

h2 = figure('Name','Test movie vector','Position',[100,100,1500,1000]);
h2.Visible = 'off';
for j = 1:N_saves
    plot(x_profile_dynamic(j,:),y_profile_dynamic(j,:))
    hold on;
    plot(x_POL1_dynamic(j,:),y_POL1_dynamic(j,:),'r--')
    plot(x_POL2_dynamic(j,:),y_POL2_dynamic(j,:),'g--')
    plot(c_fourth,0,'d','MarkerFaceColor','yellow')
    xlim([-1.5,1.5]);
    ylim([-1.5,1.5]);
    hold off
    drawnow
    M(j) = getframe;
end
h2.Visible = 'on';
movie(M);


%% export video
% video = VideoWriter("videotest","MPEG-4")
% open(video)
% writeVideo(video,M)
% close(video)


%% export data points for each timestamp
% mkdir("DynamicCoordinates")
% for i = 
% cazzo = csvwrite("DynamicCoorinates/t_"+num2str(i))
% fid(open)



