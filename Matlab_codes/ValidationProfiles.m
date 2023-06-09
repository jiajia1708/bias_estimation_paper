load ProfilesCase2new.mat
%% Fitting
clc; clear;

load DataExtractERA5.mat
load LatLonExtractERA5.mat
load Maindata.mat;
Maindata = reshape(Output,[224674,67,8]);

z = [0.0322219179548055,  0.0824094945629655, 0.111092704911124, ...
    0.176731529122765, 0.255051680068412, 0.299660071864164, ...
    0.40137572826412, 0.522041692486313, 0.664623857999884, ...
    0.832342764833521, 0.926870574937064, 1.14001210104109, 1.25948860720411, ...
    1.52611198309868, 1.83217779339374, 2.00092929017192, 2.18076267839336, ...
    2.57433321324445, 2.78814475828866, 3.24951584168615, 3.49671807775845, ...
    3.75430665387492, 4.29758883170157, 4.58174691217142, 5.17176006628813,...
    5.47607923871421, 5.78470679590024, 6.40684241442103, 6.71860711920499, ...
    7.342618699714, 7.65472590409088, 8.27820430628394, 8.58937623166528, ...
    9.20931757774127, 9.51793629745067, 10.1327322818168, 10.4389883747589, ...
    10.7444012998685, 11.3571067300822, 11.664762075415, 11.9717974275903, ...
    12.5821762230722, 12.8854029594171, 13.487473091819, 13.7868448277744, ...
    14.0858184901446, 14.6835990988907, 14.9827437430691, 15.282098512994, ...
    15.8795733510936, 16.1773868714626, 16.4753548826435, 17.0744514676279, ...
    17.3765996229557, 17.6825881221769, 18.3111700695053, 18.6352702152775, ...
    19.3069114248401, 19.656411912896, 20.3891438474342, 20.7746513408122, ...
    21.5862164952233, 22.0127186385493, 22.9105098147706, 23.382302627774, ...
    24.372359729275, 25.4332549772622];


lsw = fullmat(:,:,4);
lsw(224675:end,:)=[];
lsw = lsw(:,:);

ref = Maindata(:,:,5);
lat = Maindata(:,:,2);
lat = mean(lat,2,"omitnan");
lon = Maindata(:,:,3);
lon = mean(lon,2,"omitnan");
T = Maindata(:,:,6);
q = Maindata(:,:,7);
p = Maindata(:,:,8);

meanu1 = zeros(67,0);
meanu2 = zeros(67,0);
meanu = zeros(67,0);
meanumv = zeros(67,0);
meanlsw = zeros(67,0);
meanq = zeros(67,0);
meant = zeros(67,0);

%% Define the validation box

SelIndex = find(lat < 10 & lat >0 & lon >55 & lon <75); %box1new
%SelIndex = find(lat < -20 & lat >-30 & lon >-95 & lon <-75); %box2new
SelRef = ref(SelIndex,1:67);
SelLsw = lsw(SelIndex,1:67);
Selq   = q(SelIndex,1:67);
SelT   = T(SelIndex,1:67);
SelLat = lat(SelIndex);
SelLon = lon(SelIndex);
filesize = size(SelRef,1);
x = zeros(filesize,3);
meanumvk = zeros(filesize,200);
u_mv_alldata = zeros(length(SelIndex),67) ;
u_real_alldata = zeros(length(SelIndex),67) ;
sdmv = std(ref,0,1,"omitnan");
sdr = std(SelRef,0,1,"omitnan");


%% Validation
load ProfilesCase2new.mat
xh= meanu;
yh = z;

xhe1= meanu1;
yhe1 = z;

xhe2= meanu2;
yhe2 = z;

xhe3= meanumv+25;
yhe3 = z;
xhe4  = SelRef(:,:);

A = repmat(z,filesize,1);
yhe4  = A;

binEdgesX = linspace(-25,25,100);
binEdgesY = linspace(0,25,50);
[counts,~,~,binX] = histcounts2(yhe4, xhe4, binEdgesY, binEdgesX);
rowSums = sum(counts,2);
rowSums(rowSums==0) = 1;
normCounts = bsxfun(@rdivide, counts, rowSums);

load normCountsCase2new_realbias_training.mat
% Plot fitting
figure(1);
clf;
hold on;
fig1_comps.fig = gcf;

%First plot

imagesc(normCounts);
colormap(jet);
caxis([0, 1]); % Set color axis limits
colorbar;

% Second plot

original_x = 1:numel(xhe3);
new_x = linspace(1, numel(xhe3), 134);
new_xhe3 = interp1(original_x, xhe3, new_x);
new_xh = interp1(original_x, xh, new_x);

original_y = 1:numel(yhe3);
new_y = linspace(1, numel(yhe3), 134);
new_yhe3 = interp1(original_y, yhe3, new_y);
new_yh = interp1(original_y, yh, new_y);

fig1_comps.p3 = plot(new_xh*2, new_yh*2);
fig1_comps.p4 = plot(new_xhe3*2, new_yhe3*2);

% Set axes limits and labels
xlim([15,65])
ylim([0,50])
set(gca,'XTick',0:50:50, 'YTick',0:10:50)
xlabel('X');
ylabel('Y');

xticks([10 20 30 40 50 60 70 80 90]);
xticklabels({'-20','-15', '-10', '-5', '0', '5', '10','15'});

yticks([0 10 20 30 40 50]);
yticklabels({'0','5', '10', '15', '20','25'});

% Set colorbar label
cb = colorbar();
ylabel(cb,'Profile Density')

% Send the second plot backward
uistack(gca, 'bottom');
axis equal


hold off;

%========================================================
% ADD LABELS, TITLE, LEGEND
title('Prob. of Real REFB (Area B) (training data)');
xlabel('REFB (Unit: N)');
ylabel('MSL Height (km)');
legend([fig1_comps.p4, fig1_comps.p3], 'Mean MVE (training)', 'Mean MVE (testing)');
legendX = .82; legendY = .87; legendWidth = 0.01; legendHeight = 0.01;
fig1_comps.legendPosition = [legendX, legendY, legendWidth, legendHeight];
% If you want the tightest box set width and height values very low matlab automatically sets the tightest box
%========================================================
% SET PLOT PROPERTIES
% Choices for COLORS can be found in ColorPalette.png
set(fig1_comps.p4, 'LineStyle', '-', 'LineWidth', 2.5);
set(fig1_comps.p3, 'LineStyle', '-', 'LineWidth', 2.5);
%========================================================
% INSTANTLY IMPROVE AESTHETICS-most important step
STANDARDIZE_FIGURE(fig1_comps);
%========================================================