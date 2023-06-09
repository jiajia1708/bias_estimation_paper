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

  ref  = values_2d(0,:)
  std   = values_2d(1,:)
  z  = values_2d(2,:)
  



;------------OPEN Workstation-------------------------------   
plotname = "ref-std-all"
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
res@tiMainString  = "Mean refractivity bias of the study time"
res@tiYAxisString = "MSL Altitude (km)"
res@tiXAxisOffsetYF = -0.00
res@tiYAxisOffsetXF = -0.01
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
res@trYReverse = False

res@tiXAxisString = "Std of bias"
res@trYMinF  = 0
res@trYMaxF  = 25

res1 = res
res1@pmLegendDisplayMode    = "Always"            ; turn on legend
res1@pmLegendSide           = "Top"               ; Change location of 
res1@pmLegendParallelPosF   = 0.78                  ; move units right
res1@pmLegendOrthogonalPosF = -0.22                ; move units down
res1@pmLegendWidthF         = 0.15                ; Change width and
res1@pmLegendHeightF        = 0.18                ; height of legend.
res1@lgPerimOn              = False               ; turn off box around
res1@lgLabelFontHeightF     = 0.015                 ; label font height
res1@xyExplicitLegendLabels = "Refractivity bias"         ; create explicit labels
res1@xyLineColor   = "Blue" 
res1@tiXAxisString = "Refractivity unit (N)"

res1@trXMinF  = -25
res1@trXMaxF  = 25

res2 = res
res2@pmLegendDisplayMode    = "Always"            ; turn on legend
res2@pmLegendSide           = "Top"               ; Change location of 
res2@pmLegendParallelPosF   = 0.738                 ; move units right
res2@pmLegendOrthogonalPosF = -0.50               ; move units down
res2@pmLegendWidthF         = 0.15                ; Change width and
res2@pmLegendHeightF        = 0.18                ; height of legend.
res2@lgPerimOn              = False               ; turn off box around
res2@lgLabelFontHeightF     = 0.015                 ; label font height
res2@xyExplicitLegendLabels = "Std of bias"         ; create explicit labels
res2@tiXAxisString = "STD"
res2@xyLineColor   = "Red" 
res2@xyDashPattern = 4
res2@tmXMajorGrid                 = True   ; Turn on vertical lines
res2@tmXMajorGridThicknessF       = 1
res2@tmXMajorGridLineDashPattern  = 2
res2@trXMinF  = 0
res2@trXMaxF  =  30




;-------------Draw plot---------------------------------------
plot1 = gsn_csm_x2y(wks,ref,std,z,res1,res2)
draw(plot1)
frame(wks)

system("mv "+plotname+".pdf"+" "+"/work1/jiajia1708/scripts/ncl_scripts/output-figures/")
print("========================================")
;i = i+1
;end do
end
