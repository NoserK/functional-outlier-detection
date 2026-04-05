import os
import numpy as np
from PIL import Image
import csv

def process_subfolder(subfolder_path):
    statistics = []
    for filename in os.listdir(subfolder_path):
        if filename.lower().endswith(('.png', '.jpg', '.jpeg', '.tiff', '.bmp', '.gif')):
            img_path = os.path.join(subfolder_path, filename)
            with Image.open(img_path).convert('L') as img:
                img_array = np.array(img)
                median = np.median(img_array)
                upper_quartile = np.percentile(img_array, 75)
                maximum = np.max(img_array)
                statistics.append([filename, median, upper_quartile, maximum])
    return statistics

def save_statistics(statistics, output_path):
    with open(output_path, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['Filename', 'Median', 'Upper Quartile', 'Maximum'])
        writer.writerows(statistics)

def main():
    base_folder = '.'  # Change this to the path of your main folder if it's not in the current directory
    for i in range(1, 13):
        folder_name = f'f{i}'
        folder_path = os.path.join(base_folder, folder_name)
        if os.path.isdir(folder_path):
            print(f"Processing folder: {folder_name}")
            
            for subfolder in ['diff_at', 'diff_gt']:
                subfolder_path = os.path.join(folder_path, subfolder)
                if os.path.isdir(subfolder_path):
                    print(f"  Processing subfolder: {subfolder}")
                    statistics = process_subfolder(subfolder_path)
                    output_path = os.path.join(folder_path, f'{subfolder}_grayscale_statistics.csv')
                    save_statistics(statistics, output_path)
                    print(f"  Statistics saved to: {output_path}")
                else:
                    print(f"  Subfolder not found: {subfolder_path}")

if __name__ == "__main__":
    main()
