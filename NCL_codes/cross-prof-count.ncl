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
filename = "/work1/jiajia1708/scripts/ncl_scripts/input/xy_matlab_output.csv"

  str_array = asciiread(filename,-1,"string")
  values_2d = tofloat(str_split_csv(str_array,",",0))

  Ncount     = values_2d(4,:)
  bacount    = values_2d(5,:)
 
;--------------------------------------PLOT CONTOUR----------------------------------------------
plotname = "count-profile-JJA"
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
res@tiMainString  = "Data Count Profile"
res@tiYAxisString = "MSL Altitude (km)"
res@tiXAxisString = "Number of data (profile)"
res@tiXAxisOffsetYF= -0.02
res@tiYAxisOffsetXF= -0.02

res@tiMainFontHeightF      = 0.018 
res@tiXAxisFontHeightF     = 0.015
res@tiYAxisFontHeightF     = 0.015
res@gsnMaximize  = True
res@trYMinF  = 0.0
res@trYMaxF  =  25
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

res1 = res
res1@pmLegendDisplayMode    = "Never"            ; turn on legend
res1@pmLegendSide           = "Top"               ; Change location of 
res1@pmLegendParallelPosF   = 0.8                  ; move units right
res1@pmLegendOrthogonalPosF = -0.3                ; move units down
res1@pmLegendWidthF         = 0.15                ; Change width and
res1@pmLegendHeightF        = 0.18                ; height of legend.
res1@lgPerimOn              = False               ; turn off box around
res1@lgLabelFontHeightF     = 0.015                 ; label font height
res1@xyExplicitLegendLabels = " "         ; create explicit labels
res1@xyLineColor   = "Blue" 
res2 = res
res2@pmLegendDisplayMode    = "Never"            ; turn on legend
res2@pmLegendSide           = "Top"               ; Change location of 
res2@pmLegendParallelPosF   = 0.785                 ; move units right
res2@pmLegendOrthogonalPosF = -0.36                ; move units down
res2@pmLegendWidthF         = 0.15                ; Change width and
res2@pmLegendHeightF        = 0.18                ; height of legend.
res2@lgPerimOn              = False               ; turn off box around
res2@lgLabelFontHeightF     = 0.015                 ; label font height
res2@xyExplicitLegendLabels = " "          ; create explicit labels
res2@xyLineColor = "Red"

;-------------Draw plot---------------------------------------
plot1 = gsn_csm_xy(wks,Ncount,values_2d(6,:),res1)
plot2 = gsn_csm_xy(wks,bacount,values_2d(6,:),res2)

overlay (plot1, plot2)
draw(plot1)
frame(wks)

;-------------Draw plot---------------------------------------
system("mv "+plotname+".pdf"+" "+"/work1/jiajia1708/scripts/ncl_scripts/output-figures/")
print("========================================")
end

