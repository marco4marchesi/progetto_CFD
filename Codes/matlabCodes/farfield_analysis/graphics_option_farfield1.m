%{

GRAPHICS OPTION 2 - TWO ORDER OF CONVERGENCE ON ONE PLOT

%}

function graphics_option_farfield1(CD,CL,CMz,iterations,cauchy,cauchyType,meshElem,savePlots)
close all;
%% define graphical properties: 

%% select to use meshElements or medium H
xAxisLabel = "mesh Elements";
% xAxisValues = eval(xAxisLabel);


faceColors = ["green";"yellow";"blue"];
lineColors = ["blue";"red";"green"];

%% -------------------------------------------------- plot cycles - DELTA COEFFICIENTS -------------------------------------------- %%

DELTACOEFFfigures = figure('Name','Delta Coefficients','Position',[0,0,800,500]);
DELTACOEFFfigs.h_tabgroup = uitabgroup(DELTACOEFFfigures);

idx_tab = 0;
for idx_T = 1:length(fieldnames(CD))
    turboNames = convertCharsToStrings(fieldnames(CD));
    CD_TT = CD.(turboNames(idx_T));
    CL_TT = CL.(turboNames(idx_T));
    CMz_TT = CMz.(turboNames(idx_T));
    meshElem_TT = meshElem.(turboNames(idx_T));

    for idx_O = 1:length(fieldnames(CD_TT))
        orderNames = convertCharsToStrings(fieldnames(CD_TT));
        CD_OO = CD_TT.(orderNames(idx_O));
        CL_OO = CL_TT.(orderNames(idx_O));
        CMz_OO = CMz_TT.(orderNames(idx_O));
        meshElem_OO = meshElem_TT.(orderNames(idx_O));

        CD_variation = abs(100*(CD_OO(2:end)-CD_OO(1:end-1))./CD_OO(1:end-1));
        CL_variation = abs(100*(CL_OO(2:end)-CL_OO(1:end-1))./CL_OO(1:end-1));
        CMz_variation = abs(100*(CMz_OO(2:end)-CMz_OO(1:end-1))./CMz_OO(1:end-1));
        % dynamic tab name
        figureNamer = turboNames(idx_T)+" "+orderNames(idx_O);

        % dynamic tab index
        idx_tab = idx_tab + 1;
        tabName = "tab"+num2str(idx_tab);

        % CD - dynamic generation of the tabs
        DELTACOEFFfigs.(tabName) = uitab(DELTACOEFFfigs.h_tabgroup,'Title',figureNamer);
        DELTACOEFFfigs.(tabName).BackgroundColor = 'white';
        axes('parent',DELTACOEFFfigs.(tabName));

      
        % CD - plot
        subplot(2,2,[1,3])
        plot(meshElem_OO(2:length(CD_variation)+1), CD_variation,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O),'DisplayName',orderNames(idx_O))
        hold on;
        xlabel(xAxisLabel)
        ylabel("|\Delta CD_%|")
        legend
        if xAxisLabel == "meshIncrement"
            xtickformat("percentage")
        end

        % CL - plot
        subplot(2,2,2)
        plot(meshElem_OO(2:length(CL_variation)+1), CL_variation,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O),'DisplayName',orderNames(idx_O))
        hold on;
        xlabel(xAxisLabel)
        ylabel("|\Delta CL_%|")
        legend
        if xAxisLabel == "meshIncrement"
            xtickformat("percentage")
        end
        
        % CMz - plot
        subplot(2,2,4)
        plot(meshElem_OO(2:length(CMz_variation)+1), CMz_variation,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O),'DisplayName',orderNames(idx_O))
        hold on;
        xlabel("Nelem")
        ylabel("|\Delta CM_z%|")
        legend
        if xAxisLabel == "meshIncrement"
            xtickformat("percentage")
        end
        
        sgtitle(figureNamer,'FontSize',20,'fontweight','bold')
        if savePlots
            exportgraphics(COEFFfigs.(tabName),"IMAGES/coeffsConvergencePlot_"+figureNamer+".pdf")
            exportgraphics(COEFFfigs.(tabName),"IMAGES/coeffsConvergencePlot_"+figureNamer+".png")
            
        end
        
   end
end







%% --------------------------------------------- plot cycles - COEFFICIENTS ---------------------------------------------- %%
COEFFfigures = figure('Name','Coefficients','Position',[0,0,800,500]);
COEFFfigs.h_tabgroup = uitabgroup(COEFFfigures);

idx_tab = 0;
for idx_T = 1:length(fieldnames(CD))
    turboNames = convertCharsToStrings(fieldnames(CD));
    CD_TT = CD.(turboNames(idx_T));
    CL_TT = CL.(turboNames(idx_T));
    CMz_TT = CMz.(turboNames(idx_T));
    meshElem_TT = meshElem.(turboNames(idx_T));
    for idx_O = 1:length(fieldnames(CD_TT))
        orderNames = convertCharsToStrings(fieldnames(CD_TT));
        CD_OO = CD_TT.(orderNames(idx_O));
        CL_OO = CL_TT.(orderNames(idx_O));
        CMz_OO = CMz_TT.(orderNames(idx_O));
        meshElem_OO = meshElem_TT.(orderNames(idx_O));


        % dynamic tab name
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
        plot(meshElem_OO(1:length(CD_OO)), CD_OO,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O),'DisplayName',orderNames(idx_O))
        hold on;
        xlabel(xAxisLabel)
        ylabel("CD")
        legend
        if xAxisLabel == "meshIncrement"
            xtickformat("percentage")
        end
        
        % CL - plot
        subplot(2,2,2)
        plot(meshElem_OO(1:length(CL_OO)), CL_OO,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O),'DisplayName',orderNames(idx_O))
        hold on;
        xlabel(xAxisLabel)
        ylabel("CL")
        legend
        if xAxisLabel == "meshIncrement"
            xtickformat("percentage")
        end
        
        % CMz - plot
        subplot(2,2,4)
        plot(meshElem_OO(1:length(CMz_OO)), CMz_OO,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O),'DisplayName',orderNames(idx_O))
        hold on;
        xlabel(xAxisLabel)
        ylabel("CMz")
        legend
        if xAxisLabel == "meshIncrement"
            xtickformat("percentage")
        end


        sgtitle(figureNamer,'FontSize',20,'fontweight','bold')
        if savePlots
            exportgraphics(COEFFfigs.(tabName),"IMAGES/coeffsConvergencePlot_"+figureNamer+".pdf")
            exportgraphics(COEFFfigs.(tabName),"IMAGES/coeffsConvergencePlot_"+figureNamer+".png")
            
        end
        
   end
end


%% -------------------------------------------------- plot cycles - ITERATIONS -------------------------------------- %%

ITERfigures = figure('Name','Drag Coefficient','Position',[0,0,800,500]);
ITERfigs.h_tabgroup = uitabgroup(ITERfigures);

idx_tab = 0;
for idx_T = 1:length(fieldnames(iterations))
    turboNames = convertCharsToStrings(fieldnames(iterations));
    iter_TT = iterations.(turboNames(idx_T));
    cauchyCD_TT = cauchy.(turboNames(idx_T));
    meshElem_TT = meshElem.(turboNames(idx_T));
    for idx_O = 1:length(fieldnames(iter_TT))
        orderNames = convertCharsToStrings(fieldnames(iter_TT));
        iter_OO = iter_TT.(orderNames(idx_O));
        cauchyCD_OO = cauchyCD_TT.(orderNames(idx_O));
        meshElem_OO = meshElem_TT.(orderNames(idx_O));

        % dynamic tab name
        figureNamer = turboNames(idx_T)+" "+orderNames(idx_O);

        % dynamic tab index
        idx_tab = idx_tab + 1;
        tabName = "tab"+num2str(idx_tab);

        % CD - dynamic generation of the tabs
        ITERfigs.(tabName) = uitab(ITERfigs.h_tabgroup,'Title',figureNamer);
        ITERfigs.(tabName).BackgroundColor = 'white';
        axes('parent',ITERfigs.(tabName));

      
        % ITERATIONS - plot
        subplot(2,1,1)
        plot(meshElem_OO(1:length(iter_OO)), iter_OO,'o','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O),'DisplayName',orderNames(idx_O))
        hold on;
        yline(9998,'r--','DisplayName','maxIter')
        xlabel("Nelem")
        ylabel("Number of iterations")
        legend
        if xAxisLabel == "meshIncrement"
            xtickformat("percentage")
        end       
        
        subplot(2,1,2)
        plot(meshElem_OO(1:length(iter_OO)), cauchyCD_OO,'o','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O),'DisplayName',orderNames(idx_O))
        hold on;
        yline(1e-7,'r--','DisplayName','target')
        xlabel("Nelem")
        ylabel("cauchy"+cauchyType)
        legend
        if xAxisLabel == "meshIncrement"
            xtickformat("percentage")
        end

     
        sgtitle(figureNamer,'FontSize',20,'fontweight','bold')
        if savePlots
            exportgraphics(COEFFfigs.(tabName),"IMAGES/coeffsConvergencePlot_"+figureNamer+".pdf")
            exportgraphics(COEFFfigs.(tabName),"IMAGES/coeffsConvergencePlot_"+figureNamer+".png")
            
        end
        
   end
end