% Close all, clear variables, and clear command window
close all; clear; clc;

% Define input and output folders
inputFolder = 'C:\Users\harrouf\Desktop\Zine 3\Video anomaly detection\zuzheng Project\Testing\diff_at_1\Test1';
outputFolder = 'C:\Users\harrouf\Desktop\Zine 3\Video anomaly detection\zuzheng Project\Testing\diff_at_1\CombinedAttention';
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

% Get list of all residual images in the input folder
imageFiles = dir(fullfile(inputFolder, '*.jpg'));  % Change extension if necessary (e.g., '*.png')

% Parameters for attention
spatialThreshold = 0.3;  % Threshold for spatial saliency (normalized to [0, 1])
%Lower values (<0.5) include more regions, while higher values (>0.5) focus on stronger anomalies.

% Process each residual image
for i = 1:length(imageFiles)
    % Load residual image
    residualFile = fullfile(inputFolder, imageFiles(i).name);
    residualImage = imread(residualFile);
    
    % Ensure the image is grayscale
    if size(residualImage, 3) == 3
        residualImage = rgb2gray(residualImage);
    end
    
    % Normalize residual image to [0, 1]
    normalizedResidual = double(residualImage) / 255;
    
    % -----------------
    % Step 1: Extract Feature Maps
    % -----------------
   %  edges = edge(normalizedResidual, 'Canny');  % Edge map
   % sobelX = imfilter(double(residualImage), fspecial('sobel'));  % Sobel X gradient
   % sobelY = imfilter(double(residualImage), fspecial('sobel')'); % Sobel Y gradient
    
    % Stack feature maps
    %featureMaps = cat(3, normalizedResidual, edges, abs(sobelX), abs(sobelY));


    % -----------------
% Generate feature maps Option 2
    % -----------------
LoGMap = imfilter(double(residualImage), fspecial('log', [5 5], 0.5));
prewittX = imfilter(double(residualImage), fspecial('prewitt'));
prewittY = imfilter(double(residualImage), fspecial('prewitt')');
PrewittMagnitude = sqrt(prewittX.^2 + prewittY.^2);

% Stack feature maps
featureMaps = cat(3, normalizedResidual, LoGMap, PrewittMagnitude);




    
    % -----------------
    % Step 2: Apply Channel Attention
    % -----------------
    % Compute channel weights based on mean intensity
    channelWeights = squeeze(mean(mean(featureMaps, 1), 2));  % Average intensity per channel
    channelWeights = channelWeights / sum(channelWeights);  % Normalize weights
    
    % Apply channel attention (weighted combination of feature maps)
    channelAttention = sum(featureMaps .* reshape(channelWeights, 1, 1, []), 3);
    
    % -----------------
    % Step 3: Apply Spatial Attention
    % -----------------
    % Generate spatial attention map
    spatialAttention = channelAttention;  % Start with channel attention
    spatialAttention(spatialAttention < spatialThreshold) = 0;  % Suppress low-intensity regions
    
    % Enhance residual using spatial attention
    enhancedResidual = channelAttention .* spatialAttention;
    
    % Normalize the enhanced residual for output
    enhancedResidual = uint8(255 * mat2gray(enhancedResidual));
    
    % -----------------
    % Step 4: Save the Enhanced Residual Image
    % -----------------
    outputFilePath = fullfile(outputFolder, imageFiles(i).name);
    imwrite(enhancedResidual, outputFilePath);
end

disp('Combined spatial and channel attention applied. Enhanced residuals saved.');
