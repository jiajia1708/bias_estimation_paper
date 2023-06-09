;;----------------------------------- 2D Cross-section of COSMIC2 data -----------------------------------------------;;
;; This code is to calculate the 2D-variables of COSMIC2 (Originally only 1D)               				          ;;
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
;filename = "/work1/jiajia1708/scripts/ncl_scripts/input/plot_fittest_3_residual_combine.csv"
;filename = "/work1/jiajia1708/scripts/ncl_scripts/input/plot_fittest_3_yhat_combine.csv"
;filename = "/work1/jiajia1708/scripts/ncl_scripts/input/plot_fittest_1_yhat_Tq.csv"
;filename = "/work1/jiajia1708/scripts/ncl_scripts/input/plot_fittest_1_yhat_LSW.csv"
filename = "/work1/jiajia1708/scripts/ncl_scripts/input/plot_output_matlab_fittest.csv"


  str_array = asciiread(filename,-1,"string")
  values_2d = tofloat(str_split_csv(str_array,",",0))
  stdv      = abs(dim_rmvmean(values_2d))
print(stdv)
;--------------------------------------PLOT CONTOUR----------------------------------------------
plotname = "fittest_6_yhat_combine_JJA_stdv"
wks = gsn_open_wks("pdf",plotname) ; 
		 
		 res                     = True
		 res@tmYROn = False   
		 res@tmXTOn = False
		 res@tmXBMinorOn = False
		 res@tmYLMinorOn = False
		 ;res@tmXBLabelFontHeightF = 0.015
		 ;res@tmYLLabelFontHeightF = 0.015
		 
		 ;res@tiMainString  = "Standard deviation (N STDV) of estimated RO (T and q based), 3 to 5km, Jun - Aug"
		 res@tiMainString  = "Standard deviation (N STDV) of estimated RO (combine), 5 to 7km, Jun - Aug"
		 ;res@tiMainString  = "Standard deviation (N STDV) of estimated RO (T and q based), 1.5 to 3km, Jun - Aug"
		 ;res@tiMainString  = "Standard deviation (N STDV) of estimated RO (combine), 3 to 5km, Jun - Aug"
		 ;res@tiMainString  = "Standard deviation (N STDV) of real RO error, 5 to 7km, Jun - Aug"
		 ;res@tiMainString  = "LSW/2 (in percentage),0 to 1.5km, Jun - Aug"
		 ;res@tiMainString  = "7 to 10km (in percentage): REFerror(fit) - REFerror "
		 
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
			;-------------------------
			;res@cnMinLevelValF = -6.5;-4
			;res@cnMaxLevelValF = 1;3.2;3.2;20 ;6
			;--------------------------
			res@cnMinLevelValF = 0;3.6E-05
			res@cnMaxLevelValF = 2;0.08
			;--------------------------
			;res@cnLevelSpacingF = 0.2;1 ;0.4
			res@cnLevelSpacingF = 0.25;1 ;0.4
		 ;map = gsn_csm_map(wks,res)
		 ;res@gsnMaximize         = True
		 res@cnLinesOn       	 = False
		 res@cnFillOn            = True        ; Turn on contour fill
		 res@cnFillMode = "RasterFill"
		 
		 ;---------------------------------------------
		 cmap = read_colormap_file("sunshine_9lev")
		  res@cnFillColors = cmap(::1,:)
		 ;---------------------------------------------
		 ;cmap = read_colormap_file("GMT_polar")
		 ;res@cnFillColors = cmap(::1,:)
		 ;---------------------------------------------
 
		 res@cnMissingValFillColor = "black"
		 res@cnOutOfRangeFillColor = "black"
		 res@cnRasterSmoothingOn = True
		 plot = gsn_csm_contour_map(wks,stdv,res)
		 
system("mv "+plotname+".pdf"+" "+"/work1/jiajia1708/scripts/ncl_scripts/output-figures/")
print("========================================")
end
