#!/bin/sh
# This code is to remove all the bad wetPf2 files and move the good files to another dir
# Written by Pham Gia Huan 01/24/2021

sourceDir=/mnt/e/Linux_Env/home/JiaJia/datalib/TACC/wetPf2/2020
desDir=/mnt/e/Linux_Env/home/JiaJia/datalib/TACC/wetPf2/QC-2020

for (( Julian_day=001 ; Julian_day <= 182 ; Julian_day=Julian_day+1 )); do
   
      #echo "$( printf "%03d" ${Julian_day})" 
	  echo "executing in "$desDir" "
	  cd $desDir
	  mkdir 2020.$( printf "%03d" ${Julian_day})
      rawDataDir=${sourceDir}/2020.$( printf "%03d" ${Julian_day})
	  rawDesDir=${desDir}/2020.$( printf "%03d" ${Julian_day})
      cd $rawDataDir
      echo "Working in $rawDataDir" 
      
      #echo "$fileList"
		a=1
			#for file in ` ls *.0001_nc `; do
		#for file in ` ls *nc `; do
		#newfilename=$(printf "trim_atmPrf"_"$(printf "%05d" ${a})".nc)
			#mv -- "$file" "${file%.0001_nc}.nc"						# This is for modifying the format .0001_nc to .nc
			#echo "mv -- "$file" "${file%.0001_nc}.nc""
			find . -size +150 -print -exec ln -s /mnt/e/Linux_Env/home/JiaJia/datalib/TACC/wetPf2/QC-2020/2020.$( printf "%03d" ${Julian_day}) {} +
			cd $desDir
			
			echo "============== done in "$desDir" ==================="
			let a=a+1
done

		
		