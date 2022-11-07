%{

GRAPHICS OPTION 3 - IN EACH PLOT WE HAVE 4 CURVES, ONE FOR EACH COMBINATION
OF ANGLE OF ATTACK AND TURBULENCE MODEL, ONLY FOR ONE ORDER OF CONVERGENCE.

%}


%% define graphical properties: 

faceColors = ["green","yellow";"cyan","magenta"];
lineColors = ["blue";"red";"";"black"];

%% CD
CDfigures = figure('Name','Drag Coefficient');
CDfigs.h_tabgroup = uitabgroup(CDfigures);

idx_tab = 0;
for idx_T = 1:length(fieldnames(CD))
    turboNames = convertCharsToStrings(fieldnames(CD));
    CD_TT = CD.(turboNames(idx_T));

    for idx_A = 1:length(fieldnames(CD_TT))
        AoANames = convertCharsToStrings(fieldnames(CD_TT));
        CD_AA = CD_TT.(AoANames(idx_A));

        % dynamic tab name
        figureNamer = turboNames(idx_T)+" "+AoANames(idx_A);

        % dynamic tab index
        idx_tab = idx_tab + 1;
        tabName = "tab"+num2str(idx_tab);

        % CD - dynamic generation of the tabs
        CDfigs.(tabName) = uitab(CDfigs.h_tabgroup,'Title',figureNamer);
        CDfigs.(tabName).BackgroundColor = 'white';
        CDaxes = axes('parent',CDfigs.(tabName));

        for idx_O = 1:length(fieldnames(CD_AA))

            orderNames = convertCharsToStrings(fieldnames(CD_AA));
            CD_OO = CD_AA.(orderNames(idx_O));

            % CD - plot
            plot(CDaxes,meshElem(1:length(CD_OO)), CD_OO,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O))
            hold on;
            xlabel("Nelem")
            ylabel("CD")
            legend('1st order','2nd order')
            title(figureNamer)
        end
   end
end





%% CL
CLfigures = figure('Name','Lift Coefficient');
CLfigs.h_tabgroup = uitabgroup(CLfigures);

idx_tab = 0;
for idx_T = 1:length(fieldnames(CL))
    turboNames = convertCharsToStrings(fieldnames(CL));
    CL_TT = CL.(turboNames(idx_T));

    for idx_A = 1:length(fieldnames(CL_TT))
        AoANames = convertCharsToStrings(fieldnames(CL_TT));
        CL_AA = CL_TT.(AoANames(idx_A));

        % dynamic tab name
        figureNamer = turboNames(idx_T)+" "+AoANames(idx_A);

        % dynamic tab index
        idx_tab = idx_tab + 1;
        tabName = "tab"+num2str(idx_tab);

        % CL - dynamic generation of the tabs
        CLfigs.(tabName) = uitab(CLfigs.h_tabgroup,'Title',figureNamer);
        CLfigs.(tabName).BackgroundColor = 'white';
        CLaxes = axes('parent',CLfigs.(tabName));

        for idx_O = 1:length(fieldnames(CL_AA))

            orderNames = convertCharsToStrings(fieldnames(CL_AA));
            CL_OO = CL_AA.(orderNames(idx_O));

            % CL - plot
            plot(CLaxes,meshElem(1:length(CL_OO)), CL_OO,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O))
            hold on;
            xlabel("Nelem")
            ylabel("CL")
            legend('1st order','2nd order')
            title(figureNamer)
        end

    end
end

%% CMz
CMzfigures = figure('Name','Moment Coefficient');
CMzfigs.h_tabgroup = uitabgroup(CMzfigures);

idx_tab = 0;
for idx_T = 1:length(fieldnames(CMz))
    turboNames = convertCharsToStrings(fieldnames(CMz));
    CMz_TT = CMz.(turboNames(idx_T));

    for idx_A = 1:length(fieldnames(CMz_TT))
        AoANames = convertCharsToStrings(fieldnames(CMz_TT));
        CMz_AA = CMz_TT.(AoANames(idx_A));

        % dynamic tab name
        figureNamer = turboNames(idx_T)+" "+AoANames(idx_A);

        % dynamic tab index
        idx_tab = idx_tab + 1;
        tabName = "tab"+num2str(idx_tab);

        % CMz - dynamic generation of the tabs
        CMzfigs.(tabName) = uitab(CMzfigs.h_tabgroup,'Title',figureNamer);
        CMzfigs.(tabName).BackgroundColor = 'white';
        CMzaxes = axes('parent',CMzfigs.(tabName));

        for idx_O = 1:length(fieldnames(CMz_AA))

            orderNames = convertCharsToStrings(fieldnames(CMz_AA));
            CMz_OO = CMz_AA.(orderNames(idx_O));

            % CMz - plot
            plot(CMzaxes,meshElem(1:length(CMz_OO)), CMz_OO,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O))
            hold on;
            xlabel("Nelem")
            ylabel("CMz")
            legend('1st order','2nd order')
            title(figureNamer)
        end


    end
end
