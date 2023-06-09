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
plotname = "2d-lat-z-temp-JFM" 
wks = gsn_open_wks("pdf",plotname) ; 
 
  res                     = True

  res@tmYROn = False
  res@tmXTOn = False
  res@tmXBMinorOn = False
  res@tmYLMinorOn = False
  res@tmXBLabelFontHeightF = 0.015
  res@tmYLLabelFontHeightF = 0.015
  res@tiMainString  = "Cross-section of Temperature (JFM)"
  res@tiYAxisString = "MSL altitude (km)"

  res@tiMainFontHeightF      = 0.018 
  res@tiXAxisFontHeightF     = 0.015
  res@tiYAxisFontHeightF     = 0.015
  res@gsnMaximize  = True

  res@tmXBMode   = "Explicit"  			; explicitly set Y-axis labels
  res@tmXBValues = (/"0","6","12","18","24","30","36","42","47"/)
  res@tmXBLabels = (/"48S","36S","24S","12S","0","12N","24N","36N","48N"/)
  res@tmYLMode   = "Explicit"  			; explicitly set Y-axis labels
  res@tmYLValues = (/"0","6","12","18","24","30","36","42","48","54","60","66"/)
  res@tmYLLabels = (/"0","2.3","4.6","6.9","9.2","11.5","13.8","16.1","18.4","20.7","23","25.3"/)

  res@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
  res@cnLevels    = (/0,2,4,6,8,10,12,14,16/)   ; set levels

  res@gsnMaximize         = True
  res@cnFillOn            = True        ; Turn on contour fill
  
  gsn_define_colormap(wks,"MPL_RdYlBu" )
  gsn_reverse_colormap(wks)           ; Reverse the color map.
plot = gsn_csm_contour(wks,values_2d,res)

system("mv "+plotname+".pdf"+" "+"/work1/jiajia1708/scripts/ncl_scripts/output-figures/")
end
