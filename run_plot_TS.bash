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


# mean SSS in Eurasian Basin
echo 'plot mean SSS in Eurasian basin time series'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f SSSav_EurasianBasin_*${FREQ}*T.nc -var '(mean_so|mean_vosaline|mean_so_abs)' -title "Mean SSS in Eurasian Basin (PSU)" -dir ${DATPATH} -o ${KEY}_SSS_EurasianBasin #-obs OBS/SSS_LabSea_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi

# mean SST in Eurasian Basin
echo 'plot mean SST in Eurasian basin time series'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f SSTav_EurasianBasin_*${FREQ}*T.nc -var '(mean_thetao|mean_thetao_con|mean_votemper)' -title "Mean SST in Eurasian Basin (degC)" -dir ${DATPATH} -o ${KEY}_SST_EurasianBasin #-obs OBS/SST_newf_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi

# mean SSS in Canadian Basin
echo 'plot mean SSS in Canadian basin time series'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f SSSav_CanadianBasin_*${FREQ}*T.nc -var '(mean_so|mean_vosaline|mean_so_abs)' -title "Mean SSS in Canadian Basin (PSU)" -dir ${DATPATH} -o ${KEY}_SSS_CanadianBasin #-obs OBS/SSS_LabSea_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi

# mean SST in Canadian Basin
echo 'plot mean SST in Canadian basin time series'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f SSTav_CanadianBasin_*${FREQ}*T.nc -var '(mean_thetao|mean_thetao_con|mean_votemper)' -title "Mean SST in Canadian Basin (degC)" -dir ${DATPATH} -o ${KEY}_SST_CanadianBasin #-obs OBS/SST_newf_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi

# Heat content of Eurasian Basin
echo 'plot heat content of Eurasian Basin time series'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f *HEATC_EB_*${FREQ}*heatc.nc -var heatc3d -title "Heat content above 700m - Eurasian (*10e19 J)" -dir ${DATPATH} -o ${KEY}_HTC_EB_top #-obs OBS/HTC_subp_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi

# Heat content of Canadian Basin
echo 'plot heat content of Canadian Basin time series'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f *HEATC_CB_*${FREQ}*heatc.nc -var heatc3d -title "Heat content above 700m - Canadian (*10e19 J)" -dir ${DATPATH} -o ${KEY}_HTC_CB_top #-obs OBS/HTC_subp_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi

# AWCT in Eurasian Basin
echo 'plot mean AWCT in Eurasian basin time series'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f tempmeanprofile_EB_*${FREQ}*T.nc -var '(max_thetao|max_thetao_con|max_votemper)' -title "AWCT in Euarsian Basin (degC)" -dir ${DATPATH} -o ${KEY}_AWCT_EB #-obs OBS/SST_newf_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi

# AWCT in Canadian Basin
echo 'plot mean AWCT in Canadian basin time series'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f tempmeanprofile_CB_*${FREQ}*T.nc -var '(max_thetao|max_thetao_con|max_votemper)' -title "AWCT in Canadian Basin (degC)" -dir ${DATPATH} -o ${KEY}_AWCT_CB #-obs OBS/SST_newf_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi

# Beaufort Gyre Mean Baratropic Stream Function
echo 'plot Beaufort Gyre Mean Baratropic Stream Function'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f BFGy_*${FREQ}*.nc -var max_sobarstf -title "Beaufort Gyre Baratropic Stream Function (Sv)" -dir ${DATPATH} -o ${KEY}_BFG -sf 0.000001 #-obs OBS/SST_newf_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi

# Bottom Water in Eurasian Basin
echo 'plot mean Bottom Water in Eurasian basin time series'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f EUR_BOT_thetao*${FREQ}*T.nc -var mean_thetao -title "Euarsian Basin Bottom Waters (degC)" -dir ${DATPATH} -o ${KEY}_BTW_EB #-obs OBS/SST_newf_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi

# Bottom Water in Canadian Basin
echo 'plot mean Bottom Water in Canadian basin time series'
python SCRIPT/plot_time_series.py -noshow -runid $RUNIDS -f CAN_BOT_thetao*${FREQ}*T.nc -var mean_thetao -title "Canadian Basin Bottom Waters (degC)" -dir ${DATPATH} -o ${KEY}_BTW_CB #-obs OBS/SST_newf_obs.txt
if [[ $? -ne 0 ]]; then exit 42; fi

# These profile plots can be run to create single profiles of avergaged basins. Current functionaility requires hard-coded suite-ID and dates, so not used in main tool. For best use, run the python script in isolation with desired files

# temperature profile in Eurasian Basin 
#echo 'plot mean temperature profile in Eurasian region'
#python SCRIPT/plot_profile_temp.py -runid $RUNIDS -f tempmeanprofile_EB_co779o_${FREQ}_19801201_grid-T.nc -f2 tempmeanprofile_EB_ci423o_${FREQ}_20001201_grid-T.nc -var '(mean_thetao|mean_thetao_con|mean_votemper)' -title "Mean temperature profile for Eurasian Basin" -dir ${DATPATH} -o ${KEY}_Eurasian_profile_SST
#if [[ $? -ne 0 ]]; then exit 42; fi

# temperature profile in Canadian Basin 
#echo 'plot mean temperature profile in Canadian region'
#python SCRIPT/plot_profile_temp.py -runid $RUNIDS -f tempmeanprofile_CB_bs902o_${FREQ}_20001201_grid-T.nc -f2 tempmeanprofile_CB_ci423o_${FREQ}_20001201_grid-T.nc -var '(mean_thetao|mean_thetao_con|mean_votemper)' -title "Mean temperature profile for Canadian Basin" -dir ${DATPATH} -o ${KEY}_Canadian_profile_SST
#if [[ $? -ne 0 ]]; then exit 42; fi

# salinity profile in Eurasian Basin 
#echo 'plot mean salinity profile in Eurasian region'
#python SCRIPT/plot_profile_sal.py -runid $RUNIDS -f salmeanprofile_EB_bs902o_${FREQ}_20001201_grid-T.nc -f2 salmeanprofile_EB_ci423o_${FREQ}_20001201_grid-T.nc -var '(|so|vosaline|so_abs|)' -title "Mean Salinity profile for Eurasian Basin" -dir ${DATPATH} -o ${KEY}_Eurasian_profile_SSS
#if [[ $? -ne 0 ]]; then exit 42; fi

# salinity profile in Canadian Basin 
#echo 'plot mean salinity profile in Canadian region'
#python SCRIPT/plot_profile_sal.py -runid $RUNIDS -f salmeanprofile_CB_bs902o_${FREQ}_20001201_grid-T.nc -f2 salmeanprofile_CB_ci423o_${FREQ}_20001201_grid-T.nc -var '(|so|vosaline|so_abs|)' -title "Mean Salinty profile for Canadian Basin" -dir ${DATPATH} -o ${KEY}_Canadian_profile_SSS
#if [[ $? -ne 0 ]]; then exit 42; fi

# crop figure (rm legend)
convert ${KEY}_SSS_EurasianBasin.png           -crop 1240x1040+0+0 tmp01.png
convert ${KEY}_SST_EurasianBasin.png           -crop 1240x1040+0+0 tmp02.png
convert ${KEY}_SSS_CanadianBasin.png           -crop 1240x1040+0+0 tmp05.png
convert ${KEY}_SST_CanadianBasin.png           -crop 1240x1040+0+0 tmp06.png

convert ${KEY}_HTC_EB_top.png                      -crop 1240x1040+0+0 tmp03.png
convert ${KEY}_HTC_CB_top.png                      -crop 1240x1040+0+0 tmp07.png
convert ${KEY}_AWCT_EB.png                         -crop 1240x1040+0+0 tmp04.png
convert ${KEY}_AWCT_CB.png                         -crop 1240x1040+0+0 tmp08.png

convert ${KEY}_BFG.png                         -crop 1240x1040+0+0 tmp09.png
convert ${KEY}_BTW_EB.png                         -crop 1240x1040+0+0 tmp10.png
convert ${KEY}_BTW_CB.png                         -crop 1240x1040+0+0 tmp11.png
convert ${KEY}_MXL_EB_MEAN.png                    -crop 1240x1040+0+0 tmp12.png


# trim figure (remove white area)
convert legend.png      -trim    -bordercolor White -border 20 tmp13.png
convert runidname.png   -trim    -bordercolor White -border 20 tmp14.png

# compose the image
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
