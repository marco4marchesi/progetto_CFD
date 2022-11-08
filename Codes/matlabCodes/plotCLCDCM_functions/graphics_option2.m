%{

GRAPHICS OPTION 2 - TWO ORDER OF CONVERGENCE ON ONE PLOT

%}


%% define graphical properties: 

xAxisValues = meshElem;

faceColors = ["green","yellow"];
lineColors = ["blue";"red"];

%% plot cycles

COEFFfigures = figure('Name','Drag Coefficient');
COEFFfigs.h_tabgroup = uitabgroup(COEFFfigures);

idx_tab = 0;
for idx_T = 1:length(fieldnames(CD))
    turboNames = convertCharsToStrings(fieldnames(CD));
    CD_TT = CD.(turboNames(idx_T));
    CL_TT = CL.(turboNames(idx_T));
    CMz_TT = CMz.(turboNames(idx_T));

    for idx_A = 1:length(fieldnames(CD_TT))
        AoANames = convertCharsToStrings(fieldnames(CD_TT));
        CD_AA = CD_TT.(AoANames(idx_A));
        CL_AA = CL_TT.(AoANames(idx_A));
        CMz_AA = CMz_TT.(AoANames(idx_A));

        % dynamic tab name
        figureNamer = turboNames(idx_T)+" "+AoANames(idx_A);

        % dynamic tab index
        idx_tab = idx_tab + 1;
        tabName = "tab"+num2str(idx_tab);

        % CD - dynamic generation of the tabs
        COEFFfigs.(tabName) = uitab(COEFFfigs.h_tabgroup,'Title',figureNamer);
        COEFFfigs.(tabName).BackgroundColor = 'white';
        axes('parent',COEFFfigs.(tabName));

        for idx_O = 1:length(fieldnames(CD_AA))

            orderNames = convertCharsToStrings(fieldnames(CD_AA));
            CD_OO = CD_AA.(orderNames(idx_O));
            CL_OO = CL_AA.(orderNames(idx_O));
            CMz_OO = CMz_AA.(orderNames(idx_O));
         
            CD_increment = (CD_OO(2:end) - CD_OO(1:end-1))./CD_OO(1:end-1) * 100;
            CL_increment = (CL_OO(2:end) - CL_OO(1:end-1))./CL_OO(1:end-1) * 100;
            CMz_increment = (CMz_OO(2:end) - CMz_OO(1:end-1))./CMz_OO(1:end-1) * 100;
           
            % CD - plot
            subplot(2,2,[1,3])
            plot(xAxisValues(2:length(CD_OO)), CD_increment,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O))
            hold on;
            xlabel("Nelem")
            ylabel("CD_%")
            legend('1st order','2nd order')

            % CL - plot
            subplot(2,2,2)
            plot(xAxisValues(2:length(CL_OO)), CL_increment,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O))
            hold on;
            xlabel("Nelem")
            ylabel("CL_%")
            legend('1st order','2nd order')
            
            % CMz - plot
            subplot(2,2,4)
            plot(xAxisValues(2:length(CMz_OO)), CMz_increment,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O))
            hold on;
            xlabel("Nelem")
            ylabel("CMz_%")
            legend('1st order','2nd order')
        end
        sgtitle(figureNamer,'FontSize',20,'fontweight','bold')
        if savePlots
            exportgraphics(COEFFfigs.(tabName),"IMAGES/CDPlot_"+figureNamer+".pdf")
            exportgraphics(COEFFfigs.(tabName),"IMAGES/CDPlot_"+figureNamer+".png")
            
        end
        
   end
end