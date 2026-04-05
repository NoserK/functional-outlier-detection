% Close all, clear variables, and clear command window
close all; clear; clc;

% Define input and output folders
inputFolder = 'C:\Users\harrouf\Desktop\Zine 3\Video anomaly detection\zuzheng Project\Testing\diff_at_1\Test1';
outputFolder = 'C:\Users\harrouf\Desktop\Zine 3\Video anomaly detection\zuzheng Project\Testing\diff_at_1\SpatialAttention';
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

% Get list of all residual images in the input folder
imageFiles = dir(fullfile(inputFolder, '*.jpg'));  % Change extension if necessary (e.g., '*.png')

% Parameters for saliency-based spatial attention
threshold = 0.6;  % Intensity threshold for saliency (normalized to [0, 1])

% Process each residual image
for i = 1:length(imageFiles)
    % Load residual image
    residualFile = fullfile(inputFolder, imageFiles(i).name);
    residualImage = imread(residualFile);
    
    % Ensure the image is grayscale
    if size(residualImage, 3) == 3
        residualImage = rgb2gray(residualImage);
    end
    
    % Normalize residual image to [0, 1] range
    normalizedResidual = double(residualImage) / 255;
    
    % Generate saliency-based attention map
    attentionMap = normalizedResidual;
    attentionMap(attentionMap < threshold) = 0;  % Suppress low-intensity regions
    
    % Enhance residuals using the attention map
    enhancedResidual = uint8(255 * (normalizedResidual .* attentionMap));
    
    % Save enhanced residual image
    outputFilePath = fullfile(outputFolder, imageFiles(i).name);
    imwrite(enhancedResidual, outputFilePath);
end

disp('Spatial attention applied and enhanced residuals saved.');
