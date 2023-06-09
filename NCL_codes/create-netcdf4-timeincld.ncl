;;----------------------------------- 2D Cross-section of COSMIC2 data -----------------------------------------------;;
;; This code is to create net-cdf4 files for data extracted from FS7 for efficient works       				          ;;
;;                                                                                                     				  ;;
;;                                                                           Written by Pham Gia Huan 2022/01/12      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

begin


;---------------------------------ADD FILES--------------------------------------
dir1 = "/work1/jiajia1708/data-2/TACC/atmPrf/2020/allfiles/"
;dir2 = "/work1/jiajia1708/data-2/TACC/echPrf/2020/allfiles/"
;dir3 = "/work1/jiajia1708/data-2/TACC/wetPf2/QC-2020/allfiles/"

;dir1 = "/work1/jiajia1708/data/TACC/atmPrf/2020/allfiles/"
;dir2 = "/work1/jiajia1708/data/TACC/echPrf/2020/allfiles/"
;dir3 = "/work1/jiajia1708/data/TACC/wetPf2/QC-2020/allfiles/"

;dir1 = "/work1/jiajia1708/data/TACC/atmPrf/2020/all-oceans/"
;dir2 = "/work1/jiajia1708/data/TACC/echPrf/2020/all-oceans/"
;dir3 = "/work1/jiajia1708/data/TACC/wetPf2/QC-2020/all-oceans/"

;dir1 = "/work1/jiajia1708/data/TACC/atmPrf/2020/all-lands/"
;dir2 = "/work1/jiajia1708/data/TACC/echPrf/2020/all-lands/"
;dir3 = "/work1/jiajia1708/data/TACC/wetPf2/QC-2020/all-lands/"


fn = "/work1/jiajia1708/data/TACC/echPrf/2020/2020.153/C2E6.2020.153.23.57.G26_0001.0001_nc"
fr = addfile(fn, "r")

;dir1 = "/work1/jiajia1708/data/TACC/atmPrf/2020/all-lands/"
;dir2 = "/work1/jiajia1708/data/TACC/echPrf/2020/all-lands/"
;dir3 = "/work1/jiajia1708/data/TACC/wetPf2/QC-2020/all-lands/"

;dirx ="/work1/jiajia1708/scripts/ncl_scripts" 
;setfileoption("nc", "Format",  "NetCDF4")

files_a = systemfunc ("cd "+dir1+" ;ls *.0001_nc")

nfile_a = dimsizes(files_a)

time    = new((/nfile_a/), double)
;---Add variables

Prof_num = ispan (1,nfile_a,1)
MSL_alt = fr->MSL_alt(0:66)	

do nf=0,nfile_a-1
	f1          = addfile(dir1+files_a(nf), "r") 

	attname = "hour"     
	hour = f1@$attname$

	time(nf)      = hour

    delete(hour)
    delete(f1)
end do 

;---Get dimension sizes
 
    var_type    = "double"
    timedim     = dimsizes(time) 
    nProf_num   = dimsizes(Prof_num)
    
;---Open a new NetCDF file to write to 
    setfileoption("nc", "Format",  "NetCDF4")
    fon = "JFM_time.nc"
    system("/bin/rm -f " + fon) ; remove if exists
    fo = addfile(fon, "c")

    setfileoption(fo,"DefineMode",True)
    fAtt               = True            ; assign file attributes
    fAtt@title         = "FS7 recalculated time dataset for JFM"
    fAtt@source_file   = fn
    fAtt@Conventions   = "None"
    fAtt@creation_date = systemfunc ("date")
    fileattdef(fo, fAtt)      ; copy file attributes

;---Define the dimension names and their sizes on the file 
    dimNames = (/"Prof_num"/)  
	dimSizes = (/nProf_num/) 
	dimUnlim = (/False/)   
	filedimdef(fo,dimNames,dimSizes,dimUnlim) 
 
    value = new((/nProf_num/), double)
    value@name = "value"
    value!0 = "Prof_num"
    
;---Define each variable, its type, its dimension names, and its size

    filevardef(fo, "Prof_num"  ,typeof(Prof_num),getvardims(Prof_num))
    filevardef(fo, "time" ,typeof(value),getvardims(value))


;---Define each variable's attributes

    filevarattdef(fo,"Prof_num",Prof_num)
    filevarattdef(fo,"time",time)
 
;---NOW write the variables to the file.

    fo->Prof_num  = (/Prof_num/)
    fo->time  = (/time/)
end