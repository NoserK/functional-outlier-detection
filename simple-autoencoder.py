import numpy as np
import tensorflow as tf
from tensorflow.keras import layers, models
from tensorflow.keras.preprocessing.image import ImageDataGenerator

# Define the autoencoder architecture
def build_autoencoder(input_shape):
    # Encoder
    encoder = models.Sequential([
        layers.Input(shape=input_shape),
        layers.Conv2D(32, (3, 3), activation='relu', padding='same'),
        layers.MaxPooling2D((2, 2), padding='same'),
        layers.Conv2D(16, (3, 3), activation='relu', padding='same'),
        layers.MaxPooling2D((2, 2), padding='same'),
        layers.Conv2D(8, (3, 3), activation='relu', padding='same'),
        layers.MaxPooling2D((2, 2), padding='same')
    ])

    # Decoder
    decoder = models.Sequential([
        layers.Conv2D(8, (3, 3), activation='relu', padding='same'),
        layers.UpSampling2D((2, 2)),
        layers.Conv2D(16, (3, 3), activation='relu', padding='same'),
        layers.UpSampling2D((2, 2)),
        layers.Conv2D(32, (3, 3), activation='relu', padding='same'),
        layers.UpSampling2D((2, 2)),
        layers.Conv2D(3, (3, 3), activation='sigmoid', padding='same')
    ])

    # Autoencoder
    autoencoder = models.Sequential([encoder, decoder])
    return autoencoder

# Load and preprocess data
def load_data(train_dir, test_dir, img_size=(64, 64), batch_size=32):
    train_datagen = ImageDataGenerator(rescale=1./255)
    test_datagen = ImageDataGenerator(rescale=1./255)

    train_generator = train_datagen.flow_from_directory(
        train_dir,
        target_size=img_size,
        batch_size=batch_size,
        class_mode='input'
    )

    test_generator = test_datagen.flow_from_directory(
        test_dir,
        target_size=img_size,
        batch_size=batch_size,
        class_mode='input'
    )

    return train_generator, test_generator

# Train the autoencoder
def train_autoencoder(autoencoder, train_generator, epochs=50):
    autoencoder.compile(optimizer='adam', loss='mean_squared_error')
    history = autoencoder.fit(train_generator, epochs=epochs)
    return history

# Generate reconstructed images from the test set
def generate_reconstructions(autoencoder, test_generator, num_images=10):
    test_images, _ = next(test_generator)
    reconstructed_images = autoencoder.predict(test_images[:num_images])
    return test_images[:num_images], reconstructed_images

# Main function to run the entire process
def main(train_dir, test_dir):
    # Set up parameters
    img_size = (64, 64)
    input_shape = (*img_size, 3)
    batch_size = 32
    epochs = 50

    # Load data
    train_generator, test_generator = load_data(train_dir, test_dir, img_size, batch_size)

    # Build and train autoencoder
    autoencoder = build_autoencoder(input_shape)
    history = train_autoencoder(autoencoder, train_generator, epochs)

    # Generate reconstructions
    original_images, reconstructed_images = generate_reconstructions(autoencoder, test_generator)

    # Here you can add code to visualize or save the results
    # For example, using matplotlib to display original and reconstructed images

    return autoencoder, history, original_images, reconstructed_images

# Replace these with your actual directory paths
train_dir = 'path/to/your/train/directory'
test_dir = 'path/to/your/test/directory'

autoencoder, history, original_images, reconstructed_images = main(train_dir, test_dir)
