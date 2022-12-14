%{

this code contains graphical examples interesting for the project    

for more reference visit the matlab help center at links:

plot gallery - you can find here many many possibilities
https://it.mathworks.com/products/matlab/plot-gallery.html#

plot3:
https://it.mathworks.com/help/matlab/ref/plot3.html



useful tip: to customize the properties you can always use the get(PLOTNAME) 
command and infer for properties


MOVIES:
A tutorial:
https://www.youtube.com/watch?v=mvXJh_TDKG8

matlab "Movie" on site:
https://it.mathworks.com/help/matlab/ref/movie.html

%}

%% example 1: points with surface connected by lines:

t = 0:pi/20:10*pi;
xt = sin(t);
yt = cos(t);
figure
plot3(xt,yt,t,'-o','Color','b','MarkerSize',10,...
    'MarkerFaceColor','#D9FFFF')

% another way to change parameters:
figure
p = plot3(xt,yt,t,'-o','Color','b','MarkerSize',10,...
    'MarkerFaceColor','#D9FFFF')
p.LineStyle = ":";
p.Color = "red";
p.Marker = "o";


%% example 2: to point out one particular point of the plot
t = 0:pi/500:pi;
xt(1,:) = sin(t).*cos(10*t);
yt(1,:) = sin(t).*sin(10*t);
zt = cos(t);
figure
plot3(xt,yt,zt,'-o','MarkerIndices',200)

%% example 3: stems:
x1 = linspace(0,2*pi,50)';
x2 = linspace(pi,3*pi,50)';
X = [x1, x2];
Y = [cos(x1), 0.5*sin(x2)];
figure
stem(X,Y)

% there exists also stem3:
X = linspace(-5,5,60);
Y = cos(X);
Z = X.^2;
figure
stem3(X,Y,Z)

% you can even stem meshgrids:
figure
[X,Y] = meshgrid(0:.1:1);
Z = exp(X+Y);
stem3(X,Y,Z)

% and custom it as you wish:
theta = linspace(0,2*pi);
X = cos(theta);
Y = sin(theta);
Z = theta;
figure
st = stem3(X,Y,Z,...
    "Marker",MarkerType,...         % Specify the point symbol
    "LineWidth",LineWidth,...       % Specify stem line width
    "LineStyle",LineType,...        % Specify stem line appearance
    "Color",Color);  
title("Stem Plot of 3-D Data")
xlabel('x')
ylabel('y')
zlabel('z')

% useful tip: to customize the properties you can always use the get(PLOTNAME) command and infer for properties

%% example 4: 
figure
t = tiledlayout(1,2,'TileSpacing','compact');
bgAx = axes(t,'XTick',[],'YTick',[],'Box','off');
bgAx.Layout.TileSpan = [1 1];

ax1 = axes(t);
plot(ax1,[1:5],[2:6])
xline(ax1,15,':');
ax1.Box = 'off';
xlim(ax1,[0 15])
xlabel(ax1, 'First Interval')

% Create second plot
ax2 = axes(t);
ax2.Layout.Tile = 2;
plot(ax2,[1:5],[2:6])
xline(ax2,45,':');
ax2.YAxis.Visible = 'off';
ax2.Box = 'off';
xlim(ax2,[45 60])
xlabel(ax2,'Second Interval')

% Link the axes
linkaxes([ax1 ax2], 'y')

%% example 5 - movies

h = figure;
Z = peaks;
surf(Z)
axis tight manual
ax = gca;
ax.NextPlot = 'replaceChildren';
loops = 40;
M(loops) = struct('cdata',[],'colormap',[]);
h.Visible = 'off';
for j = 1:loops
    X = sin(j*pi/10)*Z;
    surf(X,Z)
    drawnow
    M(j) = getframe;
end
h.Visible = 'on';
movie(M);

%% example 6
h = figure;
Z = peaks;
surf(Z)
axis tight manual
ax = gca;
ax.NextPlot = 'replaceChildren';
for j = 1:loops
    X = sin(j*pi/10)*Z;
    surf(X,Z)
    drawnow
    M(j) = getframe;
end
movie(M);

%% example 7
h = figure;
Z = peaks;
surf(Z)
axis tight manual
ax = gca;
ax.NextPlot = 'replaceChildren';
loops = 40;
M(loops) = struct('cdata',[],'colormap',[]);
h.Visible = 'off';
for j = 1:loops
    X = sin(j*pi/10)*Z;
    surf(X,Z)
    drawnow
    M(j) = getframe;
end
h.Visible = 'on';
movie(M,[2 1 15 23 36],12);


%% example 8
h = figure;
Z = peaks;
surf(Z)
axis tight manual
ax = gca;
ax.NextPlot = 'replaceChildren';
loops = 40;
M(loops) = struct('cdata',[],'colormap',[]);
h.Visible = 'off';
for j = 1:loops
    X = sin(j*pi/10)*Z;
    surf(X,Z)
    drawnow
    M(j) = getframe;
end
h.Visible = 'on';
movie(M,1,6);

%% example 9
h = figure;
Z = peaks;
surf(Z)
axis tight manual
ax = gca;
ax.NextPlot = 'replaceChildren';
loops = 40;
M(loops) = struct('cdata',[],'colormap',[]);
h.Visible = 'off';
for j = 1:loops
    X = sin(j*pi/10)*Z;
    surf(X,Z)
    drawnow
    M(j) = getframe(h);
end
h.Visible = 'on';
movie(h,M,1,12,[30 30 0 0]);