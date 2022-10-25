# The following script produces the polar of the RAE2822 airfoil.
# Place the script in the directory in which you want to generate
# the files of the simulations. In the same folder there should be:
# - the config file named "simulationCase.cfg". The configuration
#   file shall have all standard entries for the output filenames.
#   Moreover, the parameters which are going to be changed during
#   the iterations shall be named according to the searchStrings
#   of the sed command (this version changes the AoA only).
# - a "mesh" folder containing a "mesh.su2" file.

# Definition of the angles of attack of interest
aoaArray=(0 2 4 6)
nPoints=4
iter=$(echo "scale=0;$nPoints-1" | bc)
coreNumber=3

# Iterative setting of the test case
for jj in $(seq 0 1 $iter) ; do 

	# Extracting current angle of attack
	currentAoa=${aoaArray[$jj]}

	# Generating the test case folder
	caseFolderName="caseAoa${currentAoa}"
	mkdir $caseFolderName  
	
	# Generating simulation recup file
	cp simulationCase.cfg $caseFolderName
	cd $caseFolderName
	caseName="simulationCase_aoa${currentAoa}.cfg"
	mv simulationCase.cfg $caseName
	
	# Updating the angle of attack in the test case file
	sed -i "s/AOA= 0.0974/AOA= ${currentAoa}/" $caseName
	
	# Updating output files name
	sed -i "s/CONV_FILENAME= history/CONV_FILENAME= history_aoa${currentAoa}/" $caseName
	sed -i "s/RESTART_FILENAME= restart_flow.dat/RESTART_FILENAME= restart_flow_aoa${currentAoa}.dat/" $caseName
	sed -i "s/VOLUME_FILENAME= flow/VOLUME_FILENAME= flow_aoa${currentAoa}/" $caseName
	sed -i "s/SURFACE_FILENAME= surface_flow/SURFACE_FILENAME= surface_flow_aoa${currentAoa}/" $caseName
	sed -i "s/MESH_OUT_FILENAME= mesh_out.su2/MESH_OUT_FILENAME= mesh_out_aoa${currentAoa}.su2/" $caseName	
	
	# Running SU2
	mpirun -n $coreNumber SU2_CFD $caseName # >"logAoa${currentAoa}.log"
	
	# Back to master folder
	cd ..

done
	




