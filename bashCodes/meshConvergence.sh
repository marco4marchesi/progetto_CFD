# The following script runs mesh convergence simulations.
# Place the script in the directory in which you want to generate
# the files of the simulations. In the same folder there should be:
# - the config file named "simulationCase.cfg". The configuration
#   file shall have all standard entries for mesh directory input
#   and for th SU2 output filenames.
# - the "meshG*" folders containing, each, a "meshG*.su2" file. 
#   * corresponds to the mesh ID (from 1 to N).
# - a "meshCores.txt" text file resuming the number of cores
#   to be employed for each mesh. The *th row shall contain
#   ONLY the number (no spaces either before or after).

# Number of mesh to be simulated
meshNumber=5

# Maximum number of cores allowed for SU2
maxCoreNumber=6

# Iterative setting of the test case
for jj in $(seq 1 1 $meshNumber) ; do 

	# Generating the test case folder
	caseFolderName="caseG${jj}"
	cfdFolderName="cfdG${jj}"
	mkdir $caseFolderName  
	
	# Moving mesh folder inside test folder
	mv "meshG${jj}" $caseFolderName
	
	# Generating simulation recup file
	cp simulationCase.cfg $caseFolderName
	cd $caseFolderName
	mkdir $cfdFolderName
	caseName="simulationCase_G${jj}.cfg"
	mv simulationCase.cfg $cfdFolderName/$caseName
	
	# Updating the mesh input in the test case file
	cd $cfdFolderName
	searchString="MESH_FILENAME= ../mesh/mesh.su2"
	replaceString="MESH_FILENAME= ../meshG${jj}/meshG${jj}.su2"
	sed -i "s/$searchString/$replaceString/" $caseName
	
	# Updating output files name
	sed -i "s/CONV_FILENAME= history/CONV_FILENAME= history_G${jj}/" $caseName
	sed -i "s/RESTART_FILENAME= restart_flow.dat/RESTART_FILENAME= restart_flow_G${jj}.dat/" $caseName
	sed -i "s/VOLUME_FILENAME= flow/VOLUME_FILENAME= flow_G${jj}/" $caseName
	sed -i "s/SURFACE_FILENAME= surface_flow/SURFACE_FILENAME= surface_flow_G${jj}/" $caseName
	sed -i "s/MESH_OUT_FILENAME= mesh_out.su2/MESH_OUT_FILENAME= mesh_out_G${jj}.su2/" $caseName
	
	# Computing the optimal core number
	optimalCoreNumber=$(head -n $jj | tail -1) 
	if $optimalCoreNumber -gt $maxCoreNumber ; then
		optimalCoreNumber=$maxCoreNumber
	fi
	
	# Running SU2
	mpirun -n $optimalCoreNumber SU2_CFD $caseName # >"logG${jj}.log"
	
	# Back to master folder
	cd ..
	cd ..

done
	




