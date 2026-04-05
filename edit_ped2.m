% Load the original MAT file
data = load('ped2.mat');  % Replace with your file name

% Create a new 1x16 cell array
new_gt = cell(1, 16);

% Copy original values from the 1x12 cell array to the first 12 cells
for i = 1:min(12, length(data.gt))
    new_gt{i} = [1; 2];  % Replace each value with [1;2]
end

% Fill remaining cells (13-16) with [1;2]
for i = 13:16
    new_gt{i} = [1; 2];
end

% Replace the original gt with new_gt
data.gt = new_gt;

% Save as a new file
save('modified_ped2.mat', '-struct', 'data');