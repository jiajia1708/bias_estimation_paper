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
filename = "/work1/jiajia1708/scripts/ncl_scripts/input/matlab_output_fittest.csv"

  str_array = asciiread(filename,-1,"string")
  values_2d = tofloat(str_split_csv(str_array,",",0))
print(values_2d)
;--------------------------------------PLOT CONTOUR----------------------------------------------
plotname = "DeltaT_JJA_015" 
wks = gsn_open_wks("pdf",plotname) ; 
		   
		 res                     = True
		 res@tmYROn = False 
		 res@tmXTOn = False
		 res@tmXBMinorOn = False
		 res@tmYLMinorOn = False
		 ;res@tmXBLabelFontHeightF = 0.015
		 ;res@tmYLLabelFontHeightF = 0.015
		 
		 ;res@tiMainString  = "STD of OmB/B (Real), 0.3km, JJA 2020"
		 ;res@tiMainString  = "RO err (LSW estimate), 0.3km, JJA 2020"
		 ;res@tiMainString  =  "RO err (Tq estimate), 0.3km, JJA 2020"
		 ;res@tiMainString  =  "RO err (combine), 0.3km, JJA 2020"
		 res@tiMainString  =  "Delta T (C) between 850 and surface, 1.5km, JJA"
		 ;res@tiMainString  =  "Delta q (g/kg) between 850 and surface, 1.5km, JJA "
		 res@tiMainFontHeightF     = 0.018 
		 res@mpLimitMode       = "Corners"            ; choose range of map
		 res@mpLeftCornerLatF  = -40
		 res@mpLeftCornerLonF  = -180
		 res@mpRightCornerLatF = 48
		 res@mpRightCornerLonF = 180
		 


			res@cnLevelSelectionMode = "ManualLevels"
			
			;-------------------------
			res@cnMinLevelValF = -10.;-4
			res@cnMaxLevelValF = 2.;3.2;3.2;20 ;6
			;--------------------------
			;res@cnMinLevelValF = -6
			;res@cnMaxLevelValF = 2
			;--------------------------
			;res@cnLevelSpacingF = 0.2;1 ;0.4
			res@cnLevelSpacingF = 0.2;4;1 ;0.4
			
			;res@cnFillDrawOrder       = "PreDraw"         ; make sure fill map on top
		 ;map = gsn_csm_map(wks,res)
		 ;res@gsnMaximize         = True
		 res@cnLinesOn       	 = False
		 res@cnFillOn            = True        ; Turn on contour fill
		 res@cnFillPalette        = "cmp_b2r"             ; set color map
	     cmap    = read_colormap_file("cmp_b2r")     ; 16 x 4
  		 ncolors = dimsizes(cmap(:,0))            ; 16
		 res@cnFillPalette := cmap      ; Use modified RGB/A array
	     res@cnMaxLevelCount = ncolors-1       ; make sure NCL chooses 15 or fewer contour levels
		 res@cnFillMode = "RasterFill"
		 res@cnLinesOn = False
		 
		 ;---------------------------------------------
		 
		 
		 ;---------------------------------------------
		 ;cmap = read_colormap_file("GMT_polar")
		 ;res@cnFillColors = cmap(::1,:)
		 ;---------------------------------------------
 
		 res@cnMissingValFillColor = "black"
		 res@cnOutOfRangeFillColor = "black"
		 res@cnRasterSmoothingOn = True
		 plot = gsn_csm_contour_map(wks,values_2d,res)
		 
system("mv "+plotname+".pdf"+" "+"/work1/jiajia1708/scripts/ncl_scripts/output-figures/")
print("========================================")
end
