%{

GRAPHICS OPTION 2 - TWO ORDER OF CONVERGENCE ON ONE PLOT

%}


%% define graphical properties: 
% elements of the meshes - plug here the values
meshElem = [136104
            145958
            152048
            166530
            170748
            130284
            175720  
            178480];

% sort vector of mesh elements, just in case we did something fancy for no
% reason -> the same is applied in the extraction
[~,idx_sortElem] = sort(meshElem);
meshElem = meshElem(idx_sortElem);
% deltaH = [  0.173 SONO VALORI A CASACCIO
%             0.139
%             0.112
%             0.096
%             0.082
%             0.069
%             0.058
%             0.046];

%% select to use meshElements or medium H
xAxisValues = meshElem;

faceColors = ["green","yellow"];
lineColors = ["blue";"red"];

%% plot cycles

COEFFfigures = figure('Name','Drag Coefficient','Position',[0,0,1000,1000]);
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

        %%sort vectors in mesh order
        if length(CD_OO)>1
            CD_OO = CD_OO(idx_sortElem);
            CL_OO = CL_OO(idx_sortElem);
            CMz_OO = CMz_OO(idx_sortElem);
        end
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
        plot(xAxisValues(1:length(CD_OO)), CD_OO,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O))
        hold on;
        xlabel("Nelem")
        ylabel("\Delta CD_%")
        legend('1st order','2nd order')

        % CL - plot
        subplot(2,2,2)
        plot(xAxisValues(1:length(CL_OO)), CL_OO,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O))
        hold on;
        xlabel("Nelem")
        ylabel("\Delta CL_%")
        legend('1st order','2nd order')
        
        % CMz - plot
        subplot(2,2,4)
        plot(xAxisValues(1:length(CMz_OO)), CMz_OO,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O))
        hold on;
        xlabel("Nelem")
        ylabel("\Delta CMz_%")
        legend('1st order','2nd order')

     
        sgtitle(figureNamer,'FontSize',20,'fontweight','bold')
        if savePlots
            exportgraphics(COEFFfigs.(tabName),"IMAGES/coeffsConvergencePlot_"+figureNamer+".pdf")
            exportgraphics(COEFFfigs.(tabName),"IMAGES/coeffsConvergencePlot_"+figureNamer+".png")
            
        end
        
   end
end

%% plot cycles

ITERfigures = figure('Name','Drag Coefficient','Position',[0,0,1000,1000]);
ITERfigs.h_tabgroup = uitabgroup(ITERfigures);

idx_tab = 0;
for idx_T = 1:length(fieldnames(iterations))
    turboNames = convertCharsToStrings(fieldnames(iterations));
    iter_TT = iterations.(turboNames(idx_T));
    cauchyCD_TT = cauchyCD.(turboNames(idx_T));

    for idx_O = 1:length(fieldnames(iter_TT))
        orderNames = convertCharsToStrings(fieldnames(iter_TT));
        iter_OO = iter_TT.(orderNames(idx_O));
        cauchyCD_OO = cauchyCD_TT.(orderNames(idx_O));
        %%sort elements as mesh
        if length(iter_OO)>1
            iter_OO = iter_OO(idx_sortElem);
            cauchyCD_OO = cauchyCD_OO(idx_sortElem);
        end
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
        plot(xAxisValues(1:length(iter_OO)), iter_OO,'o','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O),'DisplayName',orderNames(idx_O))
        hold on;
        yline(9998,'r--','DisplayName','maxIter')
        xlabel("Nelem")
        ylabel("Number of iterations")
        legend
        
        subplot(2,1,2)
        plot(xAxisValues(1:length(iter_OO)), cauchyCD_OO,'o','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O),'DisplayName',orderNames(idx_O))
        hold on;
        yline(1e-7,'r--','DisplayName','target')
        xlabel("Nelem")
        ylabel("cauchyCD")
        legend


     
        sgtitle(figureNamer,'FontSize',20,'fontweight','bold')
        if savePlots
            exportgraphics(COEFFfigs.(tabName),"IMAGES/coeffsConvergencePlot_"+figureNamer+".pdf")
            exportgraphics(COEFFfigs.(tabName),"IMAGES/coeffsConvergencePlot_"+figureNamer+".png")
            
        end
        
   end
end