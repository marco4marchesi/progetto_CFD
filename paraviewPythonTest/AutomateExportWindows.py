#{
# use this script to automate export of plotOverLines.
#
# Basically in this script you have to set 3 things: 
# - the first is the source (FindSource) 
# - the second is the x,y,z arrays of point1 and point2 of the plotoverlines
# - the third is the name of the simulation you want to save
# 
# }
from paraview.simple import *
from paraview.servermanager import *
from os import *
#from paraview import vtk
#import importlib.util

# get source
a1 = FindSource('bfs_fds.vtu') #mettere il nome del file che si ha importato

# plot over line
plotOverLine1 = PlotOverLine(Input=a1)  

# select fields - here you write all the fields you want to export (if you want to xport all fields consider using python trace to automatically write the matrix)
passArrays1 = PassArrays(Input=plotOverLine1)
passArrays1.PointDataArrays = ['Density', 'Eddy_Viscosity', 'Heat_Flux', 'Laminar_Viscosity', 'Omega', 'Pressure', 'Pressure_Coefficient', 'Residual_Omega', 'Residual_Pressure', 'Residual_TKE', 'Residual_Velocity', 'Skin_Friction_Coefficient', 'Turb_Kin_Energy', 'Velocity', 'Y_Plus', 'arc_length', 'vtkValidPointMask']

# points of interest:
x_vec = [-0.8, -0.4, 0,    0.05,     0.1,     0.2,     0.3,     0.5,       1,     1.4] 
y_vec1 = [0,    0,   0, -0.0267, -0.0267, -0.0267, -0.0267, -0.0267, -0.0267, -0.0267]

setFolder="folder1" #the folder must exist in this way, it is possible to write something like os.mkdir, but up to now it returns access denied
for i in range(len(x_vec)) :
    plotOverLine1.Point1 = [x_vec[i], y_vec1[i], 0 ]
    plotOverLine1.Point2 = [x_vec[i], 0.04, 0 ]
    writer = CreateWriter('./bfsSimulationData_x{0}.csv')
    writer.UpdatePipeline()
    SaveData("/simulation_x{0}".format(x_vec[i]), proxy=plotOverLine1, PointDataArrays=passArrays1)