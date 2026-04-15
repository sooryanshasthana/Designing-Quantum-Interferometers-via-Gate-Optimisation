clc
clear

load("shadowscalingdata.mat")

mssms = 1:2:15;
avFvals = permute(mean(Fvals,1),[3,2,1]);
% --------------------------------------------------------------------------

% --- 2. Setup Variables ---
plotxvals = linspace(1,16,50);
heisenberg = plotxvals.^2;
sql = plotxvals;
% X and Y data for the main plot
x_data_all = log(mssms(2:end));
y_data_all = -log(avFvals(2:end,:));

% --- 3. Plotting ---
figure('Color', 'w', 'Position', [100 100 800 600]);
ax = gca;
hold on;

% A. Reference Lines (Use PLOT here, as these are lines, not points)
% We plot these first so they stay in the background
% h_heis = plot(log(plotxvals), log(heisenberg), ...
%     'Color', [0.6 0.6 0.6], 'LineWidth', 2, 'LineStyle', '--');
% h_sql  = plot(log(plotxvals), log(sql), ...
%     'Color', [0.6 0.6 0.6], 'LineWidth', 2, 'LineStyle', ':');

h_heis = plot(log(plotxvals), log(heisenberg), ...
    'Color', 'b', 'LineWidth', 2, 'LineStyle', '--');
h_sql  = plot(log(plotxvals), log(sql), ...
    'Color', 'r', 'LineWidth', 2, 'LineStyle', ':');

datplot = gobjects(1,6); 

% Define Styles
markers = {'o', 's', '^', 'd', 'v', '>'}; 
colors = [
    0.00, 0.45, 0.74;  % Blue
    0.85, 0.33, 0.10;  % Red
    0.93, 0.69, 0.13;  % Yellow
    0.49, 0.18, 0.56;  % Purple
    0.47, 0.67, 0.19;  % Green
    0.30, 0.75, 0.93   % Light Blue
];

for k = 1:6
    % Current X and Y
    current_x = x_data_all;
    current_y = y_data_all(:,k);
    
    % Create Scatter Object
    % Syntax: scatter(x, y, size, color, 'filled')
    % We start with 'filled' and 100 size, then tweak properties below.
    datplot(k) = scatter(current_x, current_y, 100, colors(k,:), 'filled');
    
    % --- Apply Strict Properties for Scatter Objects ---
    datplot(k).Marker = markers{k};
    datplot(k).MarkerEdgeColor = colors(k,:); % Always color the edge
    datplot(k).LineWidth = 1.5;               % Thicker edges for visibility
    
    if k <= 3
        % Group 1: Filled with Transparency
        datplot(k).MarkerFaceColor = colors(k,:);
        datplot(k).MarkerFaceAlpha = 0.6; % Valid for Scatter
        datplot(k).LineWidth=1 ;
    else
        % Group 2: Hollow (Open) Markers
        datplot(k).MarkerFaceColor = 'none'; % Transparent center
        datplot(k).MarkerEdgeColor = colors(k,:); 
        % Note: MarkerFaceAlpha doesn't matter if Color is 'none'
        
    end
end

% --- 4. Formatting ---

% Axis Limits & Ticks
ticknos = [1 2 3 4 6 8];
xticks(log(mssms(ticknos)))
xticklabels(num2str(mssms(ticknos)'))
xlim(log([2.5, 17]))
ylim([-8 8])



box on;
grid off;
set(gca, 'FontSize', 14, 'LineWidth', 1.2, 'TickDir', 'in');

% Labels
ylabel('$-\log(\delta \theta^2)$', 'Interpreter', 'latex', 'FontSize', 22)
xlabel('$n$', 'Interpreter', 'latex', 'FontSize', 22)


% Legend
% We construct the legend using the Scatter handles
lgd = legend([datplot, h_heis, h_sql], ...
    {'9.4-9.6', '9.6-9.8', '9.8-10.0', '10.0-10.2', '10.2-10.4', '10.4-10.6', 'Heisenberg', 'SQL'});
set(lgd, 'Interpreter', 'latex', 'FontSize', 14);
% legend boxoff