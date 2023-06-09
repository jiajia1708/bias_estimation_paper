
clc; clear;


%% Variable declaration
trainingdata = load("biasData_015km.csv");
testingdata = load('testing_biasData_015km.csv');

ref = trainingdata(:,1) ;
q = trainingdata(:,2) ;
T = trainingdata(:,3) ;
lsw = trainingdata(:,4) ;
lat = trainingdata(:,5);
lon = trainingdata(:,6) ;

ref2 = testingdata(:,1) ;
q2 = testingdata(:,2) ;
T2 = testingdata(:,3) ;
lsw2 = testingdata(:,4) ;
lat2 = testingdata(:,5);
lon2 = testingdata(:,6) ;

filesize = size(lat,1);

%% Level height selection
lv = 1;
x = zeros(filesize,3);
Qplot = x(:,2);
Tplot = x(:,3);
%% OmB and error definition
%u        = ref(:,1);
mean_ref = mean(ref,1,"omitnan");
refz = ref(:,lv);
refz( isnan(refz)) = 0; 
utarget = ref;


%% Define function that will be used to fit data
% (F is a vector of fitting parameters)


ynumbox = 24;
xnumbox = 36;
%X = zeros(ynumbox,xnumbox);
% 
box_gap =  (90/ynumbox);
box_gap_lon = (360/xnumbox);
initial = -45;
start	= -180;

% 
X = zeros(ynumbox,xnumbox);
X2 = zeros(ynumbox,xnumbox);
Z = zeros(ynumbox,xnumbox);
lonindex = floor((lon-start)/(box_gap_lon))+1;
latindex = floor((lat-initial)/(box_gap))+1;

lonindex2 = floor((lon2-start)/(box_gap_lon))+1;
latindex2 = floor((lat2-initial)/(box_gap))+1;
x = zeros(filesize,3);

%% LSW based fit models
 
for ilatBox = 1:ynumbox
   for iLonBox = 1:xnumbox
      vaildindex = find(latindex == ilatBox & lonindex == iLonBox);
      vaildindex = vaildindex(~isnan(lsw(vaildindex)));
      vaildindex2 = find(latindex2 == ilatBox & lonindex2 == iLonBox);
      vaildindex2 = vaildindex2(~isnan(lsw2(vaildindex2)));
      Z(ilatBox,iLonBox) = length(vaildindex);
      if ~isempty(vaildindex) > 0
        x1  = (lsw(vaildindex));
        y   = (ref(vaildindex));
        x1t  = (lsw2(vaildindex2));
        yt   = (ref2(vaildindex2));
        f1 = @(F,x) (F(1).*x1.^2 + F(2).*x1 + F(3));
        F1_fitted = nlinfit(x,y,f1,[0 0 0]);
         X(ilatBox,iLonBox) = mean(F1_fitted(1).*x1.^2 + F1_fitted(2).*x1 + F1_fitted(3),"all","omitnan");
         X2(ilatBox,iLonBox) = mean(F1_fitted(1).*x1t.^2 + F1_fitted(2).*x1t + F1_fitted(2),"all","omitnan");
         % X(ilatBox,iLonBox) = mean(val(vaildindex),1,"omitnan");
      end
   end
end

y1 = X;
y1t = X2;
%% Tq based fit models

for ilatBox = 1:ynumbox
   for iLonBox = 1:xnumbox
      vaildindex = find(latindex == ilatBox & lonindex == iLonBox);
      vaildindex = vaildindex(~isnan(lsw(vaildindex)));
      vaildindex2 = find(latindex2 == ilatBox & lonindex2 == iLonBox);
      vaildindex2 = vaildindex2(~isnan(lsw2(vaildindex2)));
      Z(ilatBox,iLonBox) = length(vaildindex);
      if ~isempty(vaildindex) > 0
        x = zeros(size(vaildindex,1),2);
        x(:,1)  = (T(vaildindex));
        x(:,2)  = (q(vaildindex));
        y   = (ref(vaildindex));

        xt = zeros(size(vaildindex2,1),2);
        xt(:,1)  = (T2(vaildindex2));
        xt(:,2)  = (q2(vaildindex2));
        yt   = (ref2(vaildindex2));

        f2 = @(F,x) (F(1).*x(:,2)).^2 + F(2).*x(:,2) + F(3).*x(:,2).*x(:,1);
        F2_fitted = nlinfit(x,y,f2,[1 1 1]);

        X(ilatBox,iLonBox) = mean((F2_fitted(1).*x(:,2)).^2 + F2_fitted(2).*x(:,2) + F2_fitted(3).*x(:,2).*x(:,1),"all","omitnan");
        X2(ilatBox,iLonBox) = mean((F2_fitted(1).*xt(:,2)).^2 + F2_fitted(2).*xt(:,2) + F2_fitted(3).*xt(:,2).*xt(:,1),"all","omitnan");
         % X(ilatBox,iLonBox) = mean(val(vaildindex),1,"omitnan");
      end
   end
end

y2 = X;
y2t = X2;

%% MVE Estimation

for ilatBox = 1:ynumbox
   for iLonBox = 1:xnumbox
      vaildindex = find(latindex == ilatBox & lonindex == iLonBox);
      vaildindex = vaildindex(~isnan(lsw(vaildindex)));
      vaildindex2 = find(latindex2 == ilatBox & lonindex2 == iLonBox);
      vaildindex2 = vaildindex2(~isnan(lsw2(vaildindex2)));
      Z(ilatBox,iLonBox) = length(vaildindex);

      if ~isempty(vaildindex) > 0
        x1  = (lsw(vaildindex));
        y   = (ref(vaildindex));

        x1t  = (lsw2(vaildindex2));

        f1 = @(F,x) (F(1).*x1.^2+F(2).*x1 + F(3));
        F1_fitted = nlinfit(x,y,f1,[0 0 0]);
        u1 = (F1_fitted(1).*x1.^2 + F1_fitted(2).*x1  + F1_fitted(3));
        u1t = (F1_fitted(1).*x1t.^2 + F1_fitted(2).*x1t + F1_fitted(3));

        x = zeros(size(vaildindex,1),2);
        x(:,1)  = (T(vaildindex));
        x(:,2)  = (q(vaildindex));
        y   = (ref(vaildindex));

        xt = zeros(size(vaildindex2,1),2);
        xt(:,1)  = (T2(vaildindex2));
        xt(:,2)  = (q2(vaildindex2));
        yt   = (ref2(vaildindex2));

        f2 = @(F,x) (F(1).*x(:,2)).^2 + (F(2).*x(:,2) + F(3).*x(:,2).*x(:,1));
        F2_fitted = nlinfit(x,y,f2,[1 1 1]);
        u2= (F2_fitted(1).*x(:,2)).^2 + F2_fitted(2).*x(:,2) + F2_fitted(3).*x(:,2).*x(:,1);
        u2t= (F2_fitted(1).*xt(:,2)).^2 + F2_fitted(2).*xt(:,2) + F2_fitted(3).*xt(:,2).*xt(:,1);
         % X(ilatBox,iLonBox) = mean(val(vaildindex),1,"omitnan");
        
        
        meanu  = mean(y,'omitnan');
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
   end
end

y3 = X;
y3t = X2;

yr  = translatlon(ref,lat,lon);
yrt  = translatlon(ref2,lat2,lon2);
spatial_temp = translatlon(T,lat,lon);

countprof    = countslatlon(ref,lat,lon);

%% Exporting for plots
