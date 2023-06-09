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
filename = "/work1/jiajia1708/scripts/ncl_scripts/input/matlab_output_fittest.csv"

  str_array = asciiread(filename,-1,"string")
  values_2d = tofloat(str_split_csv(str_array,",",0))

  ureal  = values_2d(0,:)
  u1    = values_2d(1,:)
  u2  = values_2d(2,:)
  u_mv = values_2d(3,:)
;--------------------------------------PLOT CONTOUR----------------------------------------------
plotname = "err-prof-JJA-all"
wks = gsn_open_wks("pdf",plotname) ; 

res              = True
res@gsnDraw      =  False                   ; do not draw the plot
res@gsnFrame     =  False
res@tmYROn = False
res@tmXTOn = False
res@tmXBMinorOn = False
res@tmYLMinorOn = False
res@tmXBLabelFontHeightF = 0.015
res@tmYLLabelFontHeightF = 0.015

res@trYReverse   = False
res@xyLineThicknesses = 4

;-----------Set up the frame properties----------------------    
res@tiMainString  = "GNSS-RO Observation Error (global)"
res@tiYAxisString = "MSL Altitude (km)"
res@tiXAxisString = "Relative error (percentage)"
res@tiXAxisOffsetYF= -0.02
res@tiYAxisOffsetXF= -0.02

res@tiMainFontHeightF      = 0.018 
res@tiXAxisFontHeightF     = 0.015
res@tiYAxisFontHeightF     = 0.015
res@gsnMaximize  = True
res@trYMinF  = 0.0
res@trYMaxF  =  25
res@trXMinF  = -6
res@trXMaxF  =  1
res@xyLineThicknessF     = 5.0
res@tmXBMinorOn       =False
res@tmYLMinorOn       =False
res@tmXTOn            =False
res@tmYROn            =False
res@tmBorderThicknessF = 6
res@tmYLMajorThicknessF = 6
res@tmYLMinorThicknessF = 4
res@tmXBMajorThicknessF = 6
res@tmXBMinorThicknessF = 4

res@xyLineThicknesses  = 8
res1 = res
res1@pmLegendDisplayMode    = "Always"            ; turn on legend
res1@pmLegendSide           = "Top"               ; Change location of 
res1@pmLegendParallelPosF   = 0.24                  ; move units right
res1@pmLegendOrthogonalPosF = -0.3                ; move units down
res1@pmLegendWidthF         = 0.15                ; Change width and
res1@pmLegendHeightF        = 0.18                ; height of legend.
res1@lgPerimOn              = False               ; turn off box around
res1@lgLabelFontHeightF     = 0.015                 ; label font height
res1@xyExplicitLegendLabels = " Real Error "         ; create explicit labels
res1@xyLineColor   = "Blue" 

res2 = res
res2@pmLegendDisplayMode    = "Always"            ; turn on legend
res2@pmLegendSide           = "Top"               ; Change location of 
res2@pmLegendParallelPosF   = 0.245                 ; move units right
res2@pmLegendOrthogonalPosF = -0.36                ; move units down
res2@pmLegendWidthF         = 0.15                ; Change width and
res2@pmLegendHeightF        = 0.18                ; height of legend.
res2@lgPerimOn              = False               ; turn off box around
res2@lgLabelFontHeightF     = 0.015                 ; label font height
res2@xyExplicitLegendLabels = " LSW based"          ; create explicit labels
res2@xyLineColor = "Red"

res3 = res
res3@pmLegendDisplayMode    = "Always"             ; turn on legend
res3@pmLegendSide           = "Top"               ; Change location of 
res3@pmLegendParallelPosF   = 0.25                 ; move units right
res3@pmLegendOrthogonalPosF = -0.42                ; move units down
res3@pmLegendWidthF         = 0.15                ; Change width and
res3@pmLegendHeightF        = 0.18                ; height of legend.
res3@lgPerimOn              = False               ; turn off box around
res3@lgLabelFontHeightF     = 0.015                 ; label font height
res3@xyExplicitLegendLabels = " T Qv based "         ; create explicit labels
res3@xyLineColor   = "Violet" 

res4 = res
res4@pmLegendDisplayMode    = "Always"           ; turn on legend
res4@pmLegendSide           = "Top"               ; Change location of 
res4@pmLegendParallelPosF   = 0.20                 ; move units right
res4@pmLegendOrthogonalPosF = -0.48                ; move units down
res4@pmLegendWidthF         = 0.15                ; Change width and
res4@pmLegendHeightF        = 0.18                ; height of legend.
res4@lgPerimOn              = False               ; turn off box around
res4@lgLabelFontHeightF     = 0.015                 ; label font height
res4@xyExplicitLegendLabels = " MVE "         ; create explicit labels
res4@xyLineColor   = "Black" 

;-------------Draw plot---------------------------------------
plot1 = gsn_csm_xy(wks,ureal,values_2d(4,:),res1)
plot2 = gsn_csm_xy(wks,u1,values_2d(4,:),res2)
plot3 = gsn_csm_xy(wks,u2,values_2d(4,:),res3)
plot4 = gsn_csm_xy(wks,u_mv,values_2d(4,:),res4)
overlay (plot1, plot2)
overlay (plot1, plot3)
overlay (plot1, plot4)
draw(plot1)
frame(wks)

;-------------Draw plot---------------------------------------
system("mv "+plotname+".pdf"+" "+"/work1/jiajia1708/scripts/ncl_scripts/output-figures/")
print("========================================")
end

