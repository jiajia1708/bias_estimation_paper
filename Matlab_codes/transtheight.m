%% Create 2D temp Height matrix
function X  = transtheight(val,x)
xnumbox = 30;
boxgap =  0.33;
initial = 15;




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