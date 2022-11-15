# trace generated using paraview version 5.10.0
#import paraview
#paraview.compatibility.major = 5
#paraview.compatibility.minor = 10

#### import the simple module from the paraview
from paraview.simple import *
#### disable automatic camera reset on 'Show'
paraview.simple._DisableFirstRenderCameraReset()

# create a new 'XML Unstructured Grid Reader'
flow_00 = XMLUnstructuredGridReader(registrationName='flow_00*', FileName=['C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00000.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00010.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00020.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00030.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00040.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00050.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00060.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00070.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00080.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00090.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00100.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00110.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00120.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00130.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00140.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00150.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00160.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00170.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00180.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00190.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00200.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00210.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00220.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00230.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00240.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00250.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00260.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00270.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00280.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00290.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00300.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00310.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00320.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00330.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00340.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00350.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00360.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00370.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00380.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00390.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00400.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00410.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00420.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00430.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00440.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00450.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00460.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00470.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00480.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00490.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00500.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00510.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00520.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00530.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00540.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00550.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00560.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00570.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00580.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00590.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00600.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00610.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00620.vtu', 'C:\\Users\\marco\\Desktop\\UNI\\2 MAGISTRALE\\CFD\\CFD-webeep-files\\Lab 4 - Pitching Airfoil\\CFD\\flow_00630.vtu'])

# get animation scene
animationScene1 = GetAnimationScene()

# update animation scene based on data timesteps
animationScene1.UpdateAnimationUsingDataTimeSteps()

# Properties modified on flow_00
flow_00.TimeArray = 'None'

# get active view
renderView1 = GetActiveViewOrCreate('RenderView')

# show data in view
flow_00Display = Show(flow_00, renderView1, 'UnstructuredGridRepresentation')

# trace defaults for the display properties.
flow_00Display.Representation = 'Surface'

# reset view to fit data
renderView1.ResetCamera(False)

#changing interaction mode based on data extents
renderView1.InteractionMode = '2D'
renderView1.CameraPosition = [0.0, 0.0, 10000.0]

# get the material library
materialLibrary1 = GetMaterialLibrary()

# update the view to ensure updated data information
renderView1.Update()

animationScene1.GoToNext()

animationScene1.GoToNext()

animationScene1.GoToNext()

animationScene1.GoToNext()

animationScene1.GoToNext()

animationScene1.GoToNext()

animationScene1.GoToNext()

animationScene1.GoToNext()

animationScene1.Play()

# set scalar coloring
ColorBy(flow_00Display, ('POINTS', 'Pressure_Coefficient'))

# rescale color and/or opacity maps used to include current data range
flow_00Display.RescaleTransferFunctionToDataRange(True, False)

# show color bar/color legend
flow_00Display.SetScalarBarVisibility(renderView1, True)

# get color transfer function/color map for 'Pressure_Coefficient'
pressure_CoefficientLUT = GetColorTransferFunction('Pressure_Coefficient')
pressure_CoefficientLUT.RGBPoints = [-1.2332451343536377, 0.231373, 0.298039, 0.752941, -0.10991138219833374, 0.865003, 0.865003, 0.865003, 1.0134223699569702, 0.705882, 0.0156863, 0.14902]
pressure_CoefficientLUT.ScalarRangeInitialized = 1.0

# get opacity transfer function/opacity map for 'Pressure_Coefficient'
pressure_CoefficientPWF = GetOpacityTransferFunction('Pressure_Coefficient')
pressure_CoefficientPWF.Points = [-1.2332451343536377, 0.0, 0.5, 0.0, 1.0134223699569702, 1.0, 0.5, 0.0]
pressure_CoefficientPWF.ScalarRangeInitialized = 1

animationScene1.Play()

#================================================================
# addendum: following script captures some of the application
# state to faithfully reproduce the visualization during playback
#================================================================

# get layout
layout1 = GetLayout()

#--------------------------------
# saving layout sizes for layouts

# layout/tab size in pixels
layout1.SetSize(1052, 476)

#-----------------------------------
# saving camera placements for views

# current camera placement for renderView1
renderView1.InteractionMode = '2D'
renderView1.CameraPosition = [0.0, 0.0, 10000.0]
renderView1.CameraParallelScale = 1.8299462071809687

#--------------------------------------------
# uncomment the following to render all views
# RenderAllViews()
# alternatively, if you want to write images, you can use SaveScreenshot(...).