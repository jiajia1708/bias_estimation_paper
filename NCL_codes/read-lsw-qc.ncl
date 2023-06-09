;;----------------------------------- 2D Cross-section of COSMIC2 data -----------------------------------------------;;
;; Distinguishing the high LSW profiles and move the good ones to new folder                     	     	          ;;
;; This is the second QC process										     										  ;;
;;                                                                           Written by Pham Gia Huan 2021/08/25      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

begin



;do i = 220, 226
;day =  sprinti("%0.3i", i)
;---------------------------------ADD FILES--------------------------------------

;dir1 = "/work1/jiajia1708/data/TACC/atmPrf/2020/2020."+day+"/"
dir1 = "/work1/jiajia1708/data/TACC/atmPrf/2020/allfiles/"
desDir = "/work1/jiajia1708/data/TACC/atmPrf/LSW-QC-2020/"
;dir2 = "/work1/jiajia1708/data/TACC/atmPrf/2020/2020."+day+"/"
dir2 = "/work1/jiajia1708/data/TACC/echPrf/2020/allfiles/"
;dir3 = "/work1/jiajia1708/data/TACC/wetPf2/QC-2020/"
files_a = systemfunc ("cd "+dir1+" ; ls *.0001_nc")
files_e = systemfunc ("cd "+dir2+" ; ls *.0001_nc")
;system ("cd "+desDir+" ; mkdir 2020."+day)
system ("cd "+desDir+" ; mkdir allfiles")
nfile_a = dimsizes(files_a)

do nf=0,nfile_a-1

	f1 = addfile(dir1+files_a(nf), "r") 	
	f2 = addfile(dir2+files_e(nf), "r")
	fr = addfile("/work1/jiajia1708/data/TACC/echPrf/2020/2020.153/C2E6.2020.153.23.57.G26_0001.0001_nc", "r")
	print(files_a(nf))
	
;---------------- Add variables -----------------------------------

	lsw = flt2dble(f1->Bend_ang_stdv(:))

	ba1 = f1->Bend_ang(:)
	
	z1 = f1->MSL_alt(:)
	zr = fr->MSL_alt(:)
	
	z1=z1(::-1)
	ba11 = ba1(::-1)
	lsw = lsw(::-1)
	
;----------------- QC ---------------------------------------------
	ba11n = linint1_n_Wrap(z1,ba11,False,zr,0,0)
	delete(ba11)
	delete(ba1)

	lswn = linint1_n_Wrap(z1,lsw,False,zr,0,0)/2
	delete(z1)
	delete(lsw)
	
	
	
	if(any(ismissing(lswn)) .or. any(ismissing(ba11n))) then print("found NaN lsw profile at "+files_a(nf))
	else
	qc_value = avg(100*lswn(0:19)/ba11n(0:19))
	print(qc_value)
		if 	(qc_value .lt. 35) then
		;system ("cd "+dir1+" ; ln "+files_a(nf)+" /work1/jiajia1708/data/TACC/atmPrf/LSW-QC-2020/2020."+day+"/")
		system ("cd "+dir1+" ; ln "+files_a(nf)+" /work1/jiajia1708/data/TACC/atmPrf/LSW-QC-2020/allfiles/")
		print("------------passed-------------")
		else print("found large lsw profile at "+files_a(nf))
		end if
	end if
	
	
		
end do

delete(files_a)
delete(files_e)
delete(nfile_a)


end
  