README for daily sea ice and climatology

Computed for NASA Team v1.1: https://nsidc.org/data/NSIDC-0051/versions/1
NASA Team data held at BAS by Tony Phillips and copied to JASMIN by him for me
sea ice extents calculated daily from sea ice concentration and with use of cell areas provided by NASA
Data is mostly only alternating days (with some gaps) to start of 1989. 

time processing:
feb 29 removed, climatologies calculated for each non-leap-day.
If climatology includes pre-1989, it may not be smooth as no interpolation was applied to pre-1989 data to create full data coverage.

NetCDF files have 'year', 'month' and 'day_of_month' coordinates for easy extraction. climatology file also has day_of_year.
BEWARE the time coordinate in the climatology file is not meaningful, but an artefact of iris processing- use day_of_year, year,month and day_of_month instead

SAMPLE PLOTTING CODE:

>mean_file='obs_NASATeam_historical_1_siextentWeddelldaily_mean_19912020.nc'
>sd_file='obs_NASATeam_historical_1_siextentWeddelldaily_sd_19912020.nc'
>full_file='obs_NASATeam_historical_1_siextentWeddelldaily.nc'
#
>import iris; import matplotlib.pyplot as plt
>sic_cube_2=iris.load_cube(data_dir+full_file)
>mean_climatol=iris.load_cube(data_dir+mean_file); sd_climatol=iris.load_cube(data_dir+sd_file)
>day_of_year=mean_climatol.coord('day_of_year').points
>chosen_yrs=[2013,2016,2020]
>plt.plot(day_of_year,mean_climatol.data,'k')
>for y in chosen_yrs:
>    cube_yr=cube_sia_2.extract(iris.Constraint(year=y))
>    plt.plot(day_of_year, cube_yr.data,label=str(y))
>plt.gca().set_xlabel('day of year')
>plt.gca().set_xlim([0,366])
>plt.gca().set_ylim([0,8])
>plt.legend()
>plt.show()
#


BEWARE: sea ice extent is a non-linear function of sea ice concentration. It is unwise to use these data to calculate monthly etc. averages, since the monthly mean of daily sea ice extents is NOT equal to the extent of the monthly mean sea ice concetnration.

Contact: Caroline Holmes calmes@bas.ac.uk

