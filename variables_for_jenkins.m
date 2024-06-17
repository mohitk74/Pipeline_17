clc;clear all;
% Read the table from Excel sheet & store the table in the variable named 'data'
data=readtable('Wiper_washer_inputs.xlsx');
%-----------------------------------------------------------------------------------------------------
% Get the time data from the 1st column of the table.
% NOTE : Time data must be the first column of the excel sheet & must be written in 'Time' format only
time=seconds(data.Time(2:end));
%-----------------------------------------------------------------------------------------------------
for i = 2:width(data)
    % Extract data of each variable from excel sheet.
    var = data{2:end,i};
    % var_type is a variable that stores the values 197,199 etc.
    % NOTE : 197 must be only used for Boolean values.
    % NOTE : 199 must be only used for double values.
    % NOTE : The 2nd row of the excel sheet must be having the above values to classify the data type.
    var_type = data{1,i};
    if var_type == 197
        var = logical(var);
    else
        var = double(var);
    end
    % To read the variable names & store them in varName.
    varName = data.Properties.VariableNames{i};
    % Create timetable and load it to the workspace
    T = timetable(time,var);
    assignin('base',varName,T);
end
%-----------------------------------------------------------------------------------------------------
save("acd.mat")
