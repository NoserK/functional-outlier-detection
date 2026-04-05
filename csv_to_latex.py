import pandas as pd

# Load the CSV file
file_path = '/Users/wangz0m/Desktop/fod/tprfpr.csv'
data = pd.read_csv(file_path, delimiter=',', header=None)

# Check the number of columns
if data.shape[1] == 1:
    data.columns = ['Value']
else:
    raise ValueError("Unexpected number of columns in CSV file")

# Process the data assuming it's a single column (adjust as needed)
# Example: Split into two columns artificially if required
# For demonstration, splitting into two equal parts
mid_index = len(data) // 2
data['TPR'] = data.iloc[:mid_index, 0].reset_index(drop=True)
data['FPR'] = data.iloc[mid_index:, 0].reset_index(drop=True)

# Rest of your code to process and generate LaTeX tables
num_rows = 12
num_tables = 16
latex_code = []

for table_num in range(num_tables):
    start_row = table_num * num_rows
    end_row = start_row + num_rows
    table_data = data.iloc[start_row:end_row]
    
    latex_code.append("\\begin{table}[h]\n\\centering\n\\caption{Table %d}\n\\begin{tabular}{|c|c|}\n\\hline" % (table_num + 1))
    latex_code.append("TPR & FPR \\\\\n\\hline")
    
    for _, row in table_data.iterrows():
        latex_code.append("%s & %s \\\\\n\\hline" % (row['TPR'], row['FPR']))
    
    latex_code.append("\\end{tabular}\n\\end{table}\n\n")

# Join all the LaTeX code into a single string
latex_code_str = '\n'.join(latex_code)

# Write the LaTeX code to a file
with open('/Users/wangz0m/Desktop/fod/output_tables.tex', 'w') as f:
    f.write(latex_code_str)

print("LaTeX code has been generated and saved to output_tables.tex")
