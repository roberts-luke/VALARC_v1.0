#!/bin/bash

if [ $# -eq 0 ] ; then echo 'need a [KEYWORD] (will be inserted inside the figure title and output name) and a list of id [RUNIDS RUNID ...] (definition of line style need to be done in RUNID.db)'; exit; fi

 module load scitools #used within Met Office only

KEY=${1}
FREQ=${2}
RUNIDS=${@:3}
#PERIOD=${4}

#existing data stored in:
DATPATH=${DATADIR}/VALARC/DATA

echo '  '

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# FRAM STRAIT #
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# mean volume transport through Fram Strait
echo 'plot mean transport through Fram Strait time series'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f *TRPav_FramStrait_*${FREQ}_*.nc -var vtrp -sf -1 -title "Mean transport - Fram Strait (Sv)" -dir ${DATPATH} -o ${KEY}_TRPav_FRAM #-obs OBS/TRPav_FRAM_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi

# mean salt transport through Fram Strait
echo 'plot mean salt transport through Fram Strait time series'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f *TRPav_FramStrait_*${FREQ}_*.nc -var strp -sf -1 -title "Mean salt transport - Fram Strait (Kt m/s)" -dir ${DATPATH} -o ${KEY}_TRPav_FRAM_salt #-obs OBS/TRPav_FRAM_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi

# mean heat transport through Fram Strait
echo 'plot mean heat transport through Fram Strait time series'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f *TRPav_FramStrait_*${FREQ}_*.nc -var htrp -sf -1 -title "Mean heat transport - Fram Strait (PW m/s)" -dir ${DATPATH} -o ${KEY}_TRPav_FRAM_heat -obs OBS/FRM_heat_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# DAVIS STRAIT #
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# mean volume transport through Davis Strait
echo 'plot mean transport through Davis Strait time series'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f *TRPav_DavisStrait_*${FREQ}*.nc -var vtrp -sf -1 -title "Mean transport - Davis Strait (Sv)" -dir ${DATPATH} -o ${KEY}_TRPav_DAVIS #-obs OBS/TRPav_FRAM_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi

# mean salt transport through Davis Strait
echo 'plot mean salt transport through Davis Strait time series'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f *TRPav_DavisStrait_*${FREQ}_*.nc -var strp -sf -1 -title "Mean salt transport - Davis Strait (Kt m/s)" -dir ${DATPATH} -o ${KEY}_TRPav_DAVIS_salt #-obs OBS/TRPav_FRAM_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi

# mean heat transport through Davis Strait
echo 'plot mean heat transport through Davis Strait time series'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f *TRPav_DavisStrait_*${FREQ}_*.nc -var htrp -sf -1 -title "Mean heat transport - Davis Strait (PW m/s)" -dir ${DATPATH} -o ${KEY}_TRPav_DAVIS_heat -obs OBS/DVS_heat_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# BERING STRAIT
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# mean volume transport through Bering Strait
echo 'plot mean transport through Bering Strait time series'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f *TRPav_BeringStrait_*${FREQ}*.nc -var vtrp -sf -1 -title "Mean transport - Bering Strait (Sv)" -dir ${DATPATH} -o ${KEY}_TRPav_BERING #-obs OBS/TRPav_FRAM_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi

# mean salt transport through Bering Strait
echo 'plot mean salt transport through Bering Strait time series'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f *TRPav_BeringStrait_*${FREQ}_*.nc -var strp -sf -1 -title "Mean salt transport - Bering Strait (Kt m/s)" -dir ${DATPATH} -o ${KEY}_TRPav_BERING_salt #-obs OBS/TRPav_FRAM_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi

# mean heat transport through Bering Strait
echo 'plot mean heat transport through Bering Strait time series'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f *TRPav_BeringStrait_*${FREQ}_*.nc -var htrp -sf -1 -title "Mean heat transport - Bering Strait (PW m/s)" -dir ${DATPATH} -o ${KEY}_TRPav_BERING_heat -obs OBS/BRG_heat_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi


#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# BARENTS SEA OPENING #
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# mean volume transport through Barents sea  
echo 'plot mean transport through Barents Sea  time series'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f *TRPav_BarentsStrait_*${FREQ}*.nc -var vtrp -sf -1 -title "Mean transport - Barents Sea (Sv)" -dir ${DATPATH} -o ${KEY}_TRPav_BARENTS #-obs OBS/TRPav_FRAM_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi

# mean salt transport through Barents sea
echo 'plot mean salt transport through Barents sea time series'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f *TRPav_BarentsStrait_*${FREQ}_*.nc -var strp -sf -1 -title "Mean salt transport - Barents Sea (Kt m/s)" -dir ${DATPATH} -o ${KEY}_TRPav_BARENTS_salt #-obs OBS/TRPav_FRAM_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi

# mean heat transport through Barents sea
echo 'plot mean heat transport through Barents sea time series'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f *TRPav_BarentsStrait_*${FREQ}_*.nc -var htrp -sf -1 -title "Mean heat transport - Barents Sea (PW m/s)" -dir ${DATPATH} -o ${KEY}_TRPav_BARENTS_heat -obs OBS/BRT_heat_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi


#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# PLOTTING
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# crop figure (rm legend)
convert ${KEY}_TRPav_BARENTS.png           -crop 1240x1040+0+0 tmp01.png
convert ${KEY}_TRPav_BERING.png            -crop 1240x1040+0+0 tmp02.png
convert ${KEY}_TRPav_DAVIS.png             -crop 1240x1040+0+0 tmp03.png
convert ${KEY}_TRPav_FRAM.png              -crop 1240x1040+0+0 tmp04.png

convert ${KEY}_TRPav_BARENTS_salt.png           -crop 1240x1040+0+0 tmp05.png
convert ${KEY}_TRPav_BERING_salt.png            -crop 1240x1040+0+0 tmp06.png
convert ${KEY}_TRPav_DAVIS_salt.png             -crop 1240x1040+0+0 tmp07.png
convert ${KEY}_TRPav_FRAM_salt.png              -crop 1240x1040+0+0 tmp08.png

convert ${KEY}_TRPav_BARENTS_heat.png           -crop 1240x1040+0+0 tmp09.png
convert ${KEY}_TRPav_BERING_heat.png            -crop 1240x1040+0+0 tmp10.png
convert ${KEY}_TRPav_DAVIS_heat.png             -crop 1240x1040+0+0 tmp11.png
convert ${KEY}_TRPav_FRAM_heat.png              -crop 1240x1040+0+0 tmp12.png

# trim figure (remove white area)
convert legend.png      -trim    -bordercolor White -border 20 tmp13.png
convert runidname.png   -trim    -bordercolor White -border 20 tmp14.png

# compose the image of transports
convert \( tmp01.png tmp02.png tmp03.png tmp04.png +append \) \
        \( tmp05.png tmp06.png tmp07.png tmp08.png +append \) \
        \( tmp09.png tmp10.png tmp11.png tmp12.png +append \) \
           tmp13.png tmp14.png -append -trim -bordercolor White -border 50 $KEY.png

# save figure
mv ${KEY}_*.png FIGURES/.
mv ${KEY}_*.txt FIGURES/.
mv tmp13.png FIGURES/${KEY}_legend.png
mv tmp14.png FIGURES/${KEY}_runidname.png

# clean
rm tmp??.png
rm runidname.png
rm legend.png

#display
display -resize 30% $KEY.png
