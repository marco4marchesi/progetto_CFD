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
import numpy as np

#from paraview import vtk
#import importlib.util

user = input("Who is plotting? ")
if user == "Matteo" or user == "matteo":
    savingFolder = "pippo"

if user == "Doppio" or user == "doppio":
    savingFolder = "C:/Users/marco/Desktop/tutto/UNI/2 MAGISTRALE/CFD/CFD PROJECT/progetto_CFD/Simulations/"

if user == "Luca" or user == "luca":
    savingFolder = "paperino"

if user == "Marco" or user == "marco":
    savingFolder = "topolino"

    
# get source
a1 = FindSource('flow_G1.vtu') #mettere il nome del file che si ha importato

# plot over line
plotOverLine1 = PlotOverLine(Input=a1)  

# select fields - here you write all the fields you want to export (if you want to xport all fields consider using python trace to automatically write the matrix)
passArrays = ['Pressure', 'Pressure_Coefficient', 'Y_Plus']

# points of interest:
x_vec = np.linspace(0, 1.008, num=100, endpoint=True)

setFolder="folder1" #the folder must exist in this way, it is possible to write something like os.mkdir, but up to now it returns access denied
for i in range(len(x_vec)) :
    plotOverLine1.Point1 = [x_vec[i], -0.1, 0 ]
    plotOverLine1.Point2 = [x_vec[i],  0.1, 0 ]
    
    SaveData(savingFolder + "_sim{0}.csv".format(i), proxy=plotOverLine1, PointDataArrays= passArrays)