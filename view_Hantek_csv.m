clc
clear
close all

% desired plot axis units
timebase_mod = 'us';
voltbase_mod = 'mV';

% desired data file
a = importdata('./data/WaveData182.csv');

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
timebase = extractBetween(a.textdata(1),'=','(');
timebase = str2double(timebase{:});
timebase_unit = extractBetween(a.textdata(1),'(',')');

voltbase = extractBetween(a.textdata(2),'=','(');
voltbase = str2double(voltbase{:});
voltbase_unit = extractBetween(a.textdata(2),'(',')');

Sa_size = size(a.data,1);

% data occupy 20 time divisions
n_div = 20;

if strcmp(timebase_unit,'ps')
    switch timebase_mod
        case 'ps'
            timebase_unit = 'ps';
        case 'ns'
            timebase =  timebase / 1e3;
            timebase_unit = 'ns';
        case 'us'
            timebase =  timebase / 1e6;
            timebase_unit = 'us';
        case 'ms'
            timebase =  timebase / 1e9;
            timebase_unit = 'ms';
        case 's'
            timebase =  timebase / 1e12;
            timebase_unit = 's';
    end
end

if strcmp(voltbase_unit,'uV')
    switch voltbase_mod
        case 'uV'
            voltbase_unit = 'uV';
        case 'mV'
            voltbase =  voltbase / 1e3;
            voltbase_unit = 'mV';
        case 'V'
            voltbase =  voltbase / 1e6;
            voltbase_unit = 'V';
    end
end

% timeline
t = linspace(0,timebase*n_div,Sa_size);
% channels signals
Ch1 = a.data(:,1);
Ch2 = a.data(:,2);

% use fixed axis between subplots
ax = zeros(1,6);

figure
ax(1) = subplot(2,1,1);
plot(t,Ch1,'LineWidth',2)
title('Channel 1')
xlabel(['Time [',timebase_unit,']']);
ylabel(['Amplitude [',voltbase_unit,']']);
ax(2) = subplot(2,1,2);
plot(t,Ch2,'LineWidth',2)
title('Channel 2')
xlabel(['Time [',timebase_unit,']']);
ylabel(['Amplitude [',voltbase_unit,']']);

if any(ax)
    ax(~ax) = [];
    linkaxes(ax,'xy');
    zoom on;
end
