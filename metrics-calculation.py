import pandas as pd

def calculate_metrics(tp, fp, tn, fn):
    tpr = tp / (tp + fn) if tp + fn > 0 else 0
    fpr = fp / (fp + tn) if fp + tn > 0 else 0
    accuracy = (tp + tn) / (tp + tn + fp + fn)
    precision = tp / (tp + fp) if tp + fp > 0 else 0
    recall = tp / (tp + fn) if tp + fn > 0 else 0
    f1_score = 2 * precision * recall / (precision + recall) if precision + recall > 0 else 0
    return tpr, fpr, accuracy, precision, recall, f1_score

data = pd.read_csv('vectorized_result.csv')

latex_table = "\\begin{table}[htbp]\n\\centering\n\\begin{tabular}{c|cccccc|cccccc|cccccc}\n"
latex_table += "\\hline\n"
latex_table += "& \\multicolumn{6}{c|}{fbplot} & \\multicolumn{6}{c|}{tvdmss} & \\multicolumn{6}{c}{msplot vectorized} \\\\\n"
latex_table += "Sample & TPR & FPR & Accuracy & Precision & Recall & F1-Score & TPR & FPR & Accuracy & Precision & Recall & F1-Score & TPR & FPR & Accuracy & Precision & Recall & F1-Score \\\\\n"
latex_table += "\\hline\n"

for sample in range(1, 13):
    fbplot_metrics = calculate_metrics(
        data.loc[data['fbplot result'] == sample, 'true_positive'].iloc[0],
        data.loc[data['fbplot result'] == sample, 'false_positive'].iloc[0],
        data.loc[data['fbplot result'] == sample, 'true_negetive'].iloc[0],
        data.loc[data['fbplot result'] == sample, 'false_negative'].iloc[0]
    )
    
    tvdmss_metrics = calculate_metrics(
        data.loc[data['tvdmss result'] == sample, 'true_positive'].iloc[0],
        data.loc[data['tvdmss result'] == sample, 'false_positive'].iloc[0],
        data.loc[data['tvdmss result'] == sample, 'true_negetive'].iloc[0],
        data.loc[data['tvdmss result'] == sample, 'false_negative'].iloc[0]
    )
    
    msplot_metrics = calculate_metrics(
        data.loc[data['msplot vectorized result'] == sample, 'true_positive'].iloc[0],
        data.loc[data['msplot vectorized result'] == sample, 'false_positive'].iloc[0],
        data.loc[data['msplot vectorized result'] == sample, 'true_negetive'].iloc[0],
        data.loc[data['msplot vectorized result'] == sample, 'false_negative'].iloc[0]
    )
    
    latex_table += f"{sample} & {fbplot_metrics[0]:.3f} & {fbplot_metrics[1]:.3f} & {fbplot_metrics[2]:.3f} & {fbplot_metrics[3]:.3f} & {fbplot_metrics[4]:.3f} & {fbplot_metrics[5]:.3f} & {tvdmss_metrics[0]:.3f} & {tvdmss_metrics[1]:.3f} & {tvdmss_metrics[2]:.3f} & {tvdmss_metrics[3]:.3f} & {tvdmss_metrics[4]:.3f} & {tvdmss_metrics[5]:.3f} & {msplot_metrics[0]:.3f} & {msplot_metrics[1]:.3f} & {msplot_metrics[2]:.3f} & {msplot_metrics[3]:.3f} & {msplot_metrics[4]:.3f} & {msplot_metrics[5]:.3f} \\\\\n"

latex_table += "\\hline\n\\end{tabular}\n\\caption{Performance metrics for each method and sample}\n\\label{tab:metrics}\n\\end{table}"

print(latex_table)
