#/bin/sh     ###### for 201 ######
#-----------------------------------------------------------------------
# PURPOSE:
#     Untar COSMIC2 observation
#
#-----------------------------------------------------------------------
# Wirtten by CHIHCHIEN CHANG
#
# Feb 2020              v1.0.0 Released
#----------------------------------------------------------------------
#======================================================================
Date_year=2019
Date_init=335
Date_last=365
Obstype='atmPrf' # choose atmPrf or echPrf or wetPrf
rawDir='/SAS004/jiajia1708/TACC'
while [ ${Date_init} -le ${Date_last} ]; do
   echo "Untar COSMIC2 ${Obstype} observation @ ${Date_year}.${Date_init} "
   if [ $Obstype == 'echPrf' ]; then 
      file=${rawDir}/${Obstype}/${Date_year}/echPrf_${Date_year}.${Date_init}.tar.gz
   elif [ $Obstype == 'atmPrf' ]; then 
      file=${rawDir}/${Obstype}/${Date_year}/atmPrf_${Date_year}.${Date_init}.tar.gz
   fi

   mkdir ${rawDir}/${Obstype}/${Date_year}/${Date_year}.${Date_init}
   echo "  ${file}"
   tar -zxf ${file} -C ${rawDir}/${Obstype}/${Date_year}/${Date_year}.${Date_init}


   Date_init=` expr $Date_init + 1 `
done
