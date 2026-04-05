import os
import shutil

# Define the training frames for each folder
train = {
    1: list(range(1, 57)),
    2: list(range(1, 91)),
    3: list(range(143, 147)),
    4: list(range(1, 27)),
    5: list(range(125, 147)),
    6: list(range(156, 177)),
    7: [],
    8: [],
    9: [],
    10: [],
    11: [],
    12: list(range(1, 84))
}

# Define source and destination directories
parent_dir = "path/to/parent/directory"  # Replace with actual path
dest_dir = os.path.join(parent_dir, "train_frames")

# Create destination directories if they don't exist
os.makedirs(os.path.join(dest_dir, "diff_at"), exist_ok=True)
os.makedirs(os.path.join(dest_dir, "diff_gt"), exist_ok=True)

# Process each folder
for folder_num in range(1, 13):
    folder_name = f"f{folder_num}"
    folder_path = os.path.join(parent_dir, folder_name)
    
    # Skip if folder doesn't exist
    if not os.path.exists(folder_path):
        print(f"Folder {folder_name} does not exist. Skipping.")
        continue
    
    # Process diff_at and diff_gt subfolders
    for subfolder in ['diff_at', 'diff_gt']:
        subfolder_path = os.path.join(folder_path, subfolder)
        
        # Skip if subfolder doesn't exist
        if not os.path.exists(subfolder_path):
            print(f"Subfolder {subfolder} in {folder_name} does not exist. Skipping.")
            continue
        
        # Copy and rename files
        for frame_num in train[folder_num]:
            source_file = os.path.join(subfolder_path, f"{frame_num:04d}.png")
            if os.path.exists(source_file):
                dest_file = os.path.join(dest_dir, subfolder, f"{frame_num:04d}_f{folder_num}.png")
                shutil.copy2(source_file, dest_file)
                print(f"Copied {source_file} to {dest_file}")
            else:
                print(f"File {source_file} does not exist. Skipping.")

print("File organization complete.")
