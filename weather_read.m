function weatherData = weather_read(csvFile)
    options = detectImportOptions(csvFile);
    table = readtable(csvFile, options);

    % Verify the existance of needed columns within the CSV file
    requiredColumns = {'date', 'max_temperature', 'min_temperature', 'avg_temperature',  ...
        'max_pressure_station', 'min_pressure_station', 'avg_pressure_station',  ...
        'max_relative_humidity', 'min_relative_humidity', 'avg_relative_humidity', ...
        'max_wind_speed', 'min_wind_speed', 'avg_wind_speed'};

    % Missing columns are defined by the required columns not being present
    % in file
    missingColumns = requiredColumns(~ismember(requiredColumns, table.Properties.VariableNames));
    if ~isempty(missingColumns)
        error("Missing columns detected. Please make sure file format is correct. ");
    end

    % Sort by date and time in every CSV file for graphing later
    if ~isdatetime(table.date)
        table.date = datetime(table.date, 'InputFormat', 'yyyy-MM-dd');
    end

    % Sort date and time by oldest to newest for graphing
    table = sortrows(table, 'date');
    weatherData.date = table.date;

    % Mapping temperature from table
    weatherData.temperature.max = numericColumn(table, 'max_temperature');
    weatherData.temperature.min = numericColumn(table, 'min_temperature');
    weatherData.temperature.avg = numericColumn(table, 'avg_temperature');

    % Mapping pressure from table
    weatherData.pressure.max = numericColumn(table, 'max_pressure_station');
    weatherData.pressure.min = numericColumn(table, 'min_pressure_station');
    weatherData.pressure.avg = numericColumn(table, 'avg_pressure_station');

    % Mapping humidity from table
    weatherData.humidity.max = numericColumn(table, 'max_relative_humidity');
    weatherData.humidity.min = numericColumn(table, 'min_relative_humidity');
    weatherData.humidity.avg = numericColumn(table, 'avg_relative_humidity');

    % Mapping wind speed from table
    weatherData.speed.max = numericColumn(table, 'max_wind_speed');
    weatherData.speed.min = numericColumn(table, 'min_wind_speed');
    weatherData.speed.avg = numericColumn(table, 'avg_wind_speed');
end

% Return the table as double values and convert empty values to NaN
function col = numericColumn(table, name)
    col = table.(name);
    if iscell(col) || isstring(col)
        col = str2double(col);
    end
    col = double(col);
end