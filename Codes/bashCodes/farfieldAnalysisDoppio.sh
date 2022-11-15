echo "Mesh convergence initialized"

read -p "Input the mesh numbering index: " meshIndex
read -p "Input the maximum number of cores allowed: " maxCoreNumber
read -p "Input tha name of the template configuration file: " templateName
read -p "Input the TVD for the second order simulation: " secondOrderTVD

# Generating the test case folders
caseFolderNameO1="O1"
mkdir $caseFolderNameO1  
caseFolderNameO2="O2"
mkdir $caseFolderNameO2

##################################################################################################################### ORDER ONE
# Generating the cfd folder
cd $caseFolderNameO1
cfdFolderNameO1="cfdG${meshIndex}"
mkdir $cfdFolderNameO1  
cd ..

# Copying the mesh folder inside test case folder
cp -r "../../../../../MeshFiles/meshG${meshIndex}" $caseFolderNameO1

# Generating simulation recup file
cp $templateName $caseFolderNameO1
cd $caseFolderNameO1
caseNameO1="simulationCase_G${meshIndex}.cfg"
mv $templateName $cfdFolderNameO1/$caseNameO1

# Updating the mesh input in the test case file
cd $cfdFolderNameO1
searchString="MESH_FILENAME= ../mesh/mesh.su2"
replaceString="MESH_FILENAME= ../meshG${meshIndex}/meshG${meshIndex}.su2"
sed -i "s%$searchString%$replaceString%" $caseNameO1

# Updating output files name
sed -i "s/CONV_FILENAME= history/CONV_FILENAME= history_G${meshIndex}/" $caseNameO1
sed -i "s/RESTART_FILENAME= restart_flow.dat/RESTART_FILENAME= restart_flow_G${meshIndex}.dat/" $caseNameO1
sed -i "s/VOLUME_FILENAME= flow/VOLUME_FILENAME= flow_G${meshIndex}/" $caseNameO1
sed -i "s/SURFACE_FILENAME= surface_flow/SURFACE_FILENAME= surface_flow_G${meshIndex}/" $caseNameO1
sed -i "s/MESH_OUT_FILENAME= mesh_out.su2/MESH_OUT_FILENAME= mesh_out_G${meshIndex}.su2/" $caseNameO1

# Computing the optimal core number
searchDir=../meshG${meshIndex}/meshG${meshIndex}.su2
elemNumber=$(sed -n 's/^NELEM= \(.*\)/\1/p' < $searchDir)
optimalCoreNumber=$(echo "scale=0;($elemNumber+10000)/20000" | bc)
if [ $optimalCoreNumber -gt $maxCoreNumber ] ; then
	optimalCoreNumber=$maxCoreNumber
fi

# Running SU2
echo Starting O1 simulation... 
echo Running with $optimalCoreNumber cores
mpirun --use-hwthread-cpus -n 24 --allow-run-as-root SU2_CFD $caseNameO1 #>"logG${meshIndex}.log"

# Back to master folder
cd ..
cd ..

##################################################################################################################### ORDER TWO
# Generating the cfd folder
cd $caseFolderNameO2
cfdFolderNameO2="cfdG${meshIndex}"
mkdir $cfdFolderNameO2 
cd ..

# Copying the mesh folder inside test case folder
cp -r "../../../../../MeshFiles/meshG${meshIndex}" $caseFolderNameO2

# Generating simulation recup file
cp $templateName $caseFolderNameO2
cd $caseFolderNameO2
caseNameO2="simulationCase_G${meshIndex}.cfg"
mv $templateName $cfdFolderNameO1/$caseNameO2

# Updating the mesh input in the test case file
cd $cfdFolderNameO2
searchString="MESH_FILENAME= ../mesh/mesh.su2"
replaceString="MESH_FILENAME= ../meshG${meshIndex}/meshG${meshIndex}.su2"
sed -i "s%$searchString%$replaceString%" $caseNameO2

# Updating output files name
sed -i "s/CONV_FILENAME= history/CONV_FILENAME= history_G${meshIndex}/" $caseNameO2
sed -i "s/RESTART_FILENAME= restart_flow.dat/RESTART_FILENAME= restart_flow_G${meshIndex}.dat/" $caseNameO2
sed -i "s/VOLUME_FILENAME= flow/VOLUME_FILENAME= flow_G${meshIndex}/" $caseNameO2
sed -i "s/SURFACE_FILENAME= surface_flow/SURFACE_FILENAME= surface_flow_G${meshIndex}/" $caseNameO2
sed -i "s/MESH_OUT_FILENAME= mesh_out.su2/MESH_OUT_FILENAME= mesh_out_G${meshIndex}.su2/" $caseNameO2
sed -i "s/RESTART_SOL= NO/RESTART_SOL= YES/" $caseNameO2
sed -i "s%SOLUTION_FILENAME= restart_solution.dat%SOLUTION_FILENAME= ../../O1/cfdG${meshIndex}/restart_flow_G${meshIndex}.dat%" $caseNameO2
sed -i "s/MUSCL_FLOW= NO/MUSCL_FLOW= YES/" $caseNameO2
sed -i "s/VENKAT_LIMITER_COEFF= 0.01/VENKAT_LIMITER_COEFF= ${secondOrderTVD}/" $caseNameO2

# Running SU2
echo Starting O2 simulation... 
echo Running with $optimalCoreNumber cores
mpirun --use-hwthread-cpus -n 24 --allow-run-as-root SU2_CFD $caseNameO2 #>"logG${meshIndex}.log"
	
# Back to master folder
cd ..
cd ..