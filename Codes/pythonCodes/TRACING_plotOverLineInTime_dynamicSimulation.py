# trace generated using paraview version 5.10.0
#import paraview
#paraview.compatibility.major = 5
#paraview.compatibility.minor = 10

#### import the simple module from the paraview
from paraview.simple import *
#### disable automatic camera reset on 'Show'
paraview.simple._DisableFirstRenderCameraReset()

# get animation scene
animationScene1 = GetAnimationScene()

# Properties modified on animationScene1
animationScene1.AnimationTime = 0.0

# get the time-keeper
timeKeeper1 = GetTimeKeeper()

# find source
flow_00 = FindSource('flow_00*')

# create a new 'Plot Over Line'
plotOverLine1 = PlotOverLine(registrationName='PlotOverLine1', Input=flow_00)

# Properties modified on plotOverLine1
plotOverLine1.Point1 = [-0.0010661106859506386, -0.08955329761984003, -2.2737367544323206e-13]
plotOverLine1.Point2 = [0.0, 0.1, 0.0]

# get active view
renderView1 = GetActiveViewOrCreate('RenderView')

# show data in view
plotOverLine1Display = Show(plotOverLine1, renderView1, 'GeometryRepresentation')

# trace defaults for the display properties.
plotOverLine1Display.Representation = 'Surface'

# Create a new 'Line Chart View'
lineChartView1 = CreateView('XYChartView')

# show data in view
plotOverLine1Display_1 = Show(plotOverLine1, lineChartView1, 'XYChartRepresentation')

# get layout
layout1 = GetLayoutByName("Layout #1")

# add view to a layout so it's visible in UI
AssignViewToLayout(view=lineChartView1, layout=layout1, hint=0)

# Properties modified on plotOverLine1Display_1
plotOverLine1Display_1.SeriesPlotCorner = ['Density', '0', 'Eddy_Viscosity', '0', 'Energy', '0', 'Grid_Velocity_Magnitude', '0', 'Grid_Velocity_X', '0', 'Grid_Velocity_Y', '0', 'Grid_Velocity_Z', '0', 'Heat_Flux', '0', 'Laminar_Viscosity', '0', 'Mach', '0', 'Momentum_Magnitude', '0', 'Momentum_X', '0', 'Momentum_Y', '0', 'Momentum_Z', '0', 'Nu_Tilde', '0', 'Points_Magnitude', '0', 'Points_X', '0', 'Points_Y', '0', 'Points_Z', '0', 'Pressure', '0', 'Pressure_Coefficient', '0', 'Skin_Friction_Coefficient_Magnitude', '0', 'Skin_Friction_Coefficient_X', '0', 'Skin_Friction_Coefficient_Y', '0', 'Skin_Friction_Coefficient_Z', '0', 'Temperature', '0', 'Y_Plus', '0', 'arc_length', '0', 'vtkValidPointMask', '0']
plotOverLine1Display_1.SeriesLineStyle = ['Density', '1', 'Eddy_Viscosity', '1', 'Energy', '1', 'Grid_Velocity_Magnitude', '1', 'Grid_Velocity_X', '1', 'Grid_Velocity_Y', '1', 'Grid_Velocity_Z', '1', 'Heat_Flux', '1', 'Laminar_Viscosity', '1', 'Mach', '1', 'Momentum_Magnitude', '1', 'Momentum_X', '1', 'Momentum_Y', '1', 'Momentum_Z', '1', 'Nu_Tilde', '1', 'Points_Magnitude', '1', 'Points_X', '1', 'Points_Y', '1', 'Points_Z', '1', 'Pressure', '1', 'Pressure_Coefficient', '1', 'Skin_Friction_Coefficient_Magnitude', '1', 'Skin_Friction_Coefficient_X', '1', 'Skin_Friction_Coefficient_Y', '1', 'Skin_Friction_Coefficient_Z', '1', 'Temperature', '1', 'Y_Plus', '1', 'arc_length', '1', 'vtkValidPointMask', '1']
plotOverLine1Display_1.SeriesLineThickness = ['Density', '2', 'Eddy_Viscosity', '2', 'Energy', '2', 'Grid_Velocity_Magnitude', '2', 'Grid_Velocity_X', '2', 'Grid_Velocity_Y', '2', 'Grid_Velocity_Z', '2', 'Heat_Flux', '2', 'Laminar_Viscosity', '2', 'Mach', '2', 'Momentum_Magnitude', '2', 'Momentum_X', '2', 'Momentum_Y', '2', 'Momentum_Z', '2', 'Nu_Tilde', '2', 'Points_Magnitude', '2', 'Points_X', '2', 'Points_Y', '2', 'Points_Z', '2', 'Pressure', '2', 'Pressure_Coefficient', '2', 'Skin_Friction_Coefficient_Magnitude', '2', 'Skin_Friction_Coefficient_X', '2', 'Skin_Friction_Coefficient_Y', '2', 'Skin_Friction_Coefficient_Z', '2', 'Temperature', '2', 'Y_Plus', '2', 'arc_length', '2', 'vtkValidPointMask', '2']
plotOverLine1Display_1.SeriesMarkerStyle = ['Density', '0', 'Eddy_Viscosity', '0', 'Energy', '0', 'Grid_Velocity_Magnitude', '0', 'Grid_Velocity_X', '0', 'Grid_Velocity_Y', '0', 'Grid_Velocity_Z', '0', 'Heat_Flux', '0', 'Laminar_Viscosity', '0', 'Mach', '0', 'Momentum_Magnitude', '0', 'Momentum_X', '0', 'Momentum_Y', '0', 'Momentum_Z', '0', 'Nu_Tilde', '0', 'Points_Magnitude', '0', 'Points_X', '0', 'Points_Y', '0', 'Points_Z', '0', 'Pressure', '0', 'Pressure_Coefficient', '0', 'Skin_Friction_Coefficient_Magnitude', '0', 'Skin_Friction_Coefficient_X', '0', 'Skin_Friction_Coefficient_Y', '0', 'Skin_Friction_Coefficient_Z', '0', 'Temperature', '0', 'Y_Plus', '0', 'arc_length', '0', 'vtkValidPointMask', '0']
plotOverLine1Display_1.SeriesMarkerSize = ['Density', '4', 'Eddy_Viscosity', '4', 'Energy', '4', 'Grid_Velocity_Magnitude', '4', 'Grid_Velocity_X', '4', 'Grid_Velocity_Y', '4', 'Grid_Velocity_Z', '4', 'Heat_Flux', '4', 'Laminar_Viscosity', '4', 'Mach', '4', 'Momentum_Magnitude', '4', 'Momentum_X', '4', 'Momentum_Y', '4', 'Momentum_Z', '4', 'Nu_Tilde', '4', 'Points_Magnitude', '4', 'Points_X', '4', 'Points_Y', '4', 'Points_Z', '4', 'Pressure', '4', 'Pressure_Coefficient', '4', 'Skin_Friction_Coefficient_Magnitude', '4', 'Skin_Friction_Coefficient_X', '4', 'Skin_Friction_Coefficient_Y', '4', 'Skin_Friction_Coefficient_Z', '4', 'Temperature', '4', 'Y_Plus', '4', 'arc_length', '4', 'vtkValidPointMask', '4']

# update the view to ensure updated data information
renderView1.Update()

# get color transfer function/color map for 'Pressure'
pressureLUT = GetColorTransferFunction('Pressure')
pressureLUT.RGBPoints = [87535.8984375, 0.231373, 0.298039, 0.752941, 94228.88421298121, 0.865003, 0.865003, 0.865003, 101236.83941109042, 0.6666666666666666, 1.0, 0.0, 112575.5390625, 0.705882, 0.0156863, 0.14902]
pressureLUT.ScalarRangeInitialized = 1.0

# Rescale transfer function
pressureLUT.RescaleTransferFunction(87535.8984375, 112929.140625)

# get opacity transfer function/opacity map for 'Pressure'
pressurePWF = GetOpacityTransferFunction('Pressure')
pressurePWF.Points = [87535.8984375, 0.0, 0.5, 0.0, 112575.5390625, 1.0, 0.5, 0.0]
pressurePWF.ScalarRangeInitialized = 1

# Rescale transfer function
pressurePWF.RescaleTransferFunction(87535.8984375, 112929.140625)

animationScene1.GoToNext()

# create a new 'Plot Over Line'
plotOverLine2 = PlotOverLine(registrationName='PlotOverLine2', Input=plotOverLine1)

# set active view
SetActiveView(renderView1)

# Properties modified on plotOverLine2
plotOverLine2.Point1 = [0.031133023610917732, -0.08094173255964676, -1.1795009413617663e-12]
plotOverLine2.Point2 = [0.030928464503406767, 0.09581796426156892, -2.7000623958883807e-13]

# show data in view
plotOverLine2Display = Show(plotOverLine2, renderView1, 'GeometryRepresentation')

# trace defaults for the display properties.
plotOverLine2Display.Representation = 'Surface'

# Create a new 'Line Chart View'
lineChartView2 = CreateView('XYChartView')

# show data in view
plotOverLine2Display_1 = Show(plotOverLine2, lineChartView2, 'XYChartRepresentation')

# add view to a layout so it's visible in UI
AssignViewToLayout(view=lineChartView2, layout=layout1, hint=1)

# Properties modified on plotOverLine2Display_1
plotOverLine2Display_1.SeriesPlotCorner = ['Density', '0', 'Eddy_Viscosity', '0', 'Energy', '0', 'Grid_Velocity_Magnitude', '0', 'Grid_Velocity_X', '0', 'Grid_Velocity_Y', '0', 'Grid_Velocity_Z', '0', 'Heat_Flux', '0', 'Laminar_Viscosity', '0', 'Mach', '0', 'Momentum_Magnitude', '0', 'Momentum_X', '0', 'Momentum_Y', '0', 'Momentum_Z', '0', 'Nu_Tilde', '0', 'Points_Magnitude', '0', 'Points_X', '0', 'Points_Y', '0', 'Points_Z', '0', 'Pressure', '0', 'Pressure_Coefficient', '0', 'Skin_Friction_Coefficient_Magnitude', '0', 'Skin_Friction_Coefficient_X', '0', 'Skin_Friction_Coefficient_Y', '0', 'Skin_Friction_Coefficient_Z', '0', 'Temperature', '0', 'Y_Plus', '0', 'arc_length', '0', 'vtkValidPointMask', '0']
plotOverLine2Display_1.SeriesLineStyle = ['Density', '1', 'Eddy_Viscosity', '1', 'Energy', '1', 'Grid_Velocity_Magnitude', '1', 'Grid_Velocity_X', '1', 'Grid_Velocity_Y', '1', 'Grid_Velocity_Z', '1', 'Heat_Flux', '1', 'Laminar_Viscosity', '1', 'Mach', '1', 'Momentum_Magnitude', '1', 'Momentum_X', '1', 'Momentum_Y', '1', 'Momentum_Z', '1', 'Nu_Tilde', '1', 'Points_Magnitude', '1', 'Points_X', '1', 'Points_Y', '1', 'Points_Z', '1', 'Pressure', '1', 'Pressure_Coefficient', '1', 'Skin_Friction_Coefficient_Magnitude', '1', 'Skin_Friction_Coefficient_X', '1', 'Skin_Friction_Coefficient_Y', '1', 'Skin_Friction_Coefficient_Z', '1', 'Temperature', '1', 'Y_Plus', '1', 'arc_length', '1', 'vtkValidPointMask', '1']
plotOverLine2Display_1.SeriesLineThickness = ['Density', '2', 'Eddy_Viscosity', '2', 'Energy', '2', 'Grid_Velocity_Magnitude', '2', 'Grid_Velocity_X', '2', 'Grid_Velocity_Y', '2', 'Grid_Velocity_Z', '2', 'Heat_Flux', '2', 'Laminar_Viscosity', '2', 'Mach', '2', 'Momentum_Magnitude', '2', 'Momentum_X', '2', 'Momentum_Y', '2', 'Momentum_Z', '2', 'Nu_Tilde', '2', 'Points_Magnitude', '2', 'Points_X', '2', 'Points_Y', '2', 'Points_Z', '2', 'Pressure', '2', 'Pressure_Coefficient', '2', 'Skin_Friction_Coefficient_Magnitude', '2', 'Skin_Friction_Coefficient_X', '2', 'Skin_Friction_Coefficient_Y', '2', 'Skin_Friction_Coefficient_Z', '2', 'Temperature', '2', 'Y_Plus', '2', 'arc_length', '2', 'vtkValidPointMask', '2']
plotOverLine2Display_1.SeriesMarkerStyle = ['Density', '0', 'Eddy_Viscosity', '0', 'Energy', '0', 'Grid_Velocity_Magnitude', '0', 'Grid_Velocity_X', '0', 'Grid_Velocity_Y', '0', 'Grid_Velocity_Z', '0', 'Heat_Flux', '0', 'Laminar_Viscosity', '0', 'Mach', '0', 'Momentum_Magnitude', '0', 'Momentum_X', '0', 'Momentum_Y', '0', 'Momentum_Z', '0', 'Nu_Tilde', '0', 'Points_Magnitude', '0', 'Points_X', '0', 'Points_Y', '0', 'Points_Z', '0', 'Pressure', '0', 'Pressure_Coefficient', '0', 'Skin_Friction_Coefficient_Magnitude', '0', 'Skin_Friction_Coefficient_X', '0', 'Skin_Friction_Coefficient_Y', '0', 'Skin_Friction_Coefficient_Z', '0', 'Temperature', '0', 'Y_Plus', '0', 'arc_length', '0', 'vtkValidPointMask', '0']
plotOverLine2Display_1.SeriesMarkerSize = ['Density', '4', 'Eddy_Viscosity', '4', 'Energy', '4', 'Grid_Velocity_Magnitude', '4', 'Grid_Velocity_X', '4', 'Grid_Velocity_Y', '4', 'Grid_Velocity_Z', '4', 'Heat_Flux', '4', 'Laminar_Viscosity', '4', 'Mach', '4', 'Momentum_Magnitude', '4', 'Momentum_X', '4', 'Momentum_Y', '4', 'Momentum_Z', '4', 'Nu_Tilde', '4', 'Points_Magnitude', '4', 'Points_X', '4', 'Points_Y', '4', 'Points_Z', '4', 'Pressure', '4', 'Pressure_Coefficient', '4', 'Skin_Friction_Coefficient_Magnitude', '4', 'Skin_Friction_Coefficient_X', '4', 'Skin_Friction_Coefficient_Y', '4', 'Skin_Friction_Coefficient_Z', '4', 'Temperature', '4', 'Y_Plus', '4', 'arc_length', '4', 'vtkValidPointMask', '4']

# update the view to ensure updated data information
renderView1.Update()

animationScene1.GoToNext()

# create a new 'Plot Over Line'
plotOverLine3 = PlotOverLine(registrationName='PlotOverLine3', Input=plotOverLine2)

# Properties modified on plotOverLine3
plotOverLine3.Point1 = [0.0, 0.0, 0.0]
plotOverLine3.Point2 = [0.0, 0.1, 0.0]

# show data in view
plotOverLine3Display = Show(plotOverLine3, lineChartView2, 'XYChartRepresentation')

# update the view to ensure updated data information
lineChartView2.Update()

# Properties modified on plotOverLine3Display
plotOverLine3Display.SeriesPlotCorner = ['Density', '0', 'Eddy_Viscosity', '0', 'Energy', '0', 'Grid_Velocity_Magnitude', '0', 'Grid_Velocity_X', '0', 'Grid_Velocity_Y', '0', 'Grid_Velocity_Z', '0', 'Heat_Flux', '0', 'Laminar_Viscosity', '0', 'Mach', '0', 'Momentum_Magnitude', '0', 'Momentum_X', '0', 'Momentum_Y', '0', 'Momentum_Z', '0', 'Nu_Tilde', '0', 'Points_Magnitude', '0', 'Points_X', '0', 'Points_Y', '0', 'Points_Z', '0', 'Pressure', '0', 'Pressure_Coefficient', '0', 'Skin_Friction_Coefficient_Magnitude', '0', 'Skin_Friction_Coefficient_X', '0', 'Skin_Friction_Coefficient_Y', '0', 'Skin_Friction_Coefficient_Z', '0', 'Temperature', '0', 'Y_Plus', '0', 'arc_length', '0', 'vtkValidPointMask', '0']
plotOverLine3Display.SeriesLineStyle = ['Density', '1', 'Eddy_Viscosity', '1', 'Energy', '1', 'Grid_Velocity_Magnitude', '1', 'Grid_Velocity_X', '1', 'Grid_Velocity_Y', '1', 'Grid_Velocity_Z', '1', 'Heat_Flux', '1', 'Laminar_Viscosity', '1', 'Mach', '1', 'Momentum_Magnitude', '1', 'Momentum_X', '1', 'Momentum_Y', '1', 'Momentum_Z', '1', 'Nu_Tilde', '1', 'Points_Magnitude', '1', 'Points_X', '1', 'Points_Y', '1', 'Points_Z', '1', 'Pressure', '1', 'Pressure_Coefficient', '1', 'Skin_Friction_Coefficient_Magnitude', '1', 'Skin_Friction_Coefficient_X', '1', 'Skin_Friction_Coefficient_Y', '1', 'Skin_Friction_Coefficient_Z', '1', 'Temperature', '1', 'Y_Plus', '1', 'arc_length', '1', 'vtkValidPointMask', '1']
plotOverLine3Display.SeriesLineThickness = ['Density', '2', 'Eddy_Viscosity', '2', 'Energy', '2', 'Grid_Velocity_Magnitude', '2', 'Grid_Velocity_X', '2', 'Grid_Velocity_Y', '2', 'Grid_Velocity_Z', '2', 'Heat_Flux', '2', 'Laminar_Viscosity', '2', 'Mach', '2', 'Momentum_Magnitude', '2', 'Momentum_X', '2', 'Momentum_Y', '2', 'Momentum_Z', '2', 'Nu_Tilde', '2', 'Points_Magnitude', '2', 'Points_X', '2', 'Points_Y', '2', 'Points_Z', '2', 'Pressure', '2', 'Pressure_Coefficient', '2', 'Skin_Friction_Coefficient_Magnitude', '2', 'Skin_Friction_Coefficient_X', '2', 'Skin_Friction_Coefficient_Y', '2', 'Skin_Friction_Coefficient_Z', '2', 'Temperature', '2', 'Y_Plus', '2', 'arc_length', '2', 'vtkValidPointMask', '2']
plotOverLine3Display.SeriesMarkerStyle = ['Density', '0', 'Eddy_Viscosity', '0', 'Energy', '0', 'Grid_Velocity_Magnitude', '0', 'Grid_Velocity_X', '0', 'Grid_Velocity_Y', '0', 'Grid_Velocity_Z', '0', 'Heat_Flux', '0', 'Laminar_Viscosity', '0', 'Mach', '0', 'Momentum_Magnitude', '0', 'Momentum_X', '0', 'Momentum_Y', '0', 'Momentum_Z', '0', 'Nu_Tilde', '0', 'Points_Magnitude', '0', 'Points_X', '0', 'Points_Y', '0', 'Points_Z', '0', 'Pressure', '0', 'Pressure_Coefficient', '0', 'Skin_Friction_Coefficient_Magnitude', '0', 'Skin_Friction_Coefficient_X', '0', 'Skin_Friction_Coefficient_Y', '0', 'Skin_Friction_Coefficient_Z', '0', 'Temperature', '0', 'Y_Plus', '0', 'arc_length', '0', 'vtkValidPointMask', '0']
plotOverLine3Display.SeriesMarkerSize = ['Density', '4', 'Eddy_Viscosity', '4', 'Energy', '4', 'Grid_Velocity_Magnitude', '4', 'Grid_Velocity_X', '4', 'Grid_Velocity_Y', '4', 'Grid_Velocity_Z', '4', 'Heat_Flux', '4', 'Laminar_Viscosity', '4', 'Mach', '4', 'Momentum_Magnitude', '4', 'Momentum_X', '4', 'Momentum_Y', '4', 'Momentum_Z', '4', 'Nu_Tilde', '4', 'Points_Magnitude', '4', 'Points_X', '4', 'Points_Y', '4', 'Points_Z', '4', 'Pressure', '4', 'Pressure_Coefficient', '4', 'Skin_Friction_Coefficient_Magnitude', '4', 'Skin_Friction_Coefficient_X', '4', 'Skin_Friction_Coefficient_Y', '4', 'Skin_Friction_Coefficient_Z', '4', 'Temperature', '4', 'Y_Plus', '4', 'arc_length', '4', 'vtkValidPointMask', '4']

#================================================================
# addendum: following script captures some of the application
# state to faithfully reproduce the visualization during playback
#================================================================

#--------------------------------
# saving layout sizes for layouts

# layout/tab size in pixels
layout1.SetSize(1847, 904)

#-----------------------------------
# saving camera placements for views

# current camera placement for renderView1
renderView1.InteractionMode = '2D'
renderView1.CameraPosition = [0.20273095855437173, -0.044476438234918314, 9999.999999999933]
renderView1.CameraFocalPoint = [0.20273095855437173, -0.044476438234918314, 0.0]
renderView1.CameraViewUp = [-0.002664919086612927, 0.9999964490968266, 0.0]
renderView1.CameraParallelScale = 0.15354246527463597

#--------------------------------------------
# uncomment the following to render all views
# RenderAllViews()
# alternatively, if you want to write images, you can use SaveScreenshot(...).