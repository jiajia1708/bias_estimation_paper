%% Boxes separation base on lat
function X  = translswheight(val,lat)
xnumbox = 45;
boxgap =  (90/xnumbox);
initial = -45;




X = zeros(xnumbox,67);

xindex = floor((lat-initial)/(boxgap))+1;

for nz = 1:67
for ixBox = 1:xnumbox
      vaildindex = find(xindex == ixBox);
      vaildindex = vaildindex(~isnan(val(vaildindex,nz)));
      if ~isempty(vaildindex) > 0
          X(ixBox,nz) = mean(val(vaildindex,nz));
      end
end
end
end