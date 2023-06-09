%% Create 2D LSW Height matrix
function X  = translswheight(val,lsw)
xnumbox = 35;
boxgap =  (1);
initial = 0;




X = zeros(xnumbox,67);

xindex = floor((lsw-initial)/(boxgap))+1;

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