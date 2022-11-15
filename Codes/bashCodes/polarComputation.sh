echo "Polar computation initialized initialized"

read -p "Input the mesh numbering index: " meshIndex
read -p "Input the maximum number of cores allowed: " maxCoreNumber
read -p "Input tha name of the template configuration file: " templateName
read -p "Select either first or second order: " simulationOrder

extFolderName="O1"

if [ $simulationOrder -eq 2 ] ; then
    echo "Second order analysis selected!"
	read -p "Input the TVD coefficient for meshG${meshIndex}: " TVD
	extFolderName="O2"
fi

# Definition of the angles of attack of interest
aoaArray=(m4 m2 0 2 4 6 8 10 12 13 14 145 15)
vXArray=(9.49681 9.5142 9.52 9.5142 9.49681 9.46785 9.42735 9.37537 9.31197 9.2760 9.23722 9.2168 9.1956)
vYArray=(-0.33224 -0.33224 0.0 0.33224 0.66408 0.99511 1.32493 1.65313 1.97932 2.1415 2.30310 2.3836 2.4640)

# Creating folder for the selected order, copy .cfg inside and moving inside
mkdir $extFolderName
cd $extFolderName

# Copy mesh folder
cp -r "../../../../MeshFiles/meshG${meshIndex}" "meshG${meshIndex}"

# Computing iterations number
nPoints=${#aoaArray[@]}
iter=$(echo "scale=0;$nPoints-1" | bc)

# Iterative setting of the test case
for jj in $(seq 0 1 $iter) ; do 

	echo "Simulation for AOA ${aoaArray[$jj]}..."

	# Extracting current angle of attack
	currentAoa=${aoaArray[$jj]}

	# Generating the test case folder
	caseFolderName="case_A${currentAoa}"
	mkdir $caseFolderName  
	
	# Generating simulation recup file
	cp "../${templateName}" $caseFolderName/
	cd $caseFolderName
	
	# Updating the angle of attack in the test case file
	sed -i "s/INC_VELOCITY_INIT= ( 0.0, 0.0, 0.0 )/INC_VELOCITY_INIT= ( ${vXArray[$jj]}, ${vYArray[$jj]}, 0.0)/" $templateName
	
	# Updating output files name
	sed -i "s/CONV_FILENAME= history/CONV_FILENAME= history_aoa${currentAoa}/" $templateName
	sed -i "s/RESTART_FILENAME= restart_flow.dat/RESTART_FILENAME= restart_flow_aoa${currentAoa}.dat/" $templateName
	sed -i "s/VOLUME_FILENAME= flow/VOLUME_FILENAME= flow_aoa${currentAoa}/" $templateName
	sed -i "s/SURFACE_FILENAME= surface_flow/SURFACE_FILENAME= surface_flow_aoa${currentAoa}/" $templateName
	sed -i "s/MESH_OUT_FILENAME= mesh_out.su2/MESH_OUT_FILENAME= mesh_out_aoa${currentAoa}.su2/" $templateName
	sed -i "s%MESH_FILENAME= ../mesh/mesh.su2%MESH_FILENAME= ../meshG${meshIndex}/meshG${meshIndex}.su2%" $templateName
	
	if [ $simulationOrder -eq 2 ] ; then
		sed -i "s/RESTART_SOL= NO/RESTART_SOL= YES/" $templateName
		sed -i "s/MUSCL_FLOW= NO/MUSCL_FLOW= YES/" $templateName
    	sed -i "s/VENKAT_LIMITER_COEFF= 0.01/VENKAT_LIMITER_COEFF= ${TVD}/" $templateName
		sed -i "s%SOLUTION_FILENAME= restart_solution.dat%SOLUTION_FILENAME= ../../O1/case_A${currentAoa}/restart_flow_aoa${currentAoa}.dat%" $templateName
	fi

	# Computing optimal core number
	elemNumber=$(sed -n 's/^NELEM= \(.*\)/\1/p' < ../meshG${meshIndex}/meshG${meshIndex}.su2)
	optimalCoreNumber=$(echo "scale=0;($elemNumber+10000)/20000" | bc)
	if [ $optimalCoreNumber -gt $maxCoreNumber ] ; then
		optimalCoreNumber=$maxCoreNumber
	fi
	
	# Running SU2
	echo "Number of core employed: ${optimalCoreNumber}"
	mpirun -n $optimalCoreNumber SU2_CFD $templateName #>"logAoa${currentAoa}.log"
	
	# Back to master folder
	cd ..

done
	




