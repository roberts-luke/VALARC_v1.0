#!/bin/bash
#SBATCH --mem=1G
#SBATCH --time=10
#SBATCH --ntasks=1

if [[ $# -ne 4 ]]; then echo 'mk_tprofile_EB.bash [CONFIG (eORCA12, eORCA025 ...)] [RUNID (mi-aa000)] [TAG (19991201_20061201_ANN)] [FREQ (1y)]'; exit 1 ; fi

CONFIG=$1
RUNID=$2
TAG=$3
FREQ=$4
GRID='T'

echo '$runTPROFILE_EB'

# load path and mask
. param.bash
. ${SCRPATH}/common.bash

cd $DATPATH/
JOBOUT_PATH=$DATPATH/JOBOUT

# name
RUN_NAME=${RUNID#*-}

# check presence of input file
echo $RUNID
echo $TAG
if [[ ${RUNID} = u-ah494 ]]; then
  FILE=`ls ${RUNID}o_${FREQ}_${TAG}*T.nc`
else
  FILE=`ls [nu]*${RUN_NAME}o_${FREQ}_${TAG}*_grid-T.nc`
fi

echo $FILE
if [ ! -f $FILE ] ; then echo "$FILE is missing; exit"; echo "E R R O R in : ./mk_tprofile_EB.bash $@ (see ${JOBOUT_PATH}/mk_tpe_${FREQ}_${TAG}.out)" >> ${EXEPATH}/ERROR.txt ; exit 1 ; fi

## calculate mean temperature profile over Eurasian Basin
set -x
FILEOUT=tempmeanprofile_EB_${RUN_NAME}o_${FREQ}_${TAG}_grid-${GRID}.nc
#FILEOUT_AWCT=AWCT_EB_${RUN_NAME}o_${FREQ}_${TAG}_grid-${GRID}.nc
ijbox=$($CDFPATH/cdffindij -w -10. 10. 84. 88. -c mesh.nc -p T | tail -2 | head -1 )
echo "ijbox : $ijbox"
$CDFPATH/cdfmean -f $FILE -surf -v '|thetao|thetao_con|votemper|' -w ${ijbox} 1 75 -p T -minmax -o $FILEOUT


#mv output file
#if [[ $? -eq 0 ]]; then 
#   mv tmp_$FILEOUT $FILEOUT
#else 
#   echo "error when running cdfmean; exit"; echo "E R R O R in : ./mk_sst.bash $@ (see ${JOBOUT_PATH}/mk_sst_${FREQ}_${TAG}.out)" >> ${EXEPATH}/ERROR.txt ; exit 1
#fi




