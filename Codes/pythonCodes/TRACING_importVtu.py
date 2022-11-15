# trace generated using paraview version 5.10.0
#import paraview
#paraview.compatibility.major = 5
#paraview.compatibility.minor = 10

#### import the simple module from the paraview
from paraview.simple import *
#### disable automatic camera reset on 'Show'
paraview.simple._DisableFirstRenderCameraReset()

# create a new 'XML Unstructured Grid Reader'
flow_G6vtu = XMLUnstructuredGridReader(registrationName='flow_G6.vtu', FileName=['C:\\Users\\marco\\OneDrive - Politecnico di Milano\\MAGISTRALE\\TerzoSemestre\\CFD\\PROGETTO CFD DRIVE\\SIMULATIONS DRIVE\\Simulations\\SC2\\SA\\A14\\O2\\caseG6\\cfdG6\\flow_G6.vtu'])

# Properties modified on flow_G6vtu
flow_G6vtu.TimeArray = 'None'

# get active view
renderView1 = GetActiveViewOrCreate('RenderView')

# show data in view
flow_G6vtuDisplay = Show(flow_G6vtu, renderView1, 'UnstructuredGridRepresentation')

# trace defaults for the display properties.
flow_G6vtuDisplay.Representation = 'Surface'

# reset view to fit data
renderView1.ResetCamera(False)

#changing interaction mode based on data extents
renderView1.InteractionMode = '2D'
renderView1.CameraPosition = [80.90026092529297, 0.0, 10000.0]
renderView1.CameraFocalPoint = [80.90026092529297, 0.0, 0.0]

# get the material library
materialLibrary1 = GetMaterialLibrary()

# update the view to ensure updated data information
renderView1.Update()

# set scalar coloring
ColorBy(flow_G6vtuDisplay, ('POINTS', 'Pressure_Coefficient'))

# rescale color and/or opacity maps used to include current data range
flow_G6vtuDisplay.RescaleTransferFunctionToDataRange(True, False)

# show color bar/color legend
flow_G6vtuDisplay.SetScalarBarVisibility(renderView1, True)

# get color transfer function/color map for 'Pressure_Coefficient'
pressure_CoefficientLUT = GetColorTransferFunction('Pressure_Coefficient')
pressure_CoefficientLUT.RGBPoints = [-6.269329071044922, 0.231373, 0.298039, 0.752941, -2.6345916986465454, 0.865003, 0.865003, 0.865003, 1.000145673751831, 0.705882, 0.0156863, 0.14902]
pressure_CoefficientLUT.ScalarRangeInitialized = 1.0

# get opacity transfer function/opacity map for 'Pressure_Coefficient'
pressure_CoefficientPWF = GetOpacityTransferFunction('Pressure_Coefficient')
pressure_CoefficientPWF.Points = [-6.269329071044922, 0.0, 0.5, 0.0, 1.000145673751831, 1.0, 0.5, 0.0]
pressure_CoefficientPWF.ScalarRangeInitialized = 1

# destroy flow_G6vtu
Delete(flow_G6vtu)
del flow_G6vtu

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
renderView1.CameraPosition = [1.359999367522092, -0.1728902017650474, 10000.0]
renderView1.CameraFocalPoint = [1.359999367522092, -0.1728902017650474, 0.0]
renderView1.CameraParallelScale = 1.1915482492092142

#--------------------------------------------
# uncomment the following to render all views
# RenderAllViews()
# alternatively, if you want to write images, you can use SaveScreenshot(...).