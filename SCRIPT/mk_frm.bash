#! /bin/bash
#SBATCH --mem=4G
#SBATCH --time=20
#SBATCH --ntasks=1

if [[ $# -ne 4 ]]; then echo 'mk_frm.bash [CONFIG (eORCA12, eORCA025 ...)] [RUNID (mi-aa000)] [TAG (19991201_20061201_ANN)] [FREQ (1y)]'; exit 1 ; fi

CONFIG=$1
RUNID=$2
TAG=$3
FREQ=$4

echo '$runFRM'

# load path and mask
. param.bash
. ${SCRPATH}/common.bash

cd $DATPATH/
JOBOUT_PATH=$DATAPATH/JOBOUT

# name
RUN_NAME=${RUNID#*-}

# check presence of input file
GRID='V' ; FILEV=`ls *${RUN_NAME}o_${FREQ}_${TAG}*_grid[-_]V.nc`
GRID='U' ; FILEU=`ls *${RUN_NAME}o_${FREQ}_${TAG}*_grid[-_]U.nc`
GRID='T' ; FILET=`ls nemo_${RUN_NAME}o_${FREQ}_${TAG}*_grid[-_]T.nc`

if [ ! -f $FILEV ] ; then echo "$FILEV is missing; exit"; echo "E R R O R in : ./mk_frm.bash $@ (see ${JOBOUT_PATH}/mk_trp_${FREQ}_${TAG}.out)" >> ${EXEPATH}/ERROR.txt ; exit 1 ; fi
if [ ! -f $FILEU ] ; then echo "$FILEU is missing; exit"; echo "E R R O R in : ../mk_frm.bash $@ (see ${JOBOUT_PATH}/mk_trp_${FREQ}_${TAG}.out)" >> ${EXEPATH}/ERROR.txt ; exit 1 ; fi

# ---------------- Calculate transports across Fram Strait ------------------------------------------

FILEOUT=TRPav_FramStrait_${RUN_NAME}o_${FREQ}_${TAG}
$CDFPATH/cdftransport -u $FILEU -v $FILEV -lonlat -t $FILET -TS -vvl -sfx tmp_$FILEOUT < ${EXEPATH}/SECTIONS/section_FRAM.dat

# mv output file
if [[ $? -eq 0 ]]; then 
mv tmp_$FILEOUT $FILEOUT
else 
   echo "error when running cdftransport; exit" ; echo "E R R O R in : ./mk_frm.bash $@ (see SLURM/${CONFIG}/${RUNID}/mk_trp_${FREQ}_${TAG}.out)" >> ${EXEPATH}/ERROR.txt ; exit 1
fi
