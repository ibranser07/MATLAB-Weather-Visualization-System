function plot_speed(weatherData)
    % Colors to use for the bar graph
    colors = [1 0 0; 0 0 1; 0 1 0];

    % Stats and variation to be used for the bar graph
    stats = [max(weatherData.speed.max, [], 'omitnan'), min(weatherData.speed.min, [], 'omitnan'), ...
        mean(weatherData.speed.avg, 'omitnan')];
    variation = [std(weatherData.speed.max, 0, 'omitnan'), std(weatherData.speed.min, 0, 'omitnan'), ...
        std(weatherData.speed.avg, 0, 'omitnan')];

    % Bar graph with min, maximum and average values with variation
    figure;
    tiledlayout(2, 1, "TileSpacing", 'compact', 'Padding', 'compact');
    nexttile;
    barGraph = bar(stats, 'FaceColor', 'flat');
    barGraph.CData = colors;
    hold on;
    errorbar(1:3, stats, variation, 'k', 'LineStyle', 'none', 'LineWidth', 1.2);
    hold off;
    set(gca, 'XTickLabel', {'Maximum', 'Minimum', 'Average'});
    ylabel('Wind Speed (km/h)');
    title('Speed min, max and avg over period with std dev');
    grid on;

    % Scatter plot showing the minimum, max and average for every day
    nexttile;
    scatter(weatherData.date, weatherData.speed.max, 15, 'filled', 'MarkerFaceColor', colors(1,:));
    hold on;
    scatter(weatherData.date, weatherData.speed.min, 15, 'filled', 'MarkerFaceColor', colors(2,:));
    scatter(weatherData.date, weatherData.speed.avg, 15, 'filled', 'MarkerFaceColor', colors(3,:));
    hold off;
    xlabel('Dates');
    ylabel('Wind Speed (km/h)');
    title(sprintf('Daily Wind Speed: %s to %s', datestr(weatherData.date(1), 'yyyy-mm-dd'), ...
    datestr(weatherData.date(end), 'yyyy-mm-dd')));
    legend({'Daily Maximum', 'Daily Minimum', 'Daily Average'}, 'Location', 'best');
    grid on;
end