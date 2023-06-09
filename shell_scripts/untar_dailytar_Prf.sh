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
Obstype='wetPf2' # choose atmPrf or echPrf or wetPrf
rawDir='/SAS005/jiajia1708/TACC/wetPf2/2020'
while [ ${Date_init} -le ${Date_last} ]; do
   echo "Untar COSMIC2 ${Obstype} observation @ $wetPf2_${Date_year}.$( printf "%03d" ${Date_init}) "
   if [ $Obstype == 'wetPf2' ]; then 
      file=${rawDir}/wetPf2_${Date_year}.$( printf "%03d" ${Date_init}).tar.gz
   elif [ $Obstype == 'atmPrf' ]; then 
      file=${rawDir}/atmPrf_${Date_year}.$( printf "%03d" ${Date_init}).tar.gz
   fi

   mkdir ${rawDir}/${Date_year}.$( printf "%03d" ${Date_init})
   echo "  ${file}"
   cd ${rawDir}/
   tar -xzvf wetPf2_${Date_year}.$( printf "%03d" ${Date_init}).tar.gz -C ${Date_year}.$( printf "%03d" ${Date_init})

   Date_init=` expr $( printf "%03d" ${Date_init}) + 1 `
done
