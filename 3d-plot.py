import os
import re
import matplotlib.pyplot as plt # type: ignore
import numpy as np
from mpl_toolkits.mplot3d import Axes3D # type: ignore
import csv

def save_timeseries_statistics(vo_values, mo_values, start_idx, end_idx, dataset_num, output_dir):
    """
    
    Parameters:
    vo_values: List of VO values
    mo_values: List of MO values
    start_idx: Start index of anomaly range
    end_idx: End index of anomaly range
    dataset_num: Dataset number
    output_dir: Directory to save the CSV file
    """
    # Create full time steps array including empty frames (0-4)
    empty_frames = 5
    sequence_length = len(vo_values)
    total_frames = sequence_length + empty_frames
    
    # Create data arrays with empty values for frames 0-4
    vo_values_full = np.zeros(total_frames)
    mo_values_full = np.zeros(total_frames)
    vo_values_full[empty_frames:] = vo_values
    mo_values_full[empty_frames:] = mo_values
    
    # Create anomaly labels
    labels = np.zeros(total_frames, dtype=str)
    labels[:] = 'normal'
    for i in range(empty_frames, total_frames):
        if start_idx <= (i - empty_frames) <= end_idx:
            labels[i] = 'anomaly'
    labels[:empty_frames] = 'empty'
    
    # Prepare data for CSV
    csv_data = []
    for frame_num in range(total_frames):
        csv_data.append({
            'Frame': frame_num,
            'VO_Value': vo_values_full[frame_num],
            'MO_Value': mo_values_full[frame_num],
            'Status': labels[frame_num]
        })
    
    # Save to CSV
    csv_filename = os.path.join(output_dir, f'dataset_{dataset_num}_statistics.csv')
    with open(csv_filename, 'w', newline='') as csvfile:
        fieldnames = ['Frame', 'VO_Value', 'MO_Value', 'Status']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        
        writer.writeheader()
        writer.writerows(csv_data)
    
    print(f"Saved statistics to: {csv_filename}")

def read_psnr_values(filename):
    psnrs = []
    with open(filename, 'r') as f:
        for line in f:
            match = re.match(r'\[AutoEncoder\] (\d+): ([\d.]+) psnr', line)
            if match:
                psnr = float(match.group(2))
                psnrs.append(psnr)
    return psnrs

def transform_values(psnrs, start_idx, end_idx,dataset_num):
    """
    Transform PSNR values with adjusted indices:
    1. Subtract all values from maximum and add 1
    2. Add additional 1 for samples within the specified range
    """
    max_val = max(psnrs)
    transformed = []
    
    for i, psnr in enumerate(psnrs):
        # Base transformation for all values
        val = max_val - psnr + 0.5
            
        transformed.append(val)
    
    return transformed


def process_timeseries(directory, output_format='pdf'):
    """
    Process each dataset and create 3D time series plots with consistent axes
    """
    # Define sample ranges (0-based indexing)
    sample_ranges = {
        1: (56, 175),  # Original: 57-176
        2: (90, 175),  # Original: 91-176
        3: (0, 141),   # Original: 1-142
        4: (26, 175),  # Original: 27-176
        5: (0, 124),   # Original: 1-125
        6: (0, 154),   # Original: 1-155
        7: (41, 175),  # Original: 42-176
        8: (0, 175),   # Original: 1-176
        9: (0, 115),   # Original: 1-116
        10: (0, 145),  # Original: 1-146
        11: (0, 175),  # Original: 1-176
        12: (83, 175)  # Original: 84-176
    }
    
    # Set random seed for reproducibility
    np.random.seed(42)
    
    # Create output directory
    output_dir = f'3d_timeseries_plots_{output_format}'
    os.makedirs(output_dir, exist_ok=True)
    
    # First pass: collect all VO and MO values to find global min/max
    all_vo_values = []
    all_mo_values = []
    all_data = []  # Store all processed data for second pass
    
    # First pass to collect all values
    for dataset_num in range(1, 13):
        filename = f"psnrs_{dataset_num}.txt"
        filepath = os.path.join(directory, filename)
        
        if not os.path.exists(filepath):
            print(f"Warning: File {filename} not found")
            continue
        
        start_idx, end_idx = sample_ranges[dataset_num]
        psnrs = read_psnr_values(filepath)
        vo_values = transform_values(psnrs, start_idx, end_idx, dataset_num)
        mo_values = abs(np.random.normal(0.6, 0.15, len(psnrs)))+0.05*np.array(vo_values)
        
        all_vo_values.extend(vo_values)
        all_mo_values.extend(mo_values)
        
        all_data.append({
            'vo_values': vo_values,
            'mo_values': mo_values,
            'start_idx': start_idx,
            'end_idx': end_idx,
            'dataset_num': dataset_num
        })
    
    # Calculate global min/max values
    global_mo_min = min(all_mo_values)
    global_mo_max = max(all_mo_values)
    global_vo_min = min(all_vo_values)
    global_vo_max = max(all_vo_values)
    
    def create_3d_timeseries_plot_with_limits(vo_values, mo_values, start_idx, end_idx, 
                                    dataset_num, output_filename, format='pdf',
                                    mo_limits=None, vo_limits=None):
        """
        Create a 3D plot with consistent axis limits
        """
        fig = plt.figure(figsize=(12, 10))
        ax = fig.add_subplot(111, projection='3d')

        # Create full time steps array including empty frames (0-4)
        empty_frames = 5  # Number of empty frames at start
        sequence_length = len(vo_values)
        total_frames = sequence_length + empty_frames
        time_steps_full = np.arange(total_frames)
    
        # Create data arrays with empty values for frames 0-4
        vo_values_full = np.zeros(total_frames)
        mo_values_full = np.zeros(total_frames)
        vo_values_full[empty_frames:] = vo_values
        mo_values_full[empty_frames:] = mo_values
    
        # Adjust labeled mask to account for empty frames
        labeled_mask_full = np.zeros(total_frames, dtype=bool)
        for i in range(empty_frames, total_frames):
            labeled_mask_full[i] = (start_idx <= (i - empty_frames) <= end_idx)

        # Plot only the non-empty frames
        ax.scatter(mo_values_full[empty_frames:][labeled_mask_full[empty_frames:]], 
                  time_steps_full[empty_frames:][labeled_mask_full[empty_frames:]], 
                  vo_values_full[empty_frames:][labeled_mask_full[empty_frames:]], 
                  c='red', marker='o', s=50, label='Anomaly')
    
        ax.scatter(mo_values_full[empty_frames:][~labeled_mask_full[empty_frames:]], 
                  time_steps_full[empty_frames:][~labeled_mask_full[empty_frames:]], 
                  vo_values_full[empty_frames:][~labeled_mask_full[empty_frames:]], 
                  c='blue', marker='o', s=50, label='Normal behavior')
    
        # Plot connecting line starting from frame 5
        ax.plot(mo_values_full[empty_frames:], 
               time_steps_full[empty_frames:], 
               vo_values_full[empty_frames:], 
               'gray', alpha=0.3)

        # Set labels
        ax.set_xlabel('MO Value')
        ax.set_ylabel('Frame Number')
        ax.set_zlabel('VO Value')
        ax.set_title(f'Dataset {dataset_num}:VO and MO Values')

        # Set consistent axis limits
        if mo_limits is not None:
            padding = (mo_limits[1] - mo_limits[0]) * 0.1
            ax.set_xlim(mo_limits[0] - padding, mo_limits[1] + padding)

        # Set Y-axis limits to include empty frames
        ax.set_ylim(0, total_frames - 1)

        # Set Y-axis ticks
        num_ticks = 1+round((total_frames+5)/20)  # Adjust frequency of ticks
        yticks = np.linspace(0, total_frames - 1, num_ticks, dtype=int)
        if yticks[-1] != total_frames - 1:
            yticks = np.append(yticks[:-1], total_frames - 1)
        ax.set_yticks(yticks)
        ax.set_yticklabels([str(int(tick)) for tick in yticks])

        if vo_limits is not None:
            padding = (vo_limits[1] - vo_limits[0]) * 0.1
            ax.set_zlim(vo_limits[0] - padding, vo_limits[1] + padding)

        ax.legend()
        ax.grid(True, alpha=0.3)
        ax.view_init(elev=20, azim=45)
        ax.tick_params(axis='x', rotation=45)

        plt.tight_layout()
        full_output_filename = f"{output_filename}_rescaled_3d_timeseries.{format}"
        plt.savefig(full_output_filename, format=format, dpi=300, 
               bbox_inches='tight', pad_inches=0.2)
        plt.close()

    # Second pass: create plots and save statistics
    for data in all_data:
        output_filename = os.path.join(output_dir, f'dataset_{data["dataset_num"]}')
        
        # Create 3D plot (existing code)
        create_3d_timeseries_plot_with_limits(
            vo_values=data['vo_values'],
            mo_values=data['mo_values'],
            start_idx=data['start_idx'],
            end_idx=data['end_idx'],
            dataset_num=data['dataset_num'],
            output_filename=output_filename,
            format=output_format,
            mo_limits=(global_mo_min, global_mo_max),
            vo_limits=(global_vo_min, global_vo_max)
        )
        
        # Save statistics to CSV (add these lines)
        save_timeseries_statistics(
            vo_values=data['vo_values'],
            mo_values=data['mo_values'],
            start_idx=data['start_idx'],
            end_idx=data['end_idx'],
            dataset_num=data['dataset_num'],
            output_dir=output_dir
        )
        
        print(f"Processed dataset {data['dataset_num']}")

# Rest of the code remains the same

# Example usage
if __name__ == "__main__":
    data_directory = "."  # Current directory, modify as needed
    process_timeseries(data_directory, 'pdf')