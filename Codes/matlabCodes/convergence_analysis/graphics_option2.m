%{

GRAPHICS OPTION 2 - TWO ORDER OF CONVERGENCE ON ONE PLOT

%}


%% define graphical properties: 

faceColors = ["green","yellow"];
lineColors = ["blue";"red"];

%% plot deltas

COEFFfigures = figure('Name','Drag Coefficient','Position',[0,0,1000,1000]);
COEFFfigs.h_tabgroup = uitabgroup(COEFFfigures);

idx_tab = 0;
for idx_T = 1:length(fieldnames(CD))
    turboNames = convertCharsToStrings(fieldnames(CD));
    CD_TT = CD.(turboNames(idx_T));
    CL_TT = CL.(turboNames(idx_T));
    CMz_TT = CMz.(turboNames(idx_T));
    meshElem_TT = meshElem.(turboNames(idx_T));
    for idx_A = 1:length(fieldnames(CD_TT))
        AoANames = convertCharsToStrings(fieldnames(CD_TT));
        CD_AA = CD_TT.(AoANames(idx_A));
        CL_AA = CL_TT.(AoANames(idx_A));
        CMz_AA = CMz_TT.(AoANames(idx_A));
        meshElem_AA = meshElem_TT.(AoANames(idx_A));

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
            meshElem_OO = meshElem_AA.(orderNames(idx_O));

            CD_increment = (CD_OO(2:end) - CD_OO(1:end-1))./CD_OO(1:end-1) * 100;
            CL_increment = (CL_OO(2:end) - CL_OO(1:end-1))./CL_OO(1:end-1) * 100;
            CMz_increment = (CMz_OO(2:end) - CMz_OO(1:end-1))./CMz_OO(1:end-1) * 100;
            mesh_increment = (meshElem_OO(2:end) - meshElem_OO(1:end-1))./meshElem_OO(1:end-1) * 100;

            % CD - plot
            subplot(2,2,[1,3])
            plot(meshElem_OO(2:end), CD_increment,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O),'DisplayName',orderNames(idx_O))
            hold on;
            xlabel("Nelem")
            ylabel("|\Delta CD_%|")
            legend

            % CL - plot
            subplot(2,2,2)
            plot(meshElem_OO(2:end), CL_increment,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O),'DisplayName',orderNames(idx_O))
            hold on;
            xlabel("Nelem")
            ylabel("|\Delta CL_%|")
            legend

            % CMz - plot
            subplot(2,2,4)
            plot(meshElem_OO(2:end), CMz_increment,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O),'DisplayName',orderNames(idx_O))
            hold on;
            xlabel("Nelem")
            ylabel("|\Delta CMz_%|")
            legend
        end
        sgtitle(figureNamer,'FontSize',20,'fontweight','bold')
        if savePlots
            exportgraphics(COEFFfigs.(tabName),"IMAGES/coeffsConvergencePlot_"+figureNamer+".pdf")
            exportgraphics(COEFFfigs.(tabName),"IMAGES/coeffsConvergencePlot_"+figureNamer+".png")
            
        end
        
   end
end

%% plot values

COEFFfigures = figure('Name','Drag Coefficient','Position',[0,0,1000,1000]);
COEFFfigs.h_tabgroup = uitabgroup(COEFFfigures);

idx_tab = 0;
for idx_T = 1:length(fieldnames(CD))
    turboNames = convertCharsToStrings(fieldnames(CD));
    CD_TT = CD.(turboNames(idx_T));
    CL_TT = CL.(turboNames(idx_T));
    CMz_TT = CMz.(turboNames(idx_T));
    meshElem_TT = meshElem.(turboNames(idx_T));
    for idx_A = 1:length(fieldnames(CD_TT))
        AoANames = convertCharsToStrings(fieldnames(CD_TT));
        CD_AA = CD_TT.(AoANames(idx_A));
        CL_AA = CL_TT.(AoANames(idx_A));
        CMz_AA = CMz_TT.(AoANames(idx_A));
        meshElem_AA = meshElem_TT.(AoANames(idx_A));

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
            meshElem_OO = meshElem_AA.(orderNames(idx_O));


            % CD - plot
            subplot(2,2,[1,3])
            plot(meshElem_OO, CD_OO,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O),'DisplayName',orderNames(idx_O))
            hold on;
            xlabel("Nelem")
            ylabel("CD")
            legend

            % CL - plot
            subplot(2,2,2)
            plot(meshElem_OO, CL_OO,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O),'DisplayName',orderNames(idx_O))
            hold on;
            xlabel("Nelem")
            ylabel("CL")
            legend
            
            % CMz - plot
            subplot(2,2,4)
            plot(meshElem_OO, CMz_OO,'o-','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O),'DisplayName',orderNames(idx_O))
            hold on;
            xlabel("Nelem")
            ylabel("CMz")
            legend
        end
        sgtitle(figureNamer,'FontSize',20,'fontweight','bold')
        if savePlots
            exportgraphics(COEFFfigs.(tabName),"IMAGES/coeffsConvergencePlot_"+figureNamer+".pdf")
            exportgraphics(COEFFfigs.(tabName),"IMAGES/coeffsConvergencePlot_"+figureNamer+".png")
            
        end
        
   end
end


%% plot convergence parameters

CONVfigures = figure('Name','Drag Coefficient','Position',[0,0,1000,1000]);
CONVfigs.h_tabgroup = uitabgroup(CONVfigures);

idx_tab = 0;
for idx_T = 1:length(fieldnames(CD))

    turboNames = convertCharsToStrings(fieldnames(CD));
    rms_TT = rms.(turboNames(idx_T));
    cauchy_TT = cauchyCD.(turboNames(idx_T));
    meshElem_TT = meshElem.(turboNames(idx_T));

    for idx_A = 1:length(fieldnames(CD_TT))

        AoANames = convertCharsToStrings(fieldnames(CD_TT));
        rms_AA = rms_TT.(AoANames(idx_A));
        cauchy_AA = cauchy_TT.(AoANames(idx_A));
        meshElem_AA = meshElem_TT.(AoANames(idx_A));

        % dynamic tab name
        figureNamer = turboNames(idx_T)+" "+AoANames(idx_A);

        % dynamic tab index
        idx_tab = idx_tab + 1;
        tabName = "tab"+num2str(idx_tab);

        % CD - dynamic generation of the tabs
        CONVfigs.(tabName) = uitab(CONVfigs.h_tabgroup,'Title',figureNamer);
        CONVfigs.(tabName).BackgroundColor = 'white';
        axes('parent',CONVfigs.(tabName));

        for idx_O = 1:length(fieldnames(CD_AA))

            orderNames = convertCharsToStrings(fieldnames(CD_AA));
            rms_OO = rms_AA.(orderNames(idx_O));
            cauchy_OO = cauchy_AA.(orderNames(idx_O));
            meshElem_OO = meshElem_AA.(orderNames(idx_T));

            % CD - plot
            subplot(1,2,1)
            stem(meshElem_OO, rms_OO,'o','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O),'DisplayName',orderNames(idx_O))
            hold on;
            xlabel("Nelem")
            ylabel("rms")
            legend

            % CL - plot
            subplot(1,2,2)
            stem(meshElem_OO, log10(cauchy_OO),'o','Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O),'DisplayName',orderNames(idx_O))
            hold on;
            xlabel("Nelem")
            ylabel("cauhcy CD")
            legend
            
        end
        sgtitle(figureNamer,'FontSize',20,'fontweight','bold')
        if savePlots
            exportgraphics(CONVfigs.(tabName),"IMAGES/coeffsConvergencePlot_"+figureNamer+".pdf")
            exportgraphics(CONVfigs.(tabName),"IMAGES/coeffsConvergencePlot_"+figureNamer+".png")
            
        end
        
   end
end