#!/bin/bash

ulimit -s unlimited

# On initial setup of the VALARC tool, user must set paths below
# to personal paths

# Path to where mask are stored (name of mesh mask in SCRIPT/common.bash)
MSKPATH=${HOME}/Documents/MESH_MASK/

# Path to where cdftools are stored
CDFPATH=${HOME}/ValidationTools/VALARC/CDFTOOLS_4.0/bin

# main VALARC directory
EXEPATH=${HOME}/ValidationTools/VALARC/

# SCRIPT location
SCRPATH=${EXEPATH}SCRIPT/

# DATA path (CONFIG and RUNID are fill by script)
DATPATH=${DATADIR}/VALARC/DATA/${RUNID}

WRKPATH=${HOME}/ValidationTools/VALARC/

# Set to 1 or 0. For custom or hard coded
RUNVALARC=1

if [[ $RUNVALARC == 1 ]]; then

  runBTW=0              # Bottom Water Temperature
  runFWC=0              # Freshwater content
  runPSI=0              # Beaufort Gyre Stream Function
  runHTC=0              # Heat content
  runMLD=0              # Mixed layer depth
  runSSS_EB=0           # Sea surface salinity in EB
  runSSS_CB=0           # Sea surface salinity in CB
  runSST_EB=0           # Sea surface salinity in EB
  runSST_CB=0           # Sea surface salinity in CB
  runFRM=1              # Fram Strait transport 
  runDVS=0              # Davis Strait transport
  runBRG=0              # Bering Strait tranport
  runBRT=1              # Barents Sea transport          
  runTPROFILE_EB=0      # Temperature profile in Eurasian Basin
  runSPROFILE_EB=0      # Salinity profile in Eurasian Basin
  runTPROFILE_CB=0      # Temperature profile in Canadian Basin
  runSPROFILE_CB=0      # Salinity profile in Canadian Basin

fi

module load gcc/8.1.0 mpi/mpich/3.2.1/gnu/8.1.0 hdf5/1.8.20/gnu/8.1.0 netcdf/4.6.1/gnu/8.1.0
