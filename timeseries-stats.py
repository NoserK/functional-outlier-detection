import csv

def save_timeseries_statistics(vo_values, mo_values, start_idx, end_idx, dataset_num, output_dir):
    """
    Save VO and MO statistics for each frame to a CSV file.
    
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

# Modify the process_timeseries function by adding these lines after creating the 3D plot:
def process_timeseries(directory, output_format='pdf'):
    # ... [existing code remains the same until the second pass] ...
    
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
