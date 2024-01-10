#!/bin/bash
#SBATCH --mem=100G
#SBATCH --time=100
#SBATCH --ntasks=1

if [[ $# -ne 4 ]]; then echo 'mk_btw.bash [CONFIG (eORCA12, eORCA025 ...)] [RUNID (mi-aa000)] [TAG (19991201_20061201_ANN)] [FREQ (1y)]'; exit 1 ; fi

CONFIG=$1
RUNID=$2
TAG=$3
FREQ=$4
GRID='T'

echo '$runBTW'

# load path and mask
. param.bash
. ${SCRPATH}/common.bash

cd $DATPATH/
JOBOUT_PATH=$DATPATH/JOBOUT

# name
RUN_NAME=${RUNID#*-}

# check presence of input file
FILE=`ls [nu]*${RUN_NAME}o_${FREQ}_${TAG}*_grid[-_]${GRID}.nc`
if [ ! -f $FILE ] ; then echo "$FILE is missing; exit"; echo "E R R O R in : ./mk_btw.bash $@ (see SLURM/${CONFIG}/${RUNID}/mk_btw_${TAG}.out)" >> ${EXEPATH}/ERROR.txt ; exit 1 ; fi



# Eurasian Basin
FILEOUT=nemo_${RUN_NAME}o_${FREQ}_${TAG}_bottom-${GRID}.nc
ncks -v '|thetao|so|vosaline|so_abs|' $FILE thetao_sal_$FILEOUT
# make bottom water for EB
$CDFPATH/cdfbottom -f thetao_sal_$FILEOUT -o temp_$FILEOUT 

# mv output file
if [[ $? -eq 0 ]]; then 
   mv temp_$FILEOUT $FILEOUT
else 
   echo "error when running cdfbottom; exit"; echo "E R R O R in : ./mk_btw.bash $@ (see SLURM/${CONFIG}/${RUNID}/mk_btw_${FREQ}_${TAG}.out)" >> ${EXEPATH}/ERROR.txt ;
   exit 1
fi

# Eurasian Basin Averages
ijbox=$($CDFPATH/cdffindij -w -10.000 10.000  84.000  88.00 -c mesh.nc -p T | tail -2 | head -1 )
$CDFPATH/cdfmean -f $FILEOUT -v '|thetao|thetao_con|votemper|' -p T -var -w ${ijbox} 1 1 -minmax -o EUR_BOT_thetao_$FILEOUT
$CDFPATH/cdfmean -f $FILEOUT -v '|so|vosaline|so_abs|' -p T -var -w ${ijbox} 1 1 -minmax -o EUR_BOT_salinity_$FILEOUT

# Canadian Basin Averages
ijbox_CB=$($CDFPATH/cdffindij -w 128 160 72 83 -c mesh.nc -p T | tail -2 | head -1 )
$CDFPATH/cdfmean -f $FILEOUT -v '|thetao|thetao_con|votemper|' -p T -var -w ${ijbox_CB} 1 1 -minmax -o CAN_BOT_thetao_$FILEOUT
$CDFPATH/cdfmean -f $FILEOUT -v '|so|vosaline|so_abs|' -p T -var -w ${ijbox} 1 1 -minmax -o CAN_BOT_salinity_$FILEOUT


if [ $? -ne 0 ] ; then echo "error when running cdfmean (BTW)"; echo "E R R O R in : ./mk_btw.bash $@ (see SLURM/${CONFIG}/${RUNID}/mk_btw${FREQ}_${TAG}.out)" >> ${EXEPATH}/ERROR.txt ; fi

