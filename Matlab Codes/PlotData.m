clear;
clc;

% use importfile function to import .csv file into table, starting from the
% second row
T = importfile("BajaTest_02-12-20_16-45-32.csv", [2, Inf]);
% sort the table by sensor name
T = sortrows(T,'sensor');

% count how many of each sensor there is using countcats and save into
% vector
type_count = countcats(T.sensor);

% extract only sensor HE1 rows from table based on type count. must match
% corresponding index of type_count.
he1 = T.value(1:type_count(1));
% convert hour and minute to second, add them with second for only sensor
% HE1 rows
he1_time = T.hour(1:type_count(1))*3600 + T.min(1:type_count(1))*60 +T.sec(1:type_count(1));
%repeat for other sensor types
he2 = T.value(type_count(1)+1:end);
he2_time = T.hour(type_count(1)+1:end)*3600 + T.min(type_count(1)+1:end)*60 +T.sec(type_count(1)+1:end);

% free memory used by table
clear T;

createfigure(he1_time, he1, he2_time, he2)





function importTable = importfile(filename, dataLines)
%IMPORTFILE Import data from a text file
%  IMPORTTABLE = IMPORTFILE(FILENAME) reads data from text file
%  FILENAME for the default selection.  Returns the data as a table.
%
%  IMPORTTABLE = IMPORTFILE(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  T = importfile("C:\Users\kryst\Desktop\senior design\Matlab Codes\BajaTest_02-12-20_16-45-32.csv", [2, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 19-Feb-2020 19:16:00

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [2, Inf];
end

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 5);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = [",", ":"];

% Specify column names and types
opts.VariableNames = ["sensor", "value", "hour", "min", "sec"];
opts.VariableTypes = ["categorical", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "sensor", "EmptyFieldRule", "auto");

% Import the data
importTable = readtable(filename, opts);

end


function createfigure(X1, Y1, X2, Y2)

figure1 = figure('WindowState','maximized');
axes1 = axes('Parent',figure1);
hold(axes1,'on');

yyaxis(axes1,'left');
plot(X1,Y1,'DisplayName','Primary','Marker','.',...
    'LineStyle','none')

% Create ylabel
ylabel('Primary RPM');

% Create xlabel
xlabel('Time (s)');

yyaxis(axes1,'right');
plot(X2,Y2,'DisplayName','Secondary','Marker','.',...
    'LineStyle','none')

% Create ylabel
ylabel('Secondary RPM');

% Create title
title({'RPM of Primary and Secondary','QS 2000'});

end
