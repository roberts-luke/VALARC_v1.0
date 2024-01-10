#!/bin/bash
#SBATCH --mem=1G
#SBATCH --time=10
#SBATCH --ntasks=1

if [[ $# -ne 4 ]]; then echo 'mk_sss.bash [CONFIG (eORCA12, eORCA025 ...)] [RUNID (mi-aa000)] [TAG (19991201_20061201_ANN)] [FREQ (1y)]'; exit 1 ; fi

CONFIG=$1
RUNID=$2
TAG=$3
FREQ=$4
GRID='T'

echo '$runSSS'

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

FILE=`ls [nu]*${RUN_NAME}o_${FREQ}_${TAG}*_grid-T.nc`
echo $FILE
if [ ! -f $FILE ] ; then echo "$FILE is missing; exit"; echo "E R R O R in : ./mk_sss.bash $@ (see ${JOBOUT_PATH}/mk_sss_${FREQ}_${TAG}.out)" >> ${EXEPATH}/ERROR.txt ; exit 1 ; fi

# --------------- Calculate SSS in Eurasian Basin ----------------------
set -x
FILEOUT=SSSav_EurasianBasin_${RUN_NAME}o_${FREQ}_${TAG}_grid-${GRID}.nc
ijbox=$($CDFPATH/cdffindij -w -10.000 10.000  84.000  88.000 -c mesh.nc -p T | tail -2 | head -1 )
echo "ijbox : $ijbox"
$CDFPATH/cdfmean -f $FILE -surf -v '|so|vosaline|so_abs|' -w ${ijbox} 1 1 -p T -minmax -o tmp_$FILEOUT

# mv output file
if [[ $? -eq 0 ]]; then
   mv tmp_$FILEOUT $FILEOUT
else
   echo "error when running cdfmean; exit"; echo "E R R O R in : ./mk_sss.bash $@ (see ${JOBOUT_PATH}/mk_sss_${FREQ}_${TAG}.out)" >> ${EXEPATH}/ERROR.txt ; exit 1
fi