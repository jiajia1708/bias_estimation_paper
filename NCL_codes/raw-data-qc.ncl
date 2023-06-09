;;----------------------------------- 2D Cross-section of COSMIC2 data -----------------------------------------------;;
;; Distinguishing the bad QC flags in profiles and move the good ones to new folder               	     	          ;;
;; This is the very first QC process																				  ;;
;;                                                                           Written by Pham Gia Huan 2021/03/28      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

begin



do i = 335, 365
day =  sprinti("%0.3i", i)
;---------------------------------ADD FILES--------------------------------------

;dir1 = "/mnt/e/Linux_Env/home/JiaJia/datalib/TACC/atmPrf/2020/2020."+day+"/"
;dir1 = "/work1/jiajia1708/data-2/TACC/atmPrf/2020/2019."+day+"/"
dir1 = "/work1/jiajia1708/data-2/TACC/wetPf2/2020/2019."+day+"/"

;desDir = "/mnt/e/Linux_Env/home/JiaJia/datalib/TACC/atmPrf/QC-2020/"
;desDir = "/work1/jiajia1708/data-2/TACC/atmPrf/2020/allfiles/"
desDir = "/work1/jiajia1708/data-2/TACC/wetPf2/2020/allfiles/"

files_a = systemfunc ("cd "+dir1+" ; ls *.0001_nc")
;files_e = systemfunc ("cd "+dir2+" ; ls *.0001_nc")
;system ("cd "+desDir+" ; mkdir 2020."+day)
system ("cd "+desDir)
nfile_a = dimsizes(files_a)

do nf=0,nfile_a-1
	f = addfile(dir1+files_a(nf), "r") 
	print(files_a(nf))
	attname = "bad"     
	qc_value = f@$attname$
	print(qc_value)
	if 	(qc_value .eq. 0) then
	system ("cd "+dir1+" ; cp "+files_a(nf)+" /work1/jiajia1708/data-2/TACC/wetPf2/2020/allfiles/")
	;system ("rm"+files_a(nf))
	else print("found bad profile at "+files_a(nf))
	end if
		
end do


end do 

end
  