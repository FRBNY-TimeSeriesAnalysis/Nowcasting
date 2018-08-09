%%% Dynamic factor model (DFM) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script estimates a dynamic factor model (DFM) using a panel of
% monthly and quarterly series.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Clear workspace and set paths.
close all; clear; clc;
addpath('functions');


%% User inputs.
vintage = '2016-06-29'; % vintage dataset to use for estimation
country = 'US';         % United States macroeconomic data
sample_start  = datenum('2000-01-01','yyyy-mm-dd'); % estimation sample


%% Load model specification and dataset.
% Load model specification structure `Spec`
Spec = load_spec('Spec_US_example.xls');
% Parse `Spec`
SeriesID = Spec.SeriesID; SeriesName = Spec.SeriesName; Units = Spec.Units; UnitsTransformed = Spec.UnitsTransformed;
% Load data
datafile = fullfile('data',country,[vintage '.xls']);
[X,Time,Z] = load_data(datafile,Spec,sample_start);
summarize(X,Time,Spec,vintage); % summarize data


%% Plot raw and transformed data.
% Industrial Production (INDPRO) <fred.stlouisfed.org/series/INDPRO>
idxSeries = strcmp('INDPRO',SeriesID); t_obs = ~isnan(X(:,idxSeries));
figure('Name',['Data - ' SeriesName{idxSeries}]);

subplot(2,1,1); box on;
plot(Time(t_obs),Z(t_obs,idxSeries)); title('raw observed data');
ylabel(Units{idxSeries}); xlim(Time([1 end])); datetick('x','yyyy','keeplimits');

subplot(2,1,2); box on;
plot(Time(t_obs),X(t_obs,idxSeries)); title('transformed data');
ylabel(UnitsTransformed{idxSeries}); xlim(Time([1 end])); datetick('x','yyyy','keeplimits');
pause(1); % to display plot


%% Run dynamic factor model (DFM) and save estimation output as 'ResDFM'.
threshold = 1e-4; % Set to 1e-5 for more robust estimates

Res = dfm(X,Spec,threshold);
save('ResDFM','Res','Spec');


%% Plot common factor and standardized data.
idxSeries = strcmp('INDPRO',SeriesID);
figure('Name','Common Factor and Standardized Data');
plot(Time,Res.x_sm,':'); hold on;
h = plot(Time,Res.Z(:,1)*Res.C(idxSeries,1),'k','LineWidth',1.5); box on;
xlim(Time([1 end])); datetick('x','yyyy','keeplimits');
legend(h,'common factor'); legend boxoff;
pause(5); % to display plot


%% Plot projection of common factor onto Payroll Employment and GDP.
idxSeries = strcmp('PAYEMS',SeriesID); t_obs = ~isnan(X(:,idxSeries));
figure('Name','Common Factor Projection');

subplot(2,1,1); % projection of common factor onto PAYEMS
CommonFactor = Res.C(idxSeries,1:5)*Res.Z(:,1:5)'*Res.Wx(idxSeries)+Res.Mx(idxSeries);
plot(Time,CommonFactor,'k'); hold on;
plot(Time(t_obs),X(t_obs,idxSeries),'b'); box on;
title(SeriesName{idxSeries}); xlim(Time([1 end])); datetick('x','yyyy','keeplimits');
ylabel({Units{idxSeries}, UnitsTransformed{idxSeries}});
legend('common component','data'); legend boxoff;

subplot(2,1,2); % projection of common factor onto GDPC1
idxSeries = strcmp('GDPC1',SeriesID); t_obs = ~isnan(X(:,idxSeries));
CommonFactor = Res.C(idxSeries,1:5)*Res.Z(:,1:5)'*Res.Wx(idxSeries)+Res.Mx(idxSeries);
plot(Time,CommonFactor,'k'); hold on;
plot(Time(t_obs), X(t_obs,idxSeries),'b'); box on;
title(SeriesName{idxSeries}); xlim(Time([1 end])); datetick('x','yyyy','keeplimits');
ylabel({Units{idxSeries},UnitsTransformed{idxSeries}});
legend('common component','data'); legend boxoff;

