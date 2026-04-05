clear;
close all;
clc;

% Load the pre-trained VGG-16 network
net = vgg19;

% Specify the layer from which to extract features
layer = 'fc7';

% Path to the UCSD Ped2 dataset Train directory
trainDir = '/Users/wangz0m/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train';

% Get a list of all subfolders in the train directory
subFolders = dir(fullfile(trainDir, 'Train*'));

% Initialize a matrix to hold the features
allFeaturesTrain = [];

% Loop through each subfolder
for k = 1:length(subFolders)
    % Get the full path of the subfolder
    subFolderPath = fullfile(trainDir, subFolders(k).name);
    
    % Get the folder name (e.g., 'train001')
    folderName = subFolders(k).name;
    
    % Get a list of all TIF files in the subfolder
    tifFiles = dir(fullfile(subFolderPath, '*.tif'));
    
    % Loop through each TIF file in the subfolder
    for i = 1:length(tifFiles)
        % Get the full path of the TIF file
        tifFile = fullfile(subFolderPath, tifFiles(i).name);
        
        % Read the TIF file
        img = imread(tifFile);
        
        % Convert grayscale to RGB if necessary
        if size(img, 3) == 1
            img = repmat(img, [1, 1, 3]);  % Replicate grayscale to RGB
        end
        
        % Resize the image to the input size of the VGG-19 network
        inputSize = net.Layers(1).InputSize(1:2);
        img = imresize(img, inputSize);
        
        % Extract features using the specified layer
        imgFeatures = activations(net, img, layer, 'OutputAs', 'rows');
        
        % Create a prefix combining the folder name and image name
        prefix = sprintf('%s', folderName);
        
        % Store the prefix and features in the cell array
        allFeaturesTrain = [allFeaturesTrain; [{prefix}, num2cell(imgFeatures)]];
    end
end

% Determine the number of features based on one of the images
numFeatures = size(imgFeatures, 2);

% Define the feature names
featureNames = arrayfun(@(x) sprintf('Feature_%d', x), 1:numFeatures, 'UniformOutput', false);

% Convert the cell array to a table for easier export
allFeaturesTableTrain = cell2table(allFeaturesTrain, 'VariableNames', [{'ImageName'}, featureNames]);

% Display the size of the allFeaturesTable
disp(size(allFeaturesTableTrain));

% Export the table to an Excel file
filename = 'extracted_features_with_prefixes_vgg19_train.xlsx';
writetable(allFeaturesTableTrain, filename);



%%%%%%%%%%%%%%%%Testing data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Path to the UCSD Ped2 dataset Train directory
testDir = '/Users/wangz0m/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test';

% Get a list of all subfolders in the train directory
subFolders = dir(fullfile(testDir, 'Test*'));

% Initialize a matrix to hold the features
allFeaturesTest = [];

% Loop through each subfolder
for k = 1:length(subFolders)
    % Get the full path of the subfolder
    subFolderPath = fullfile(testDir, subFolders(k).name);
    
    % Get the folder name (e.g., 'test001')
    folderName = subFolders(k).name;
    
    % Get a list of all TIF files in the subfolder
    tifFiles = dir(fullfile(subFolderPath, '*.tif'));
    
    % Loop through each TIF file in the subfolder
    for i = 1:length(tifFiles)
        % Get the full path of the TIF file
        tifFile = fullfile(subFolderPath, tifFiles(i).name);
        
        % Read the TIF file
        img = imread(tifFile);
        
        % Convert grayscale to RGB if necessary
        if size(img, 3) == 1
            img = repmat(img, [1, 1, 3]);  % Replicate grayscale to RGB
        end
        
        % Resize the image to the input size of the VGG-19 network
        inputSize = net.Layers(1).InputSize(1:2);
        img = imresize(img, inputSize);
        
        % Extract features using the specified layer
        imgFeatures = activations(net, img, layer, 'OutputAs', 'rows');
        
        % Create a prefix combining the folder name and image name
        prefix = sprintf('%s', folderName);
        
        % Store the prefix and features in the cell array
        allFeaturesTest = [allFeaturesTest; [{prefix}, num2cell(imgFeatures)]];
    end
end

% Determine the number of features based on one of the images
numFeatures = size(imgFeatures, 2);

% Define the feature names
featureNames = arrayfun(@(x) sprintf('Feature_%d', x), 1:numFeatures, 'UniformOutput', false);

% Convert the cell array to a table for easier export
allFeaturesTableTest = cell2table(allFeaturesTest, 'VariableNames', [{'ImageName'}, featureNames]);

% Display the size of the allFeaturesTable
disp(size(allFeaturesTableTest));

% Export the table to an Excel file
filename = 'extracted_features_with_prefixes_vgg19_test.xlsx';
writetable(allFeaturesTableTest, filename);