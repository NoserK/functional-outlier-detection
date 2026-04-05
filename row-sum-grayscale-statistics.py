import os
import numpy as np
from PIL import Image
import csv

def process_subfolder(subfolder_path):
    images = []
    image_names = []
    for filename in sorted(os.listdir(subfolder_path)):
        if filename.lower().endswith(('.png', '.jpg', '.jpeg', '.tiff', '.bmp', '.gif')):
            img_path = os.path.join(subfolder_path, filename)
            with Image.open(img_path).convert('L') as img:
                img_array = np.array(img)
                images.append(img_array)
                image_names.append(filename)

    if not images:
        return None, []

    # Sum the grayscale values row-wise across all images
    row_sums = np.sum(images, axis=0)

    # Calculate statistics on the row sums
    median = np.median(row_sums)
    upper_quartile = np.percentile(row_sums, 75)
    maximum = np.max(row_sums)

    return [median, upper_quartile, maximum], image_names

def save_statistics(statistics, image_names, output_path):
    with open(output_path, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['Statistic', 'Value'])
        writer.writerow(['Median of row sums', statistics[0]])
        writer.writerow(['Upper Quartile of row sums', statistics[1]])
        writer.writerow(['Maximum of row sums', statistics[2]])
        writer.writerow([])
        writer.writerow(['Images processed (in order):'])
        for name in image_names:
            writer.writerow([name])

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
                    statistics, image_names = process_subfolder(subfolder_path)
                    if statistics is not None:
                        output_path = os.path.join(folder_path, f'{subfolder}_row_sum_statistics.csv')
                        save_statistics(statistics, image_names, output_path)
                        print(f"  Statistics saved to: {output_path}")
                    else:
                        print(f"  No images found in: {subfolder_path}")
                else:
                    print(f"  Subfolder not found: {subfolder_path}")

if __name__ == "__main__":
    main()
