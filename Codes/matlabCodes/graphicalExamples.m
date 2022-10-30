%{

this code contains graphical examples interesting for the project    

for more reference visit the matlab help center at links:

plot gallery - you can find here many many possibilities
https://it.mathworks.com/products/matlab/plot-gallery.html#

plot3:
https://it.mathworks.com/help/matlab/ref/plot3.html



useful tip: to customize the properties you can always use the get(PLOTNAME) 
command and infer for properties
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