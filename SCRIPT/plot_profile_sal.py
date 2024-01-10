import numpy as np
import glob
import netCDF4 as nc
import matplotlib.pyplot as plt
import sys
import re
import datetime as dt
import argparse
import pandas as pd
import matplotlib.dates as mdates

# check argument
def parse_args():
    # deals with argument
    parser = argparse.ArgumentParser()
    parser.add_argument("-runid", metavar='runid list' , help="used to look information in runid.db"                  , type=str, nargs='+' , required=True )
    parser.add_argument("-f"    , metavar='file list'  , help="file list to plot (default is runid_var.nc)"           , type=str, nargs='+' , required=False)
    parser.add_argument("-f2"    , metavar='file list 2'  , help="file list to plot (default is runid_var.nc)"           , type=str, nargs='+' , required=False)
    parser.add_argument("-var"  , metavar='var list'   , help="variable to look for in the netcdf file ./runid_var.nc", type=str, nargs='+' , required=True )
    parser.add_argument("-varf" , metavar='var list'   , help="variable to look for in the netcdf file ./runid_var.nc", type=str, nargs='+' , required=False)
    parser.add_argument("-title", metavar='title'      , help="subplot title (associated with var)"                   , type=str, nargs='+' , required=False)
    parser.add_argument("-dir"  , metavar='directory of input file' , help="directory of input file"                  , type=str, nargs=1   , required=False, default=['./'])
    parser.add_argument("-o"    , metavar='figure_name', help="output figure name without extension"                  , type=str, nargs=1   , required=False, default=['output'])
    args = parser.parse_args()
    return args


args = parse_args()

#anc = nc.Dataset('/data/users/lroberts/VALARC/DATA/u-bs902/tempmeanprofile_EB_bs902o_1y_20001201_grid-T.nc')
#GC5 = nc.Dataset('/data/users/lroberts/VALARC/DATA/u-ci423/tempmeanprofile_EB_ci423o_1y_20001201_grid-T.nc')



anc = nc.Dataset(args.dir[0]+'/'+args.runid[0] +'/'+ args.f[0])
GC5 = nc.Dataset('/data/users/lroberts/VALARC/DATA/u-ci423/'+ args.f2[0])

#cnam=anc.variables.keys()
#print(cnam)
#cnam=get_varname(cf,cvar)


temp = anc.variables['mean_so']
depth = anc.variables['deptht']
profile = temp[0,:,0,0]
depthp = depth[:]

tempGC5 = GC5.variables['mean_so_abs']
depthGC5 = GC5.variables['deptht']
profileGC5 = tempGC5[0,:,0,0]
depthpGC5 = depthGC5[:]


plt.plot(profile, -depthp)
plt.plot(profileGC5, -depthp)
plt.ylim(-4000, 0)
#plt.ylabel('Depth (m)')
#plt.xlabel('Potential temperature (dC)'
plt.title("Potential temperature profile in XYZ basin")

plt.savefig(args.o[0]+'.png', format='png', dpi=150)

plt.show()


 



