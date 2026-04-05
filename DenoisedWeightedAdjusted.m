% Close all, clear variables, and clear command window
close all; clear; clc;

% Define input and output folders
inputFolder = 'C:\Users\harrouf\Desktop\Zine 3\Video anomaly detection\zuzheng Project\Testing\diff_at_1\Test';
outputFolder = 'C:\Users\harrouf\Desktop\Zine 3\Video anomaly detection\zuzheng Project\Testing\diff_at_1\Denoised_WeightedAdjusted';
txtOutputFolder = fullfile(outputFolder, 'TXT_Files');  % Subfolder for TXT files
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end
if ~exist(txtOutputFolder, 'dir')
    mkdir(txtOutputFolder);
end

% Get list of all images in the input folder
imageFiles = dir(fullfile(inputFolder, '*.jpg'));  % Change extension as needed (e.g., '*.png')

% Define wavelet parameters
waveletName = 'haar';  % Wavelet type
decompositionLevel = 2;  % Number of decomposition levels
thresholdMode = 's';  % Use 's' for soft thresholding or 'h' for hard thresholding
thresholdValue = 0.02;  % Threshold value (adjust as needed)

% Define thresholds for adaptive weighting
pixelThreshold = 128;  % Intensity threshold for applying weight
varianceThreshold = 500;  % Variance threshold to suppress weighting in low-variance frames

% Process each image
for i = 1:length(imageFiles)
    % Load the image
    inputFilePath = fullfile(inputFolder, imageFiles(i).name);
    originalImage = imread(inputFilePath);
    
    % Ensure the image is grayscale
    if size(originalImage, 3) == 3
        originalImage = rgb2gray(originalImage);
    end
    
    % Perform wavelet decomposition
    [C, S] = wavedec2(double(originalImage), decompositionLevel, waveletName);
    
    % Apply thresholding to detail coefficients
    coeffIndex = 1;  % Start index for coefficients in C
    for level = 1:decompositionLevel
        [H, V, D] = detcoef2('all', C, S, level);
        H = wthresh(H, thresholdMode, thresholdValue);
        V = wthresh(V, thresholdMode, thresholdValue);
        D = wthresh(D, thresholdMode, thresholdValue);
        
        % Update coefficients in C
        numCoeffs = numel(H) + numel(V) + numel(D);
        C(coeffIndex:(coeffIndex + numCoeffs - 1)) = [H(:); V(:); D(:)];
        coeffIndex = coeffIndex + numCoeffs;  % Move to the next set of coefficients
    end
    
    % Reconstruct the denoised image
    denoisedImage = waverec2(C, S, waveletName);
    denoisedImage = uint8(denoisedImage);  % Convert back to uint8
    
    % Calculate frame variance
    frameVariance = var(double(denoisedImage(:)));
    
    % Apply adaptive weighting
    if frameVariance > varianceThreshold
        % Highlight pixels above intensity threshold
        weightedImage = double(denoisedImage);
        weightedImage(weightedImage > pixelThreshold) = weightedImage(weightedImage > pixelThreshold).^3;
        
        % Normalize back to 0-255 range
        weightedImage = uint8(255 * (weightedImage / max(weightedImage(:))));
    else
        % Suppress weighting for low-variance frames
        weightedImage = denoisedImage;
    end
    
    % Save the weighted denoised image
    outputFilePath = fullfile(outputFolder, imageFiles(i).name);
    imwrite(weightedImage, outputFilePath);
    
    % Save the image as a text file
    txtFilePath = fullfile(txtOutputFolder, [imageFiles(i).name, '.txt']);
    writematrix(weightedImage, txtFilePath, 'Delimiter', ' ');
end

disp('Denoising and adaptive weighting complete. Images saved to both image and text formats.');
