;;----------------------------------- 2D Cross-section of COSMIC2 data -----------------------------------------------;;
;; This code is to plot the average refractivity profiles and bending angles with LSW/2               				  ;;
;;                                                                           Written by Pham Gia Huan 2021/09/18      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl" 

begin
  
filename = "/work1/jiajia1708/scripts/ncl_scripts/input/matlab_output_fittest.csv"

  str_array = asciiread(filename,-1,"string")
  values_2d = tofloat(str_split_csv(str_array,",",0))

  ba  = values_2d(0,:)
  ref = values_2d(1,:)
  bastd    = values_2d(2,:)
  refstd    = values_2d(3,:)
  z  = values_2d(4,:)
  



;------------OPEN Workstation-------------------------------   
plotname = "ba-ref-DJF" 
wks = gsn_open_wks("x11",plotname) ; 

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

;res@tiMainFont    = "Courier"
;res@tiXAxisFont   = "Courier"
;res@tiYAxisFont   = "Courier"
;res@trXMinF       = 0
;res@trXMaxF       = 300
res@tiMainFontHeightF      = 0.022 
res@tiXAxisFontHeightF     = 0.013
res@tiYAxisFontHeightF     = 0.013
res@gsnMaximize  = True
res@tmXBOn	=True
res@tmXTOn = True

res@tmBorderThicknessF = 4
res@tmYLMajorThicknessF = 4
res@tmYLMinorThicknessF = 2
res@tmXBMajorThicknessF = 4
res@tmXBMinorThicknessF = 2


res@tiXAxisString = "Refractivity OmB (N)"

res@trYMinF  = 0.0
res@trYMaxF  =  25

res1 = res
res1@tiMainString  = "Bending Angle and Refractivity"
res1@tiYAxisString = "MSL Altitude(km)"
res1@tiXAxisOffsetYF = -0.00
res1@tiYAxisOffsetXF = -0.01
res1@pmLegendDisplayMode    = "Always"            ; turn on legend
res1@pmLegendSide           = "Top"               ; Change location of 
res1@pmLegendParallelPosF   = 0.2                  ; move units right
res1@pmLegendOrthogonalPosF = -0.28                ; move units down
res1@pmLegendWidthF         = 0.15                ; Change width and
res1@pmLegendHeightF        = 0.18                ; height of legend.
res1@lgPerimOn              = False               ; turn off box around
res1@lgLabelFontHeightF     = 0.012                 ; label font height
res1@xyExplicitLegendLabels = "Bending angle bias"         ; create explicit labels
res1@xyLineColor   = "Red" 
res1@tiXAxisString = "Bending angle OmB (rad)"

res1@trXMinF  = -0.012
res1@trXMaxF  = 0.012

res2 = res
res2@pmLegendDisplayMode    = "Always"            ; turn on legend
res2@pmLegendSide           = "Top"               ; Change location of 
res2@pmLegendParallelPosF   = 0.18                 ; move units right
res2@pmLegendOrthogonalPosF = -0.4               ; move units down
res2@pmLegendWidthF         = 0.15                ; Change width and
res2@pmLegendHeightF        = 0.18                ; height of legend.
res2@lgPerimOn              = False               ; turn off box around
res2@lgLabelFontHeightF     = 0.012                 ; label font height
res2@xyExplicitLegendLabels = "Refractivity bias"         ; create explicit labels
res2@tiXAxisString = ""
res2@xyLineColor   = "Blue" 
res2@tmXMajorGrid                 = True   ; Turn on vertical lines
res2@tmXMajorGridThicknessF       = 1
res2@tmXMajorGridLineDashPattern  = 2
res2@trXMinF  = -15
res2@trXMaxF  =  15

res3 = res
res3@pmLegendDisplayMode    = "Always"            ; turn on legend
res3@pmLegendSide           = "Top"               ; Change location of 
res3@pmLegendParallelPosF   = 0.24                 ; move units right
res3@pmLegendOrthogonalPosF = -0.42               ; move units down
res3@pmLegendWidthF         = 0.15                ; Change width and
res3@pmLegendHeightF        = 0.18                ; height of legend.
res3@lgPerimOn              = False               ; turn off box around
res3@lgLabelFontHeightF     = 0.012                 ; label font height
res3@xyExplicitLegendLabels = "Std of Bending angle bias"         ; create explicit labels
res3@xyLineColor   = "Red" 
res3@xyDashPattern = 4
res3@tmXMajorGrid                 = True   ; Turn on vertical lines
res3@tmXMajorGridThicknessF       = 1
res3@tmXMajorGridLineDashPattern  = 2
res1@trXMinF  = -0.012
res1@trXMaxF  = 0.012

res4 = res
res4@pmLegendDisplayMode    = "Always"            ; turn on legend
res4@pmLegendSide           = "Top"               ; Change location of 
res4@pmLegendParallelPosF   = 0.22                 ; move units right
res4@pmLegendOrthogonalPosF = -0.47               ; move units down
res4@pmLegendWidthF         = 0.15                ; Change width and
res4@pmLegendHeightF        = 0.18                ; height of legend.
res4@lgPerimOn              = False               ; turn off box around
res4@lgLabelFontHeightF     = 0.012                ; label font height
res4@xyExplicitLegendLabels = "Std of Refractivity bias"         ; create explicit labels
res4@xyLineColor   = "Blue" 
res4@xyDashPattern = 4
res4@tmXMajorGrid                 = True   ; Turn on vertical lines
res4@tmXMajorGridThicknessF       = 1
res4@tmXMajorGridLineDashPattern  = 2
res4@trXMinF  = -15
res4@trXMaxF  =  15

;-------------Draw plot---------------------------------------
plot1 = gsn_csm_x2y(wks,ba,ref,z,res1,res2)
plot2 = gsn_csm_x2y(wks,bastd,refstd,z,res3,res4)
;plot2 = gsn_csm_xy(wks,bastd,z,res3)
;plot3 = gsn_csm_xy(wks,refstd,z,res4)
overlay(plot1,plot2)
;overlay(plot1,plot3)
draw(plot1)
frame(wks)

system("mv "+plotname+".pdf"+" "+"/work1/jiajia1708/scripts/ncl_scripts/output-figures/")
print("========================================")
;i = i+1
;end do
end
