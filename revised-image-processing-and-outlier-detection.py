import os
import numpy as np
from PIL import Image
from typing import List, Dict
import matplotlib.pyplot as plt

def process_images(base_path: str) -> Dict[str, np.ndarray]:
    processed_data = {}

    # Process training data
    train_path = os.path.join(base_path, 'train_frames')
    train_data = []
    for img_name in os.listdir(train_path):
        img = Image.open(os.path.join(train_path, img_name)).convert('L')
        img_array = np.array(img, dtype=np.float32)
        train_data.append(np.square(img_array))
    processed_data['train'] = np.array(train_data)

    # Process test data
    for i in range(1, 13):
        folder = f'f{i}'
        gt_path = os.path.join(base_path, folder, 'diff_gt')
        at_path = os.path.join(base_path, folder, 'diff_at')
        
        test_data = []
        for img_name in os.listdir(gt_path):
            gt_img = Image.open(os.path.join(gt_path, img_name)).convert('L')
            at_img = Image.open(os.path.join(at_path, img_name)).convert('L')
            gt_array = np.array(gt_img, dtype=np.float32)
            at_array = np.array(at_img, dtype=np.float32)
            test_data.append(np.square(gt_array) + np.square(at_array))
        processed_data[folder] = np.array(test_data)

    return processed_data

def msplot(data: np.ndarray) -> List[int]:
    # Placeholder for the msplot function
    # You should replace this with the actual implementation
    # For now, we'll just return random indices as a dummy result
    return np.random.choice(len(data), size=20, replace=False).tolist()

def compare_with_ground_truth(detected_outliers: List[int], ground_truth: List[int]) -> Dict[str, float]:
    detected_set = set(detected_outliers)
    ground_truth_set = set(ground_truth)
    
    true_positives = len(detected_set.intersection(ground_truth_set))
    false_positives = len(detected_set - ground_truth_set)
    false_negatives = len(ground_truth_set - detected_set)
    
    precision = true_positives / (true_positives + false_positives) if (true_positives + false_positives) > 0 else 0
    recall = true_positives / (true_positives + false_negatives) if (true_positives + false_negatives) > 0 else 0
    f1_score = 2 * (precision * recall) / (precision + recall) if (precision + recall) > 0 else 0
    
    return {
        'precision': precision,
        'recall': recall,
        'f1_score': f1_score
    }

def main():
    base_path = '.'  # Adjust this to the path where your folders are located
    processed_data = process_images(base_path)

    ground_truth = [
        list(range(56, 176)),  # f1
        list(range(90, 176)),  # f2
        list(range(0, 142)),   # f3
        list(range(26, 176)),  # f4
        list(range(0, 125)),   # f5
        list(range(0, 155)),   # f6
        list(range(41, 176)),  # f7
        list(range(0, 176)),   # f8
        list(range(0, 116)),   # f9
        list(range(0, 146)),   # f10
        list(range(0, 176)),   # f11
        list(range(83, 176)),  # f12
    ]

    results = []
    for i in range(1, 13):
        folder = f'f{i}'
        combined_data = np.concatenate([processed_data['train'], processed_data[folder]])
        detected_outliers = msplot(combined_data)
        
        # Adjust detected outliers to match test set indices
        adjusted_outliers = [idx - 400 for idx in detected_outliers if idx >= 400]
        
        metrics = compare_with_ground_truth(adjusted_outliers, ground_truth[i-1])
        results.append((folder, metrics))

    # Print results
    for folder, metrics in results:
        print(f"{folder}:")
        print(f"  Precision: {metrics['precision']:.4f}")
        print(f"  Recall: {metrics['recall']:.4f}")
        print(f"  F1 Score: {metrics['f1_score']:.4f}")
        print()

if __name__ == "__main__":
    main()
