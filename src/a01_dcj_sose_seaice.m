%
% Get B-SOSE sea ice extent
%

%% Initial setup

% clean up workspace
clear all
close all

% add paths
addpath ~/matlabfiles/
addpath ~/matlabfiles/m_map/
addpath ~/colormaps/
load('cividis.txt')

% locations
floc = '/data/oceans_output/bsose/iter122_0pt6deg/daily_avgs/bsose_i122_2013to2017_1day_SeaIceArea.nc';

%% Load data

% grid and variable
XC = ncread(floc,'XC');
YC = ncread(floc,'YC');
time_in_sec = ncread(floc,'time');
depth = ncread(floc,'Depth');
rA = ncread(floc,'rA');
SIarea = ncread(floc,'SIarea');

% grid
[x,y] = meshgrid(XC,YC);
x = x'; y = y';

% convert to millions of km^2
SIarea = SIarea./1e12;

% extract Weddell Sea (63W - 10W | south of 50S) 
% 297E - 350E
i0 = nanlocate(XC,297); i1 = nanlocate(XC,350);
j0 = 1; j1 = nanlocate(YC,-50);

% extract
depth_weddell = depth(i0:i1,j0:j1);
rA_weddell = rA(i0:i1,j0:j1);
SIarea_weddell = SIarea(i0:i1,j0:j1,:);
x_ws = x(i0:i1,j0:j1);
y_ws = y(i0:i1,j0:j1);

% total sea ice area 
rA_weddell = repmat(rA_weddell,[1 1 size(SIarea,3)]);
SIarea_ws_total = squeeze(nansum(squeeze(nansum(rA_weddell.*SIarea_weddell))));

% time
t = datetime('2012-12-01 00:00:00') + seconds(time_in_sec);
DOY = day(t,'dayofyear');
year = t.Year;

%% extract individual years
% 2013
doy_2013 = DOY(year==2013);
SIarea_2013 = SIarea_ws_total(year==2013);
% 2014
doy_2014 = DOY(year==2014);
SIarea_2014 = SIarea_ws_total(year==2014);
% 2015
doy_2015 = DOY(year==2015);
SIarea_2015 = SIarea_ws_total(year==2015);
% 2016
doy_2016 = DOY(year==2016);
SIarea_2016 = SIarea_ws_total(year==2016);
% 2017
doy_2017 = DOY(year==2017);
SIarea_2017 = SIarea_ws_total(year==2017);

%% Initial plot
lw = 2.0; 
figure('color','w','position',[36 122 1099 645])
hold on
plot(doy_2013, SIarea_2013, 'linewidth',lw)
plot(doy_2014, SIarea_2014, 'linewidth',lw)
plot(doy_2015, SIarea_2015, 'linewidth',lw)
plot(doy_2016, SIarea_2016, 'linewidth',lw)
plot(doy_2017, SIarea_2017, 'linewidth',lw)
legend('2013','2014','2015','2016','2017');
set(gca, 'fontsize',18);
xlabel('Day of year');
ylabel('Sea ice area (millions of square kilometres)');
title('Weddell Sea');
set(gca,'xgrid','on','ygrid','on');
saveas(gcf,'weddell_sea_ice_bsose.pdf','pdf');


