;;----------------------------------- 2D Cross-section of COSMIC2 data -----------------------------------------------;;
;; This code is to calculate the 2D-variables of COSMIC2 (Originally only 1D)               				          ;;
;; The main ideas is to separate the whole lat refPtgues into boxes, then sort the files into those boxes				  ;;
;;                                                                           Written by Pham Gia Huan 2021/02/20      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

begin

;do i = 2, 2
;day =  sprinti("%0.3i", i)
;---------------------------------ADD FILES--------------------------------------
filename = "/work1/jiajia1708/scripts/ncl_scripts/input/matlab_output.csv"

  str_array = asciiread(filename,-1,"string")
  values_2d = tofloat(str_split_csv(str_array,",",0))
print(values_2d)
		
;--------------------------------------PLOT CONTOUR----------------------------------------------
plotname = "2d-t-land-z-ref-DJF" 
wks = gsn_open_wks("png",plotname) ; 
 
  res                     = True

  res@tmYROn = False
  res@tmXTOn = False
  res@tmXBMinorOn = False
  res@tmYLMinorOn = False
  res@tmXBLabelFontHeightF = 0.015
  res@tmYLLabelFontHeightF = 0.015
  res@tiMainString  = "Refractivity bias as the function of temperature (Land)"
  res@tiYAxisString = "MSL Altitude (km)"

  res@tiMainFontHeightF      = 0.018 
  res@tiXAxisFontHeightF     = 0.015
  res@tiYAxisFontHeightF     = 0.015
  res@gsnRightString       = " "
  res@gsnMaximize  = True



  res@tmXBMode   = "Explicit"  			; explicitly set Y-axis labels
  res@tiXAxisString = "Temperature (degree C)"
  res@tmXBValues = (/"0","7.5","15","22.5","29"/)
  res@tmXBLabels = (/"15","17.5","20","22.5","25"/)
  

  res@tmYLMode   = "Explicit"  			; explicitly set Y-axis labels
  res@tmYLValues = (/"0","13.4","26.8","40.2","53.6","66"/)
  res@tmYLLabels = (/"0","5","10","15","20","25"/)

  res@cnLevelSelectionMode = "ManualLevels"
  ;-------------------------
  res@cnMinLevelValF = -16;-4
  res@cnMaxLevelValF = 4 ;3.2;3.2;20 ;6
  res@cnLevelSpacingF = 2;1 ;0.4

  res@cnLinesOn = True
  res@lbOrientation       = "vertical"
  res@gsnMaximize         = True
  res@cnFillOn            = True        ; Turn on contour fill
  
  gsn_define_colormap(wks,"MPL_RdYlBu" )
  ;gsn_reverse_colormap(wks)           ; Reverse the color map.
plot = gsn_csm_contour(wks,values_2d,res)

system("mv "+plotname+".png"+" "+"/work1/jiajia1708/scripts/ncl_scripts/output-figures/")
end
