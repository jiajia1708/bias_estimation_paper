;;----------------------------------- 2D Cross-section of COSMIC2 data -----------------------------------------------;;
;; This code is to plot the 2D-variables of COSMIC2 (Originally only 1D)               				          		  ;;
;; The main ideas is to separate the whole lat values into boxes, then sort the files into those boxes				  ;;
;;                                                                           Written by Pham Gia Huan 2021/02/20      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

begin

;do i = 2, 2
;day =  sprinti("%0.3i", i)
;---------------------------------ADD FILES--------------------------------------
filename = "/work1/jiajia1708/scripts/ncl_scripts/input/numberprofs_residual_latlon_015_JJA_LSWREFmap.csv"

  str_array = asciiread(filename,-1,"string")
  values_2d = tofloat(str_split_csv(str_array,",",0))
print(values_2d)
;--------------------------------------PLOT CONTOUR----------------------------------------------
plotname = "Numprof-JJA"
wks = gsn_open_wks("pdf",plotname) ; 
		 
		 res                     = True
		 res@tmYROn = False
		 res@tmXTOn = False
		 res@tmXBMinorOn = False
		 res@tmYLMinorOn = False
		 ;res@tmXBLabelFontHeightF = 0.015
		 ;res@tmYLLabelFontHeightF = 0.015
		 

		 res@tiMainString  = "Profile density of COSMIC-2 RO data from June to August 2020 (unit: profile)"
		 ;res@tiMainString  = "Number of profiles counted for LSW-filtered data"
		 
		 ;res@tiXAxisString = "Lon"
		 ;res@tiYAxisString = "Lat"

		 res@mpLimitMode       = "Corners"            ; choose range of map
		 res@mpLeftCornerLatF  = -40
		 res@mpLeftCornerLonF  = -180
		 res@mpRightCornerLatF = 48
		 res@mpRightCornerLonF = 180
		 

		 ;res@tiMainFontHeightF      = 0.018 
		 ;res@tiXAxisFontHeightF     = 0.015
		 ;res@tiYAxisFontHeightF     = 0.015
		; res@gsnMaximize  = True

		  ;res@tmXBMode   = "Explicit"  			; explicitly set Y-axis labels
		  ;res@tmXBValues = (/"0","6","12","18","24","30","36","42","47"/)
		  ;res@tmXBLabels = (/"48S","36S","24S","12S","0","12N","24N","36N","48N"/)
		  ;res@tmYLMode   = "Explicit"  			; explicitly set Y-axis labels
		  ;res@tmYLValues = (/"0","4.4","8.8","13.2","17.6","22","26.4","30.8","35"/)
		  ;res@tmYLLabels = (/"0","1.25","2.5","3.75","5.00","6.25","7.5","8.75","10"/)
		  
			res@cnLevelSelectionMode = "ManualLevels"
			res@cnMinLevelValF = 0
			res@cnMaxLevelValF = 600
			res@cnLevelSpacingF = 50
		 ;map = gsn_csm_map(wks,res)
		 ;res@gsnMaximize         = True
		 res@cnLinesOn       	 = False
		 res@cnFillOn            = True        ; Turn on contour fill
		 res@cnFillMode = "RasterFill"
		 res@cnFillPalette       = "WhiteBlueGreenYellowRed"
		 ;res@cnRasterSmoothingOn = True
		 plot = gsn_csm_contour_map(wks,values_2d,res)
		 
system("mv "+plotname+".pdf"+" "+"/work1/jiajia1708/scripts/ncl_scripts/output-figures/")
print("========================================")
end
