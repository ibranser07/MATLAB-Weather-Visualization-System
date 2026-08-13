clc;

% Prompts the user to select the file to load, allows cancellation
[file, location] = uigetfile('*.csv');
if isequal(file, 0)
    disp('File selection cancelled. ');
    return;
end
csvFile = fullfile(location, file);

% Loads the file and required columns using this function
weatherData = weather_read(csvFile);

% Confirmation for user which range of data is loaded
fprintf('Loaded data from dates: %s to %s\n\n', datestr(weatherData.date(1), 'yyyy-mm-dd'), ...
    datestr(weatherData.date(end), 'yyyy-mm-dd'));

% Asks the user which metric to visualize within the code
fprintf("Metrics to Visualize: \n1. Temperature \n2. Pressure \n3. Humidity " + ...
    "\n4. Wind Speed\n\n");
choice = input("Enter the number for the metric to visualize: ");

% Map to the appropriate function
if (choice == 1)
    plot_temperature(weatherData);
elseif (choice == 2)
    plot_pressure(weatherData);
elseif (choice == 3)
    plot_humidity(weatherData);
elseif (choice == 4)    
    plot_speed(weatherData);
else
    disp("Not a valid choice.");
    return;
end