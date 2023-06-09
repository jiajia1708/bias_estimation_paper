clc; clear;
%This code use the function in file land_or_ocean.m to determine whether 
%the vector with lat and lon is belong to land or ocean (require mapping toolbox)
%output is writen to isOcean.csv with value as : 1 = ocean, 0 = land
%Pham Gia Huan --------- 2021/05/02
%clear
clc
close('all')
%% Ex1

load('data.mat');
MWdata = reshape(Output,[224674,67,8]);
lat = MWdata(:,:,2);
lon = MWdata(:,:,3);

lat = mean(lat,2,"omitnan")';
lon = mean(lon,2,"omitnan")';
% data = readmatrix('fit_residual_latlon_lswonly_015_JJA.csv');
% lat  = data(:,2);
% lon  = data(:,3);
coastal_res = 1;
make_plot = 1;  %0 = no plot, 1 = plot
[isOcean1] = land_or_ocean(lat,lon,coastal_res,make_plot);
figure(1)
%saveas(gcf,'ex1.pdf','pdf')
writematrix(isOcean1,'isOceanMW.csv') 