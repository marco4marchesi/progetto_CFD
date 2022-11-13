%{

GRAPHICS OPTION 2 - TWO ORDER OF CONVERGENCE ON ONE PLOT

%}


%% define graphical properties: 

faceColors = ["green","yellow"];
lineColors = ["blue";"red"];

%% PLOT COEFFICIENT W.R.T. ANGLE

COEFFfigures = figure('Name','Drag Coefficient');
COEFFfigs.h_tabgroup = uitabgroup(COEFFfigures);

idx_tab = 0;
for idx_T = 1:length(fieldnames(CD))
    turboNames = convertCharsToStrings(fieldnames(CD));
    CD_TT = CD.(turboNames(idx_T));
    CL_TT = CL.(turboNames(idx_T));
    CMz_TT = CMz.(turboNames(idx_T));

    
    for idx_O = 1:length(fieldnames(CD_TT))

        orderNames = convertCharsToStrings(fieldnames(CD_TT));
        CD_OO = CD_TT.(orderNames(idx_O));
        CL_OO = CL_TT.(orderNames(idx_O));
        CMz_OO = CMz_TT.(orderNames(idx_O));

        % plot parameters
        figureNamer = turboNames(idx_T)+" "+orderNames(idx_O);
    
        % dynamic tab index
        idx_tab = idx_tab + 1;
        tabName = "tab"+num2str(idx_tab);
    
        % CD - dynamic generation of the tabs
        COEFFfigs.(tabName) = uitab(COEFFfigs.h_tabgroup,'Title',figureNamer);
        COEFFfigs.(tabName).BackgroundColor = 'white';
        axes('parent',COEFFfigs.(tabName));


        % CD - plot
        subplot(2,2,[1,3])
        plot(angles(1:length(CD_OO)), CD_OO,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O))
        hold on;
        xlabel("Angle of attack \alpha [°]")
        ylabel("CD")
        legend('1st order','2nd order')

        % CL - plot
        subplot(2,2,2)
        plot(angles(1:length(CL_OO)), CL_OO,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O))
        hold on;
        xlabel("Angle of attack \alpha [°]")
        ylabel("CL")
        legend('1st order','2nd order')
        
        % CMz - plot
        subplot(2,2,4)
        plot(angles(1:length(CMz_OO)), CMz_OO,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O))
        hold on;
        xlabel("Angle of attack \alpha [°]")
        ylabel("CMz")
        legend('1st order','2nd order')

        
    end
    sgtitle(figureNamer,'FontSize',20,'fontweight','bold')
    if savePlots
        exportgraphics(COEFFfigs.(tabName),"IMAGES/CoeffsAnglePlot_"+figureNamer+".pdf")
        exportgraphics(COEFFfigs.(tabName),"IMAGES/CoeffsAnglePlot_"+figureNamer+".png")
        
    end
end



%% POLAR PLOT

POLARfigures = figure('Name','Drag Coefficient');
POLARfigs.h_tabgroup = uitabgroup(POLARfigures);

idx_tab = 0;
for idx_T = 1:length(fieldnames(CD))
    turboNames = convertCharsToStrings(fieldnames(CD));
    CD_TT = CD.(turboNames(idx_T));
    CL_TT = CL.(turboNames(idx_T));
    CMz_TT = CMz.(turboNames(idx_T));

    
    for idx_O = 1:length(fieldnames(CD_TT))

        orderNames = convertCharsToStrings(fieldnames(CD_TT));
        CD_OO = CD_TT.(orderNames(idx_O));
        CL_OO = CL_TT.(orderNames(idx_O));
        CMz_OO = CMz_TT.(orderNames(idx_O));

        % plot parameters
        figureNamer = turboNames(idx_T)+" "+orderNames(idx_O);
    
        % dynamic tab index
        idx_tab = idx_tab + 1;
        tabName = "tab"+num2str(idx_tab);
    
        % CD - dynamic generation of the tabs
        POLARfigs.(tabName) = uitab(POLARfigs.h_tabgroup,'Title',figureNamer);
        POLARfigs.(tabName).BackgroundColor = 'white';
        axes('parent',POLARfigs.(tabName));


        % CD - plot
        plot(CD_OO,CL_OO,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O))
        hold on;
        xlabel("CD")
        ylabel("CL")
        legend('1st order','2nd order')

        
    end
    sgtitle(figureNamer,'FontSize',20,'fontweight','bold')
    if savePlots
        exportgraphics(COEFFfigs.(tabName),"IMAGES/PolarPlot_"+figureNamer+".pdf")
        exportgraphics(COEFFfigs.(tabName),"IMAGES/PolarPlot_"+figureNamer+".png")
    end
end