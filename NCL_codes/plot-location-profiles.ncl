;;---------------- Locations of COSMIC2 curvature point in related to error between COSMIC2 and ECMWF ----------------;;
;; This code is to calculate the error between COSMIC2 and ECMWF bending angles and refractivity                      ;;
;; then filter out the locations based on the magnitude of relative errors                                            ;;
;;                                                                           Written by Pham Gia Huan 2020/08/30      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
begin
filename = "/work1/jiajia1708/scripts/ncl_scripts/input/matlab_output_fittest.csv"

  str_array = asciiread(filename,-1,"string")
  values_2d = tofloat(str_split_csv(str_array,",",0))

  ref  = values_2d(:,0)
  lat   = values_2d(:,1)
  lon  = values_2d(:,2)

;------------------------------------OPEN WORKSTATION-----------------------------------------------  
output_name = "locations_profiles"
wks   = gsn_open_wks ("png",output_name)              ; send graphics to PNG file 
res             = True                              ; plot mods desired
res@gsnFrame    = False                             ; don't advance yet
res@gsnMaximize = True

res@mpOutlineOn           = True
res@mpFillOn              = True
res@mpMinLatF = -45
res@mpMaxLatF = 45
res@mpMinLonF = -180
res@mpMaxLonF = 180 
res@tiMainString = "Location of profiles with LSW >30% and possitive REFB (Land)"
res@tmXBMinorOn       =False
res@tmYLMinorOn       =False
res@tmXTOn            =False
res@tmYROn            =False
res@tmBorderThicknessF = 4
res@tmYLMajorThicknessF = 4
res@tmYLMinorThicknessF = 2
res@tmXBMajorThicknessF = 4
res@tmXBMinorThicknessF = 2
res@tmXBLabelFontHeightF = 0.014
res@tmYLLabelFontHeightF = 0.014
res@pmLabelBarOrthogonalPosF = .25           ; move whole thing down

map = gsn_csm_map(wks,res)                ; Create the map plot, don't draw

mkres               = True
mkres@gsMarkerIndex = 4
mkres@gsMarkerSizeF = 0.010
mkres@gsMarkerColor = "blue"

gsn_polymarker(wks,map,lon,lat,mkres)

frame(wks)

print(lat)

system("mv "+output_name+".png"+" "+"/work1/jiajia1708/scripts/ncl_scripts/output-figures/")

end
