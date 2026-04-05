import numpy as np
from PIL import Image
import os

def generate_random_binary_images(num_images=200, size=(256, 256), output_folder='random_frames'):
    # Create the output folder if it doesn't exist
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    for i in range(num_images):
        # Generate a random binary matrix
        matrix = np.random.randint(0, 2, size=size, dtype=np.uint8)
        
        # Convert to grayscale image (0 -> 0, 1 -> 255)
        image = Image.fromarray(matrix * 255, mode='L')
        
        # Save the image
        image_path = os.path.join(output_folder, f'random_frame_{i:03d}.png')
        image.save(image_path)

    print(f"{num_images} random binary images have been generated and saved in '{output_folder}'")

# Run the function
generate_random_binary_images()
