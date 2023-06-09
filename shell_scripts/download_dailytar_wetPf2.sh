#/bin/sh     ###### for 201 ######
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
#Date_init=335
#Date_last=365

Date_init=335
Date_last=365
rawDir= /work1/jiajia1708/data-2/TACC/wetPf2/2020/
website=http://tacc.cwb.gov.tw/data-service/fs7rt_tdpc/daily_tar

while [ $Date_init -le $Date_last ]; do
   echo " Downloading COSMIC2 wetPf2 Observation @ ${Date_year}.$( printf "%03d" ${Date_init}) "
   file="wetPf2_${Date_year}.$( printf "%03d" ${Date_init}).tar.gz "
   wget -L ${website}/${Date_year}.$( printf "%03d" ${Date_init})/${file}
   mv ${file} /work1/jiajia1708/data-2/TACC/wetPf2/2020/

Date_init=` expr $( printf "%03d" ${Date_init}) + 1 `
done
