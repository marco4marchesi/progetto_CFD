echo Mesh convergence cycle initialized...
#
# The following script runs mesh convergence simulations.
# Place the script in the directory in which you want to generate
# the files of the simulations. In the same folder there should be:
# - the config file named. The configuration
#   file shall have all standard entries for mesh directory input
#   and for th SU2 output filenames.
# in a different directory, properly set in the code:
# - the "meshG*" folders containing, each, a "meshG*.su2" file. 
#   * corresponds to the mesh ID (from 1 to N).
#

unset meshNumber
read -p "Input the number of meshes to be simulated: " meshNumber
unset maxCoreNumber
read -p "Input the maximum number of cores allowed: " maxCoreNumber
unset template
read -p "Input the name of the template config file: " templateName


#
# Iterative setting of the test case
for jj in $(seq 1 1 $meshNumber) ; do 
	
	# Generating the test case folder
	caseFolderName="caseG${jj}"
	mkdir $caseFolderName  
	
	# Generating the cfd folder
	cfdFolderName="cfdG${jj}"
	cd $caseFolderName
	mkdir $cfdFolderName  
	cd ..
	

	# Copying the mesh folder inside test case folder
	cp -r "../../../MeshFiles/meshG${jj}" $caseFolderName
	
	# Generating simulation recup file
	cp $templateName $caseFolderName
	cd $caseFolderName
	caseName="simulationCase_G${jj}.cfg"
	mv $templateName $cfdFolderName/$caseName
	
	# Updating the mesh input in the test case file
	cd $cfdFolderName
	searchString="MESH_FILENAME= ../mesh/mesh.su2"
	replaceString="MESH_FILENAME= ../meshG${jj}/meshG${jj}.su2"
	sed -i "s%$searchString%$replaceString%" $caseName
	
	# Updating output files name
	sed -i "s/CONV_FILENAME= history/CONV_FILENAME= history_G${jj}/" $caseName
	sed -i "s/RESTART_FILENAME= restart_flow.dat/RESTART_FILENAME= restart_flow_G${jj}.dat/" $caseName
	sed -i "s/VOLUME_FILENAME= flow/VOLUME_FILENAME= flow_G${jj}/" $caseName
	sed -i "s/SURFACE_FILENAME= surface_flow/SURFACE_FILENAME= surface_flow_G${jj}/" $caseName
	sed -i "s/MESH_OUT_FILENAME= mesh_out.su2/MESH_OUT_FILENAME= mesh_out_G${jj}.su2/" $caseName
	
	# Computing the optimal core number
	searchDir=../meshG${jj}/meshG${jj}.su2
	elemNumber=$(sed -n 's/^NELEM= \(.*\)/\1/p' < $searchDir)
	optimalCoreNumber=$(echo "scale=0;($elemNumber+10000)/20000" | bc)
	if [ $optimalCoreNumber -gt $maxCoreNumber ] ; then
		optimalCoreNumber=$maxCoreNumber
	fi
	
	# Running SU2
	echo Starting simulation n. ${jj} of $meshNumber 
	mpirun -n $optimalCoreNumber SU2_CFD $caseName # >"logG${jj}.log"
	
	# Back to master folder
	cd ..
	cd ..
	
done


exit