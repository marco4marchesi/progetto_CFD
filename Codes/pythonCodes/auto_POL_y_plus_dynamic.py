#{
# use this script to automate export of plotOverLines in dynamic simulations.
# NOTICE: this needs a previous matlab code called "generateRotatedProfileCoordinates.m" to run
# so that the coordinates are generated following the 
# Basically in this script you have to set 3 things: 
# - the first is the source (FindSource) 
# - the second is the x,y,z arrays of point1 and point2 of the plotoverlines
# - the third is the name of the simulation you want to save
# 
# }
from paraview.simple import *
from paraview.servermanager import *
import numpy as np

#from paraview import vtk
#import importlib.util

user = input("Who is plotting? ")
simulationFolder = "SC/SA/A9/O1/caseG3/POL_results_Y_plus/"
if user == "matteo":
    savingFolder = "pippo"+simulationFolder

if user == "doppio pc":
    savingFolder = "C:/Users/marco/Desktop/tutto/UNI/2 MAGISTRALE/CFD/CFD PROJECT/progetto_CFD/Simulations/"+simulationFolder

if user == "doppio fisso":
    savingFolder = "C:/Users/marco/Desktop/UNI/2 MAGISTRALE/CFD/CFD PROJECT/progetto_CFD/Simulations/"+simulationFolder
    pythonCodesFolder = "C:/Users/marco/Desktop/UNI/2 MAGISTRALE/CFD/CFD PROJECT/progetto_CFD/Codes/pythonCodes/"
if user == "luca":
    savingFolder = "C:/Users/lucag/Desktop/Universita/Magistrale Secondo Anno/Computational_fluid_dynamics/Progetto_CFD/progetto_CFD/Simulations"+simulationFolder

if user == "marco":
    savingFolder = "topolino"+simulationFolder

    
# get source
#source1 = FindSource('flow_G3.vtu') #mettere il nome del file che si ha importato
source1 = GetActiveSource() 

# Properties modified on flow_G3vtu
source1.PointArrayStatus = ['Pressure', 'Pressure_Coefficient', 'Velocity', 'Y_Plus']

# plot over line
plotOverLine1 = PlotOverLine(Input=source1)  
plotOverLine1.Resolution = 501

# select fields - here you write all the fields you want to export (if you want to xport all fields consider using python trace to automatically write the matrix)
passArrays = ['Pressure', 'Pressure_Coefficient', 'Y_Plus']




# points of interest:
data = np.genfromtxt(pythonCodesFolder + "Naca_23012_points.dat",
                    delimiter=' ')
print(data)

x_vec = data[:,0]
y_vec1 = data[:,1] -1e-4
y_vec2 = data[:,1] +1e-4

setFolder="folder1" #the folder must exist in this way, it is possible to write something like os.mkdir, but up to now it returns access denied
for i in range(len(x_vec)) :
    plotOverLine1.Point1 = [x_vec[i], y_vec1[i], 0 ]
    plotOverLine1.Point2 = [x_vec[i], y_vec2[i], 0 ]
    
    SaveData(savingFolder + "sim{0}.csv".format(i), proxy=plotOverLine1, PointDataArrays= passArrays)