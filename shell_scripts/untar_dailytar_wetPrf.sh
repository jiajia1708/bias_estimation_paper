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
Obstype='wetPf2' # choose atmPrf or echPrf or wetPf2
rawDir='/work1/jiajia1708/data-2/TACC/'
while [ ${Date_init} -le ${Date_last} ]; do
   echo "Untar COSMIC2 ${Obstype} observation @ ${Date_year}.$(printf "%03d" $Date_init) "
   if [ $Obstype == 'echPrf' ]; then 
      file=${rawDir}/${Obstype}/2020/echPrf_${Date_year}.$(printf "%03d" $Date_init).tar.gz
   elif [ $Obstype == 'atmPrf' ]; then 
      file=${rawDir}/${Obstype}/2020/atmPrf_${Date_year}.$(printf "%03d" $Date_init).tar.gz
   elif [ $Obstype == 'wetPf2' ]; then 
      file=${rawDir}/${Obstype}/2020/wetPf2_${Date_year}.$(printf "%03d" $Date_init).tar.gz
   fi

   mkdir ${rawDir}/${Obstype}/2020/${Date_year}.$(printf "%03d" $Date_init)
   echo "  ${file}"
   tar -zxvf ${file} -C ${rawDir}/${Obstype}/2020/${Date_year}.$(printf "%03d" $Date_init)


   Date_init=` expr $Date_init + 1 `
done 
