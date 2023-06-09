%  Pham Gia Huan 2022/10/14                                              %
%  This code calculates refractivity from ERA5 temperature and humidity  %
%  then transform this refractivity into given observation RO space      %                                                           
%                                                                        %
%                                                                        %
%------------------------------------------------------------------------%
%% Call for variables
clc; clear;

ncfile2 = 'G:\My Drive\phd-prog\works\project-errors\dynamic-errors\temp\bias_estimation_GPSRO\ERA5\data_020_all_z.nc';
%ncfile3 = 'G:\My Drive\phd-prog\works\project-errors\dynamic-errors\temp\bias_estimation_GPSRO\ERA5\testERA5.nc';
geoh = 020;
 % -----------------EC variables------------------------------------------------------------
alt = ncread(ncfile2,'z');
zEC = (6356766.* alt)./(6356766-alt);
clear alt;

ncfile1 = 'G:\My Drive\phd-prog\works\project-errors\dynamic-errors\temp\bias_estimation_GPSRO\ERA5\data_RO_v3.nc';
ncfile3 = 'G:\My Drive\phd-prog\works\project-errors\dynamic-errors\temp\bias_estimation_GPSRO\ERA5\data_020_NH_tempqv.nc';

lonEC = double(ncread(ncfile3,'longitude'));
latEC = double(ncread(ncfile3,'latitude'));
qEC = ncread(ncfile3,'q');
tempEC = ncread(ncfile3,'t');
%zEC = zEC(1:721,1:181,:); %SH1
%zEC = zEC(720:1440,1:181,:); %SH2
%zEC = zEC(720:1440,181:361,:); %NH2
zEC = zEC(1:721,181:361,:); %NH1


 % ------------------RO variables------------------------------------------------------------

refRO = ncread(ncfile1,'refRO') ;
refRO(refRO==-999) = nan;
refRO(refRO==0) = nan;
%writematrix(refRO,'refRO.csv');

lswRO = ncread(ncfile1,'lswPctg') ;
lswRO(lswRO==-999) = nan;
lswRO(lswRO==0) = nan;
%writematrix(lswRO,'lswRO.csv');

baRO = ncread(ncfile1,'baOmB') ;
baRO(baRO==-999) = nan;
baRO(baRO==0) = nan;
%writematrix(baRO,'baRO.csv');

latRO = ncread(ncfile1,'Lat') ;
latRO(latRO==-999) = nan;
latRO(latRO==0) = nan;
%writematrix(latRO,'Lat_RO.csv');

lonRO = ncread(ncfile1,'Lon') ;
lonRO(lonRO==-999) = nan;
lonRO(lonRO==0) = nan;
%writematrix(lonRO,'Lon_RO.csv');

tempRO = ncread(ncfile1,'Temp') ;
tempRO(tempRO==-999) = nan;
tempRO(tempRO==0) = nan;
%writematrix(tempRO,'Temp_RO.csv');

presRO = ncread(ncfile1,'presRO') ;
presRO(presRO==-999) = nan;
presRO(presRO==0) = nan;

qRO = ncread(ncfile1,'sph') ;
qRO(qRO==-999) = nan;
qRO(qRO==0) = nan;
%writematrix(qRO,'qv_RO.csv');

zRO   = ncread(ncfile1,'MSL_alt') ;
zRO   = zRO';
%writematrix(zRO,'zRO.csv');
% 
% index = ncread(ncfile1,'Prof_num') ;
% indexSize = size(index);
% 
latRO = mean(latRO,2,"omitnan");
lonRO = mean(lonRO,2,"omitnan");
hourRO = ncread(ncfile1,'hourRO') ;
dayRO = ncread(ncfile1,'dayRO') ;
monthRO = ncread(ncfile1,'monthRO') ;

lswRO(all(isnan(refRO),2),:)= [];
lonRO(all(isnan(refRO),2),:)= [];
latRO(all(isnan(refRO),2),:)= [];
baRO(all(isnan(refRO),2),:)= [];
tempRO(all(isnan(refRO),2),:)= [];
qRO(all(isnan(refRO),2),:)= [];
presRO(all(isnan(refRO),2),:)= [];
hourRO(all(isnan(refRO),2),:)= [];
dayRO(all(isnan(refRO),2),:)= [];
monthRO(all(isnan(refRO),2),:)= [];
refRO(all(isnan(refRO),2),:)= [];
sizeRO = size(refRO(:,1));




%% Interpolate wrt time
ROAddSpaceTimehour = [hourRO, dayRO, monthRO, latRO, lonRO, refRO];
hourROTransform = zeros(sizeRO);
for i = 1:size(ROAddSpaceTimehour(:,1),1)
    if ROAddSpaceTimehour(i,3) == 1
        hourROTransform(i) = ROAddSpaceTimehour(i,1)+1+ROAddSpaceTimehour(i,2).*24-24;
    elseif ROAddSpaceTimehour(i,3) == 2
        hourROTransform(i) = ROAddSpaceTimehour(i,1)+1+ROAddSpaceTimehour(i,2).*24-24 + 744;
    else 
        hourROTransform(i) = ROAddSpaceTimehour(i,1)+1+ROAddSpaceTimehour(i,2).*24-24 + 1440;
    end
end

ROAddSpaceTime = [hourROTransform, latRO, lonRO, refRO];
ROAddSpaceTime(ROAddSpaceTime(:, 1)> 1440, :)= [];
%refROAddSpaceTimehour = [hourRO, dayRO, monthRO, latRO, lonRO, refROIntpZ];
clear ROAddSpaceTimehour;


%% Interpolate wrt lat,lon

% refROAddSpaceTimeSortLat = sortrows(ROAddSpaceTime,4);
% refROAddSpaceTimeSortSpace = sortrows(ROAddSpaceTime,[4,5]);
% refROAddSpaceTimeSortLon = sortrows(ROAddSpaceTime,5);


[lonEC1,latEC1] = meshgrid(lonEC,latEC);

lonROInt = ROAddSpaceTime(:,3);
latROInt = ROAddSpaceTime(:,2);

qECIntROSpace = zeros(size(ROAddSpaceTime(:,1),1),1440);
TECIntROSpace = zeros(size(ROAddSpaceTime(:,1),1),1440);
zECIntROSpace = zeros(size(ROAddSpaceTime(:,1),1),1440);
for i = 1:1440
    qECTimeSlices = qEC(:,:,i);
    TECTimeSlices = tempEC(:,:,i);
    zECTimeSlices = zEC(:,:,i);
    qECIntROSpace(:,i) = interp2(lonEC1,latEC1,qECTimeSlices',lonROInt,latROInt,'lineal');
    TECIntROSpace(:,i) = interp2(lonEC1,latEC1,TECTimeSlices',lonROInt,latROInt,'lineal');
    zECIntROSpace(:,i) = interp2(lonEC1,latEC1,zECTimeSlices',lonROInt,latROInt,'lineal');
end

refEC = 77.6.*(geoh./TECIntROSpace)+3.73.*10^5.*(((geoh.*1000.*qECIntROSpace)./(622+0.378.*1000.*qECIntROSpace))./(TECIntROSpace.^2));

%% Matching time dimension
refECmatched = zeros(size(ROAddSpaceTime(:,1)));
zECmatched = zeros(size(ROAddSpaceTime(:,1)));
timeVal = ROAddSpaceTime(:,1);
for m = 1:size(ROAddSpaceTime(:,1),1)
refECmatched(m,1) = (refEC(m,timeVal(m,1)));
zECmatched(m,1) = (zECIntROSpace(m,timeVal(m,1)));

end


%% Calculate the bias RO - EC

%refEC1 = 77.6.*(geoh./tempEC)+3.73.*10^5.*(((geoh.*1000*qEC)./(622+0.378.*1000*qEC))./(tempEC.^2));

refBias = zeros(size(ROAddSpaceTime(:,1)));
refECmatched = zeros(size(ROAddSpaceTime(:,1)));
timeVal = ROAddSpaceTime(:,1);
for m = 1:size(ROAddSpaceTime(:,1),1)
refECmatched(m,1) = (refEC(m,timeVal(m,1)));

end

ECtransformObsSpace = [refECmatched,zECmatched];
writematrix(ECtransformObsSpace,'refBias_NH1.csv');


