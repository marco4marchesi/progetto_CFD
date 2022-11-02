echo "Mesh convergence cycle initialized..."

read -p "Input the mesh numbering starting index: " meshIndex
read -p "Input the mesh numbering ending index: " meshNumber
read -p "Input the maximum number of cores allowed: " maxCoreNumber
read -p "Input the name of the template configuration file: " templateName


for jj in $(seq $meshIndex 1 $meshNumber) ; do

    # Generating the test case folder
    caseFolderName="caseG${jj}"
    mkdir $caseFolderName

    # Generating the cfd folder
    cfdFolderName="cfdG${jj}"
    cd $caseFolderName
    mkdir $cfdFolderName
    cd ..

    # Copying the mesh folder inside the test case folder
    cp -r "../../../MeshFiles/meshG${jj}" $caseFolderName

    # Generating the simulation recup file
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

