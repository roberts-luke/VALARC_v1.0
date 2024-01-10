#!/bin/bash
#SBATCH --mem=10G
#SBATCH --time=20
#SBATCH --ntasks=1

if [[ $# -ne 4 ]]; then echo 'mk_htc.bash [CONFIG (eORCA12, eORCA025 ...)] [RUNID (mi-aa000)] [TAG (19991201_20061201_ANN)] [FREQ (1y)]'; exit 1 ; fi

CONFIG=$1
RUNID=$2
TAG=$3
FREQ=$4

# load path and mask
. param.bash
. ${SCRPATH}/common.bash

cd $DATPATH/
JOBOUT_PATH=$DATPATH/JOBOUT

# name
RUN_NAME=${RUNID#*-}

# check presence of input file
FILET=`ls [nu]*${RUN_NAME}o_${FREQ}_${TAG}*_grid[-_]T.nc`
if [ ! -f $FILET ] ; then echo "$FILET is missing; exit"; echo "E R R O R in : ./mk_htc.bash $@ (see ${JOBOUT_PATH}/mk_htc_${FREQ}_${TAG}.out)" >> ${EXEPATH}/ERROR.txt ; exit 1 ; fi

# calculate heat content of Eurasian basin in Joules --> area of heat content for each layer
FILEOUT=HEATC_EB_${RUN_NAME}o_${FREQ}_${TAG}_heatc.nc
FILEOUT2=HEATC_CB_${RUN_NAME}o_${FREQ}_${TAG}_heatc.nc
ijbox=$($CDFPATH/cdffindij -w -10.000 10.000  84.000  88.000 -c mesh.nc -p T | tail -2 | head -1 )
ijbox2=$($CDFPATH/cdffindij -w 128 160 72 83 -c mesh.nc -p T | tail -2 | head -1 )


echo "ijbox : $ijbox"

if [[ $CONFIG -eq eORCA1 || eORCA025 || eORCA12 ]]; then
  $CDFPATH/cdfheatc -f $FILET -zoom ${ijbox} 1 43 -o $FILEOUT 
fi

if [[ $CONFIG -eq eORCA1 || eORCA025 || eORCA12 ]]; then
  $CDFPATH/cdfheatc -f $FILET -zoom ${ijbox2} 1 43 -o $FILEOUT2 
fi

#assumes 75 levels in ocean. 43 is 679m depth

#Computes the heat content in the specified area (Joules). Using all depth.
#cdfheatc  -f T-file [-mxloption option] [-mxlf MXL-file] ...'
#             [-zoom imin imax jmin jmax kmin kmax] [-full] [-o OUT-file]'
#             [-M MSK-file VAR-mask ] [-vvl ]

#outputs: heatc3d (Joules)

# mv output file
#if the previous command =! 0, save it otherwise return an error
#if [[ $? -eq 0 ]]; then
#   mv tmp_$FILEOUT $FILEOUT
#else
#   echo "error when running cdfheatc; exit"; echo "E R R O R in : ./mk_htc.bash $@ (see ${JOBOUT_PATH}/mk_htc_${FREQ}_${TAG}.out)" >> ${EXEPATH}/ERROR.txt ; exit 1
#fi

#needed due to problem reading masked heatc3d variable:
ncatted -a valid_min,heatc3d,d,, -a valid_max,heatc3d,d,, $FILEOUT
ncatted -a valid_min,heatc3d,d,, -a valid_max,heatc3d,d,, $FILEOUT2
