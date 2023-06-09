%% Create 2D q Height matrix
function X  = transqheight(val,x)
xnumbox = 16;
boxgap =  (1/2);
initial = 4;




X = zeros(xnumbox,67);

xindex = floor((x-initial)/(boxgap))+1;

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

