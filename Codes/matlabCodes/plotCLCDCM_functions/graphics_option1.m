%{

GRAPHICAL OPTION 1 - TABS

%}

% CD
CDfigures = figure('Name','Drag Coefficient');
CDfigs.h_tabgroup = uitabgroup(CDfigures);

% CL
CLfigures = figure('Name','Lift Coefficient');
CLfigs.h_tabgroup = uitabgroup(CLfigures);

% CMz
CMfigures = figure('Name','Moment Coefficient');
CMfigs.h_tabgroup = uitabgroup(CMfigures);

idx_tab = 0;
for idx_T = 1:length(fieldnames(CD))
    turboNames = convertCharsToStrings(fieldnames(CD));
    CD_TT = CD.(turboNames(idx_T));
    CL_TT = CL.(turboNames(idx_T));
    CM_TT = CMz.(turboNames(idx_T));

    for idx_A = 1:length(fieldnames(CD_TT))
        AoANames = convertCharsToStrings(fieldnames(CD_TT));
        CD_AA = CD_TT.(AoANames(idx_A));
        CL_AA = CL_TT.(AoANames(idx_A));
        CM_AA = CM_TT.(AoANames(idx_A));

        for idx_O = 1:length(fieldnames(CD_AA))
            orderNames = convertCharsToStrings(fieldnames(CD_AA));
            CD_OO = CD_AA.(orderNames(idx_O));
            CL_OO = CL_AA.(orderNames(idx_O));
            CM_OO = CM_AA.(orderNames(idx_O));

            % dynamic tab name
            figureNamer = turboNames(idx_T)+"_"+AoANames(idx_A)+"_"+orderNames(idx_O);
            
            % dynamic tab index
            idx_tab = idx_tab + 1;
            tabName = "tab"+num2str(idx_tab);
            
            % CD - dynamic generation of the tabs
            CDfigs.(tabName) = uitab(CDfigs.h_tabgroup,'Title',figureNamer);
            CDfigs.(tabName).BackgroundColor = 'white';
            CDaxes = axes('parent',CDfigs.(tabName)); 
            
            % CD - plot
            plot(CDaxes,meshElem(1:length(CD_OO)), CD_OO,'ro-','MarkerFaceColor','green')
            xlabel("Nelem")
            ylabel("CD")

            % CL - dynamic generation of the tabs
            CLfigs.(tabName) = uitab(CLfigs.h_tabgroup,'Title',figureNamer);
            CLfigs.(tabName).BackgroundColor = 'white';
            CLaxes = axes('parent',CLfigs.(tabName)); 
            
            % CL - plot
            plot(CLaxes,meshElem(1:length(CL_OO)), CL_OO,'ro-','MarkerFaceColor','green')
            xlabel("Nelem")
            ylabel("CL")

            % CM - dynamic generation of the tabs
            CMfigs.(tabName) = uitab(CMfigs.h_tabgroup,'Title',figureNamer);
            CMfigs.(tabName).BackgroundColor = 'white';
            CMaxes = axes('parent',CMfigs.(tabName)); 
            
            % CM - plot
            plot(CMaxes,meshElem(1:length(CM_OO)), CM_OO,'ro-','MarkerFaceColor','green')
            xlabel("Nelem")
            ylabel("CMz")

        end
    end
end