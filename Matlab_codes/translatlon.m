%% Create 2D lat lon matrix
function X  = translatlon3072(val,lat,lon)

ynumbox = 30;
xnumbox = 72;
%X = zeros(ynumbox,xnumbox);
% 
box_gap =  (96/ynumbox);
box_gap_lon = (360/xnumbox);
initial = -48;
start	= -180;


% 
X = zeros(ynumbox,xnumbox);
Z = zeros(ynumbox,xnumbox);
lonindex = floor((lon-start)/(box_gap_lon))+1;
latindex = floor((lat-initial)/(box_gap))+1;

for ilatBox = 1:ynumbox
   for iLonBox = 1:xnumbox
      vaildindex = find(latindex == ilatBox & lonindex == iLonBox);
      vaildindex = vaildindex(~isnan(val(vaildindex)));
      Z(ilatBox,iLonBox) = length(vaildindex);
      if ~isempty(vaildindex) > 0
         X(ilatBox,iLonBox) = mean(val(vaildindex));
         % X(ilatBox,iLonBox) = mean(val(vaildindex),1,"omitnan");
      end
   end
end
X =  1.*X;
writematrix(X,'plot_output_matlab_fittest.csv');

end
%writematrix(Y,'plot_fittest_2_y_JJA.csv');