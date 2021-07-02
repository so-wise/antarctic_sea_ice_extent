%
% Get B-SOSE sea ice extent: make some maps
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
floc = '/data/oceans_output/bsose/iter122_0pt6deg/monthly_avgs/bsose_i122_2013to2017_monthly_SeaIceArea.nc';

%% Load data

% grid and variable
XC = ncread(floc,'XC');
YC = ncread(floc,'YC');
time_in_sec = ncread(floc,'time');
depth = ncread(floc,'Depth');
rA = ncread(floc,'rA');
SIarea = ncread(floc,'SIarea');
depth3D = repmat(depth,[1 1 size(SIarea,3)]);

% grid
[x,y] = meshgrid(XC,YC);
x = x'; y = y';

% try to blank out land and ice shelves
SIarea(depth3D==0.0) = NaN;

% extract Weddell Sea (63W - 10W | south of 50S) 
% 297E - 350E
x0 = 297; x1 = 353;
y1 = -52;
i0 = nanlocate(XC,x0); i1 = nanlocate(XC,x1);
j0 = 1; j1 = nanlocate(YC,y1);

% extract
depth_weddell = depth(i0:i1,j0:j1);
rA_weddell = rA(i0:i1,j0:j1);
SIarea_weddell = SIarea(i0:i1,j0:j1,:);
x_ws = x(i0:i1,j0:j1);
y_ws = y(i0:i1,j0:j1);

% time
t = datetime('2012-11-01 00:00:00') + seconds(time_in_sec) + seconds(97920);
years = t.Year;
months = t.Month; 
monthName = month(t,'name');

%% figure
% Weddell Sea (63W - 10W | south of 50S) 
% 297E - 350E

% all months for 2013
myYear = 2013;
iYear = locate(years,myYear);
for nm=1:12
  myIndex = iYear+nm-1;
  figure('color','w','visible','off');
  m_proj('miller','long',[x0 x1]-360,'lat',[-78 y1]);
  m_pcolor(x_ws-360, y_ws, SIarea_weddell(:,:,myIndex));
  caxis([0 1]);
  %m_gshhs_l('patch',[0.5 0.5 0.5]);
  m_grid('xtick',[-60 -50 -40 -30 -20 -10],...
         'ytick',[-75 -70 -65 -60 -55 -50],...
         'xticklabels',[],...
         'yticklabels',[],...
         'xaxislocation','bottom');
  colormap(cividis);
  disp([monthName{myIndex}(1:3) ' ' num2str(years(myIndex))])
  m_text(-25,-77,[monthName{myIndex}(1:3) ' ' num2str(years(myIndex))],'fontsize',18);
  saveas(gcf,['bsose_seaice_' num2str(years(myIndex)) '-' sprintf('%02d',months(myIndex)) '.eps'],'epsc2'); 
end

% all months for 2016
myYear = 2016;
iYear = locate(years,myYear)+1;
for nm=1:12
  myIndex = iYear+nm-1;
  figure('color','w','visible','off');
  m_proj('miller','long',[x0 x1]-360,'lat',[-78 y1]);
  m_pcolor(x_ws-360, y_ws, SIarea_weddell(:,:,myIndex));
  caxis([0 1]);
  %m_gshhs_l('patch',[0.5 0.5 0.5]);
  m_grid('xtick',[-60 -50 -40 -30 -20 -10],...
         'ytick',[-75 -70 -65 -60 -55 -50],...
         'xticklabels',[],...
         'yticklabels',[],...
         'xaxislocation','bottom');
  colormap(cividis);
  disp([monthName{myIndex}(1:3) ' ' num2str(years(myIndex))])
  m_text(-25,-77,[monthName{myIndex}(1:3) ' ' num2str(years(myIndex))],'fontsize',18);
  saveas(gcf,['../reports/figures/bsose/' 'bsose_seaice_' num2str(years(myIndex)) ...
              '-' sprintf('%02d',months(myIndex)) '.eps'],'epsc2'); 
end

% some grid stuff
figure('color','w','visible','on');
m_proj('miller','long',[x0 x1]-360,'lat',[-78 y1]);
m_grid('xtick',[-60 -50 -40 -30 -20 -10],...
       'ytick',[ ],...
       'yticklabels',[],...
       'box','off',...
       'linestyle','none',...
       'xaxislocation','bottom');
saveas(gcf,'../reports/figures/bsose/xgrid.eps','epsc2');
% some y grid stuff
figure('color','w','visible','on');
m_proj('miller','long',[x0 x1]-360,'lat',[-78 y1]);
m_grid('xtick',[ ],...
       'ytick',[-75 -70 -65 -60 -55 -50],...
       'xticklabels',[],...
       'box','off',...
       'ticklength',0.0,...
       'linestyle','none',...
       'yaxislocation','left');
saveas(gcf,'../reports/figures/bsose/ygrid.eps','epsc2');

% colorbar
figure('color','w','visible','off');
ax = axes;
colormap(cividis);
c = colorbar(ax);
ax.Visible = 'off';
saveas(gcf,'../reports/figures/bsose/colorbar_cividis.eps','epsc2');
