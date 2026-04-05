%fun plot
% Read the Excel file into a matrix
features = readmatrix('extracted_features_with_prefixes_vgg19_train.xlsx');  % Replace with your file path

% Number of features
num_features = size(features, 1);  % Number of columns in the feature matrix

% Define feature groups to display
groups_to_display = [3, 10, 180, num_features];  % First 3, 10, 180, and all features

% Loop over each group size and plot the features
for i = 1:length(groups_to_display)
    figure;  % Create a new figure for each group of features
    
    % Get the current number of features to display
    num_to_display = groups_to_display(i);
    
    % Plot the first 'num_to_display' features
    plot(features(1:num_to_display,2:50)');
    
    % Set the title and labels for the plot
    title(['Displaying First ', num2str(num_to_display), ' Features']);
    xlabel('Sample Index');
    ylabel('Feature Value');
    
    % Display a legend for the plot (showing which features are being displayed)
    % legend(arrayfun(@(x) ['Feature ', num2str(x)], 1:num_to_display, 'UniformOutput', false));
end

% Assume you have images corresponding to each feature vector, stored in a cell array
% image_paths = {'image1.jpg', 'image2.jpg', ..., 'imageN.jpg'};  % Replace with your image paths

%