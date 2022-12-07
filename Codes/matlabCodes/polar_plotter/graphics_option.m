%{

GRAPHICS OPTION 2 - TWO ORDER OF CONVERGENCE ON ONE PLOT

%}


%% define graphical properties: 

faceColors = ["green";"yellow";"cyan";"white";"green"];
lineColors = ["blue";"red";"magenta";"black";"yellow"];
markerForm  = ["d-";"o-";"s-";"p-";"^-"];
%% PLOT COEFFICIENT W.R.T. ANGLE

COEFFfigures = figure('Name','Drag Coefficient','Position',[0 0 1000 1000]);

COEFFfigs.h_tabgroup = uitabgroup(COEFFfigures);

idx_tab = 0;
for idx_T = 1:length(fieldnames(CD))
    turboNames = convertCharsToStrings(fieldnames(CD));
    CD_TT = CD.(turboNames(idx_T));
    CL_TT = CL.(turboNames(idx_T));
    CMz_TT = CMz.(turboNames(idx_T));
    angles_TT = angles.(turboNames(idx_T));

    % plot parameters
    figureNamer = turboNames(idx_T);
    
    % dynamic tab index
    idx_tab = idx_tab + 1;
    tabName = "tab"+num2str(idx_tab);

    % CD - dynamic generation of the tabs
    COEFFfigs.(tabName) = uitab(COEFFfigs.h_tabgroup,'Title',figureNamer);
    COEFFfigs.(tabName).BackgroundColor = 'white';
    axes('parent',COEFFfigs.(tabName));

    for idx_O = 1:length(fieldnames(CD_TT))

        orderNames = convertCharsToStrings(fieldnames(CD_TT));
        CD_OO = CD_TT.(orderNames(idx_O));
        CL_OO = CL_TT.(orderNames(idx_O));
        CMz_OO = CMz_TT.(orderNames(idx_O));
        angles_OO = angles_TT.(orderNames(idx_O));
        
        % CD - plot
        subplot(2,2,[1,3])
        plot(angles_OO, CD_OO,markerForm(idx_O),'Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O))
        hold on;
        xlabel("Angle of attack \alpha [°]")
        ylabel("CD")
        legend(orderNames)
        
        % CL - plot
        subplot(2,2,2)
        plot(angles_OO, CL_OO,markerForm(idx_O),'Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O))
        hold on;
        xlabel("Angle of attack \alpha [°]")
        ylabel("CL")
        legend(orderNames)
        
        % CMz - plot
        subplot(2,2,4)
        plot(angles_OO, CMz_OO,markerForm(idx_O),'Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O))
        hold on;
        xlabel("Angle of attack \alpha [°]")
        ylabel("CMz")
        legend(orderNames)

        
    end
    sgtitle(figureNamer,'FontSize',20,'fontweight','bold')
    if savePlots
        exportgraphics(COEFFfigs.(tabName),"IMAGES/CoeffsAnglePlot_"+figureNamer+".pdf")
        exportgraphics(COEFFfigs.(tabName),"IMAGES/CoeffsAnglePlot_"+figureNamer+".png")
        
    end
end



%% POLAR PLOT

POLARfigures = figure('Name','Drag Coefficient','Position',[0,0,1000,1000]);
POLARfigs.h_tabgroup = uitabgroup(POLARfigures);

idx_tab = 0;
for idx_T = 1:length(fieldnames(CD))
    turboNames = convertCharsToStrings(fieldnames(CD));
    CD_TT = CD.(turboNames(idx_T));
    CL_TT = CL.(turboNames(idx_T));
    CMz_TT = CMz.(turboNames(idx_T));

    % plot parameters
    figureNamer = turboNames(idx_T);

    % dynamic tab index
    idx_tab = idx_tab + 1;
    tabName = "tab"+num2str(idx_tab);

    % CD - dynamic generation of the tabs
    POLARfigs.(tabName) = uitab(POLARfigs.h_tabgroup,'Title',figureNamer);
    POLARfigs.(tabName).BackgroundColor = 'white';
    axes('parent',POLARfigs.(tabName));
    for idx_O = 1:length(fieldnames(CD_TT))

        orderNames = convertCharsToStrings(fieldnames(CD_TT));
        CD_OO = CD_TT.(orderNames(idx_O));
        CL_OO = CL_TT.(orderNames(idx_O));
        CMz_OO = CMz_TT.(orderNames(idx_O));

        % CD - plot
        plot(CD_OO,CL_OO,markerForm(idx_O),'Color',lineColors(idx_O),'MarkerFaceColor',faceColors(idx_O))
        hold on;
        xlabel("CD")
        ylabel("CL")
        legend(orderNames)

        
    end
    sgtitle(figureNamer,'FontSize',20,'fontweight','bold')
    if savePlots
        exportgraphics(COEFFfigs.(tabName),"IMAGES/PolarPlot_"+figureNamer+".pdf")
        exportgraphics(COEFFfigs.(tabName),"IMAGES/PolarPlot_"+figureNamer+".png")
    end
end


%% comparison between experimental data and our simulations

% ZANOTTI ET AL 2021
alpha_zano = [  -5.290116797
                -2.222117986
                0.505339525
                3.831636881
                6.562221493
                9.121128258
                11.72084369
                12.74199853
                14.10275654
                14.61091046
                15.01962256
                18.22255578];

CL_zano = [ -0.313204184
            -0.07034101
            0.150457339
            0.4508279
            0.715905999
            0.950025799
            1.161996341
            1.221548853
            1.289882265
            1.285341714
            1.072705099
            0.826239505];

% NASA TECH REPORT
alpha_NASA = [  -6.292483255
                -3.210617713
                -1.670057058
                1.325477549
                2.780079385
                5.774497643
                8.856735301
                11.85413049
                13.65740511
                15.03572315
                15.65157529
                16.17142148
                20.58992806];

CL_NASA = [ -0.517241379
            -0.215517241
            -0.060344828
            0.24137931
            0.392241379
            0.706896552
            1.004310345
            1.284482759
            1.396551724
            1.431034483
            1.297413793
            1.275862069
            1.094827586];

% ABBOT BOOK EXTRAPOLATION
alpha_abbot = [ 0
                2
                4
                6
                8
                10
                12
                14];

CL_abbot = [0.125224075
            0.316567685
            0.507911296
            0.699254907
            0.890598518
            1.081942129
            1.27328574
            1.464629351];

CD_abbot = [0.009863507
            0.010270891
            0.010678275
            0.011085659
            0.011493043
            0.011900427
            0.012307811
            0.012715195];

figure('Name','Comparison experimental data vs simulations','Position',[0,0,1000,1000])
hold on; grid on;
plot(angles.SA.O2_stretto ,CL.SA.O2_stretto,    'd-' ,'Color','#C100FF'    ,'MarkerFace','#C100FF'    ,'MarkerEdge','k'      ,'DisplayName','Simulated SA');
plot(angles.SST.O2_stretto,CL.SST.O2_stretto,   'o-' ,'Color','#FFA500'    ,'MarkerFace','#FFA500'    ,'MarkerEdge','k'      ,'DisplayName','Simulated SST')
% plot(alpha_CFD_zano)
plot(alpha_zano,CL_zano,                        's--','Color','m'          ,'MarkerFace','m'          ,'MarkerEdge','k'      ,'DisplayName','Zanotti et al')
plot(alpha_NASA,CL_NASA,                        'd--','Color','g'          ,'MarkerFace','g'          ,'MarkerEdge','k'      ,'DisplayName','NASA')

% plot(alpha_abbot,CL_abbot,           '^--','Color','#7E2F8E','MarkerFaceColor','white','displayName','Abbot')
legend
title('Experimental data vs simulations')
xlabel('Angle of attack \alpha [°]')
ylabel('CL')