%% Combine estimate of 2 estimation using Minimum variance estimator 
function u_mv = mvesti(u1, u2, utrue)

meanu  = mean(utrue,'omitnan');
sizetarget = size(u1,1);
std1    = sqrt((sum(u1 -  meanu,1,"omitnan")./(sizetarget-1)).^2);                       % Standard deviation of u1
std2    = sqrt((sum(u2 -  meanu,1,"omitnan")./(sizetarget-1)).^2);                      % Standard deviation of u2

R       = corrcoef(u1,u2,'rows','complete');        % correlation matrix
S       = [std1 0; 0 std2];                         % standard deviation matrix
C       = S*R*S;       

vec1 = [1 ; 1];
Cinv = inv(C);
m = inv(sum(Cinv,'all')).*Cinv*vec1;
vecu = [u1 , u2];
u_mv = vecu*m;
end