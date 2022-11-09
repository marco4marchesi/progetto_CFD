%{

GRAPHICS OPTION 3 - IN EACH PLOT WE HAVE 4 CURVES, ONE FOR EACH COMBINATION
OF ANGLE OF ATTACK AND TURBULENCE MODEL, ONLY FOR ONE ORDER OF CONVERGENCE.

%}

xAxisValues = meshElem;


%% define graphical properties:

faceColors = ["green";"yellow";"magenta";"cyan";"#7E2F8E";"#D95319"];
lineColors = ["blue";"red";"black";"#A2142F";"#4DBEEE";	"#0072BD"];



%% plot cycle

COEFFfigures = figure('Name','Drag Coefficient');
COEFFfigs.h_tabgroup = uitabgroup(COEFFfigures);

idx_tab = 0;

for idx_O = 1:2


idx_color  = 0;
    % dynamic tab index
    idx_tab = idx_tab + 1;
    tabName = "tab"+num2str(idx_tab);

    orderNames = ["O1","O2"];

    % dynamic tab name
    figureNamer = orderNames(idx_O);

    % CD - dynamic generation of the tabs
    COEFFfigs.(tabName) = uitab(COEFFfigs.h_tabgroup,'Title',figureNamer);
    COEFFfigs.(tabName).BackgroundColor = 'white';

    axes('parent',COEFFfigs.(tabName));
    for idx_T = 1:length(fieldnames(CD))
        turboNames = convertCharsToStrings(fieldnames(CD));
        CD_TT = CD.(turboNames(idx_T));
        CL_TT = CL.(turboNames(idx_T));
        CMz_TT = CMz.(turboNames(idx_T));

        for idx_A = 1:length(fieldnames(CD_TT))
            idx_color = idx_color +1;
            AoANames = convertCharsToStrings(fieldnames(CD_TT));
            CD_AA = CD_TT.(AoANames(idx_A));
            CL_AA = CL_TT.(AoANames(idx_A));
            CMz_AA = CMz_TT.(AoANames(idx_A));

            % order of convergence of the numerical scheme
            CD_OO = CD_AA.(orderNames(idx_O));
            CL_OO = CL_AA.(orderNames(idx_O));
            CMz_OO = CMz_AA.(orderNames(idx_O));

            % comput the increment
            CD_increment = (CD_OO(2:end) - CD_OO(1:end-1))./CD_OO(1:end-1) * 100;
            CL_increment = (CL_OO(2:end) - CL_OO(1:end-1))./CL_OO(1:end-1) * 100;
            CMz_increment = (CMz_OO(2:end) - CMz_OO(1:end-1))./CMz_OO(1:end-1) * 100;

            %%% CD - plot
            subplot(2,2,[1,3])
            plot(xAxisValues(2:length(CD_OO)), CD_increment,'o-','Color',lineColors(idx_color),'MarkerFaceColor',faceColors(idx_color))
            hold on;
            xlabel("Nelem")
            ylabel("\Delta CD_%")
            lgd1 = legend('SA A9','SA A14','SST A9','SST A14');
            lgd1.FontSize = 10;

            %%% CL - plot
            subplot(2,2,2)
            plot(xAxisValues(2:length(CL_OO)), CL_increment,'o-','Color',lineColors(idx_color),'MarkerFaceColor',faceColors(idx_color))
            hold on;
            xlabel("Nelem")
            ylabel("\Delta CL_%")
            lgd2 = legend('SA A9','SA A14','SST A9','SST A14');
            lgd2.FontSize = 10;

            %%% CMz - plot
            subplot(2,2,4)
            plot(xAxisValues(2:length(CMz_OO)), CMz_increment,'o-','Color',lineColors(idx_color),'MarkerFaceColor',faceColors(idx_color))
            hold on;
            xlabel("Nelem")
            ylabel("\Delta CMz_%")
            lgd3 = legend('SA A9','SA A14','SST A9','SST A14');
            lgd3.FontSize = 10;


        end

    end
    sgtitle(figureNamer,'FontSize',18,'fontweight','bold')

    if savePlots
        exportgraphics(COEFFfigs.(tabName),"IMAGES/CDPlot_"+figureNamer+".pdf")
        exportgraphics(COEFFfigs.(tabName),"IMAGES/CDPlot_"+figureNamer+".png")
    end

end

