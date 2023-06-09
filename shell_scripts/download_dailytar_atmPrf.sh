#/bin/sh     ###### for 201 ######
#-----------------------------------------------------------------------
# PURPOSE:
#     Download the COSMIC2 atmPrf observation from tacc
#-----------------------------------------------------------------------
# Written by CHIHCHIEN CHANG
#
# Feb. 2019              v1.0.0 Released
#======================================================================
Date_year=2019
#Date_init=153
#Date_last=224

Date_init=335
Date_last=365
rawDir= /work1/jiajia1708/data-2/TACC/atmPrf/2020/
website=http://tacc.cwb.gov.tw/data-service/fs7rt_tdpc/daily_tar/

while [ $Date_init -le $Date_last ]; do
   echo " Downloading COSMIC2 atmPrf Observation @ ${Date_year}.$(printf "%03d" $Date_init) "
   file="atmPrf_${Date_year}.$(printf "%03d" $Date_init).tar.gz "
   wget ${website}/${Date_year}.$(printf "%03d" $Date_init)/${file}
   mv ${file} /work1/jiajia1708/data-2/TACC/atmPrf/2020/

Date_init=` expr $Date_init + 1 `
done
