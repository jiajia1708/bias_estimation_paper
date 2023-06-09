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
dir2 = "/work1/jiajia1708/data-2/TACC/echPrf/2020/allfiles/"
dir3 = "/work1/jiajia1708/data-2/TACC/wetPf2/QC-2020/allfiles/" 
;dir1 = "/work1/jiajia1708/data/TACC/atmPrf/2020/allfiles/"
;dir2 = "/work1/jiajia1708/data/TACC/echPrf/2020/allfiles/"
;dir3 = "/work1/jiajia1708/data/TACC/wetPf2/QC-2020/allfiles/"
;dir1 = "/work1/jiajia1708/data/TACC/atmPrf/2020/all-oceans/"
;dir2 = "/work1/jiajia1708/data/TACC/echPrf/2020/all-oceans/"
;dir3 = "/work1/jiajia1708/data/TACC/wetPf2/QC-2020/all-oceans/"
;dir1 = "/work1/jiajia1708/data/TACC/atmPrf/2020/all-lands/"
;dir2 = "/work1/jiajia1708/data/TACC/echPrf/2020/all-lands/"
;dir3 = "/work1/jiajia1708/data/TACC/wetPf2/QC-2020/all-lands/"

dirx ="/work1/jiajia1708/scripts/ncl_scripts"
setfileoption("nc", "Format",  "NetCDF4")

fn = "/work1/jiajia1708/data/TACC/echPrf/2020/2020.153/C2E6.2020.153.23.57.G26_0001.0001_nc"
fr = addfile(fn, "r")


files_a = systemfunc ("cd "+dir1+" ;ls *.0001_nc")
files_e = systemfunc ("cd "+dir2+" ;ls *.0001_nc")
files_w = systemfunc ("cd "+dir3+" ;ls *.0001_nc") 
nfile_a = dimsizes(files_a)

refOmB = new((/67,nfile_a/), double)
baOmB  = new((/67,nfile_a/), double)
lswPctg = new((/67,nfile_a/), double)
Lat     = new((/67,nfile_a/), double)
Lon     = new((/67,nfile_a/), double)
Temp1    = new((/67,nfile_a/), double)
Temp2    = new((/67,nfile_a/), double)
sph     = new((/67,nfile_a/), double)
time    = new((/67,nfile_a/), double)
;---Add variables

Prof_num = ispan (1,nfile_a,1)
MSL_alt = fr->MSL_alt(0:66)	

do nf=0,nfile_a-1
    f1          = addfile(dir1+files_a(nf), "r") 
    f2          = addfile(dir2+files_e(nf), "r")
    f3          = addfile(dir3+files_w(nf), "r")

	z1          = flt2dble(f1->MSL_alt)
    z2          = f2->MSL_alt
	z3          = f3->MSL_alt
    
    ba          = f1->Bend_ang
	ba2         = f2->Bend_ang

	ref         = flt2dble(f1->Ref)
	ref2        = f2->Ref
	ref3        = f3->ref
		
	temp        = flt2dble(f3->Temp)
	temp2       = f2->Temp

	lat         = flt2dble(f1->Lat)
    

    lon         = flt2dble(f1->Lon)

    lsw         = flt2dble(f1->Bend_ang_stdv)	

    pres        = flt2dble(f3->Pres)
	vp          = flt2dble(f3->Vp)
	
	attname = "hour"     
	hour = fr@$attname$
		
		
;---Calculation of variables
	z1 = z1(::-1)
	lsw = lsw(::-1)
	ba = ba(::-1)
	ref = ref(::-1)	
    lat = lat(::-1)	
    lon = lon(::-1)	
    temp = temp(::-1) 

	ban = linint1_n_Wrap(z1,ba,False,MSL_alt,0,0)
	delete(ba)
	ba2n = linint1_n_Wrap(z2,ba2,False,MSL_alt,0,0)
	delete(ba2)
	 

	ba_omb      = ban(0:66)-ba2n(0:66)

    refn        = linint1_n_Wrap(z1,ref,False,MSL_alt,0,0)
	delete(ref)
	ref2n       = linint1_n_Wrap(z2,ref2,False,MSL_alt,0,0)
	delete(ref2)
	;ref3n      = linint1_n_Wrap(z3,ref3,False,MSL_alt,0,0)
	delete(ref3)
	ref_omb         = refn(0:66) - ref2n(0:66)
 
    lswn        = linint1_n_Wrap(z1,lsw,False,MSL_alt,0,0)/2
	lsw_percent = 100*lswn/where(ban.ne.0, ban, ban@_FillValue)
	ref_qc      = avg(refn(0:66))
	delete(lsw)

    latn        = linint1_n_Wrap(z1,lat,False,MSL_alt,0,0)
	delete(lat)

    lonn        = linint1_n_Wrap(z1,lon,False,MSL_alt,0,0)

    tempn      = linint1_n_Wrap(z3,temp,False,MSL_alt,0,0)
    delete(temp)
    T1 = tempn
    temp2n      = linint1_n_Wrap(z2,temp2,False,MSL_alt,0,0)
    delete(temp2)
    T2 = temp2n
	e = abs(linint1_n_Wrap(z3,vp,False,MSL_alt,0,0))
	delete(vp)
	p = abs(linint1_n_Wrap(z3,pres,False,MSL_alt,0,0))
	delete(pres)
	;wetrh = abs(linint1_n_Wrap(z3,wetrhraw,False,zr,0,0))
	;delete(wetrhraw)
	;----Saturation Vapor Pressure es
	a= 17.2693882
	b= 35.86
	es = 6.1078*exp((a*T1)/((T1+273.16)-b))	
	q = 1000*(0.622*e)/(p-0.378*e)							  ;    value of specific humidity
	delete(lon)
    delete(z1)
    delete(z2) 
    delete(z3)
    

    refOmB(:,nf) = ref_omb
    baOmB(:,nf)  = ba_omb
    lswPctg(:,nf) = lsw_percent
    Lat(:,nf)     = latn
    Lon(:,nf)     = lonn
    Temp2(:,nf)    = T2
    Temp1(:,nf)    = T1
    sph(:,nf)     = q
    time(:,nf)      = hour
    delete(temp2n)
end do 

;---Get dimension sizes

    var_type    = "double"
    nMSL_alt    = dimsizes(MSL_alt)
    nlat        = dimsizes(Lat) 
    nlon        = dimsizes(Lon)
    nProf_num   = dimsizes(Prof_num)
    nrefPctg    = dimsizes(refOmB)
    nbaPctg     = dimsizes(baOmB) 
    ntime        = dimsizes(time) 

;---Open a new NetCDF file to write to 
    setfileoption("nc", "Format",  "NetCDF4")
    fon = "JFM_recal3_omb.nc"
    system("/bin/rm -f " + fon) ; remove if exists
    fo = addfile(fon, "c")

    setfileoption(fo,"DefineMode",True)
    fAtt               = True            ; assign file attributes
    fAtt@title         = "FS7 recalculated dataset for JJA"
    fAtt@source_file   = fn
    fAtt@Conventions   = "None"
    fAtt@creation_date = systemfunc ("date")
    fileattdef(fo, fAtt)      ; copy file attributes

;---Define the dimension names and their sizes on the file 
    dimNames = (/ "MSL_alt", "Prof_num"/)  
	dimSizes = (/ nMSL_alt , nProf_num/) 
	dimUnlim = (/ False, False /)   
	filedimdef(fo,dimNames,dimSizes,dimUnlim) 
 
    value = new((/nMSL_alt, nProf_num/), double)
    value@name = "value"
    value!0 = "MSL_alt"
    value!1 = "Prof_num"

    value2 = new((/nProf_num/), double)
    value@name = "value"
    value2!0 = "Prof_num"
    
;---Define each variable, its type, its dimension names, and its size
    filevardef(fo, "MSL_alt"  ,typeof(MSL_alt),getvardims(MSL_alt))
    filevardef(fo, "Lat"  ,typeof(value),getvardims(value))
    filevardef(fo, "Lon"  ,typeof(value),getvardims(value))
    filevardef(fo, "Prof_num"  ,typeof(Prof_num),getvardims(Prof_num))
    filevardef(fo, "refOmB" ,typeof(value),getvardims(value)) 
    filevardef(fo, "baOmB" ,typeof(value),getvardims(value)) 
    filevardef(fo, "lswPctg" ,typeof(value),getvardims(value)) 
    filevardef(fo, "sph" ,typeof(value),getvardims(value))
    filevardef(fo, "Temp1" ,typeof(value),getvardims(value))
    filevardef(fo, "Temp2" ,typeof(value),getvardims(value))
    filevardef(fo, "time" ,typeof(value2),getvardims(value2))

;---Define each variable's attributes
    filevarattdef(fo,"MSL_alt",MSL_alt)
    filevarattdef(fo,"Lat",Lat)
    filevarattdef(fo,"Lon",Lon)
    filevarattdef(fo,"Prof_num",Prof_num)
    filevarattdef(fo,"baOmB",baOmB)
    filevarattdef(fo,"lswPctg",lswPctg)
    filevarattdef(fo,"sph",sph)
    filevarattdef(fo,"Temp1",Temp1)
    filevarattdef(fo,"Temp2",Temp2)
    filevarattdef(fo,"time",time)

;---NOW write the variables to the file.
    fo->MSL_alt  = (/MSL_alt/)
    fo->Prof_num  = (/Prof_num/)
    fo->Lat  = (/Lat/)
    fo->Lon  = (/Lon/)
    fo->refOmB  = (/refOmB/)
    fo->baOmB  = (/baOmB/)
    fo->lswPctg  = (/lswPctg/)
    fo->sph  = (/sph/)
    fo->Temp1  = (/Temp1/)
    fo->Temp2  = (/Temp2/)
    fo->time  = (/time/)
end