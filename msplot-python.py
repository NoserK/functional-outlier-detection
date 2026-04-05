import numpy as np
import matplotlib.pyplot as plt
from typing import Union, List, Dict

def msplot(dts: Union[np.ndarray, List[List[float]]],
           data_depth: str = "random_projections",
           n_projections: int = 200,
           seed: Union[int, None] = None,
           return_mvdir: bool = True,
           plot: bool = True,
           plot_title: str = "Magnitude Shape Plot",
           title_cex: float = 1.5,
           show_legend: bool = True,
           ylabel: str = "VO",
           xlabel: Union[str, None] = None) -> Dict:
    
    data_dim = np.array(dts).shape
    n = data_dim[0]
    
    dir_result = dir_out(dts, data_depth=data_depth, n_projections=n_projections, seed=seed)
    
    if len(data_dim) == 2:  # univariate
        dist = dir_result['distance']
        rocke_factors = hardin_factor_numeric(n, 2)
        rocke_factor1 = rocke_factors['factor1']
        rocke_cutoff = rocke_factors['factor2']
        cutoff_value = rocke_cutoff / rocke_factor1
        outliers_index = np.where(dist > cutoff_value)[0]
        median_curve = np.argmin(dist)
        
        if plot:
            myx = dir_result['mean_outlyingness']
            myy = dir_result['var_outlyingness']
            if xlabel is None:
                xlabel = "MO"
    
    elif len(data_dim) == 3:  # multivariate
        d = data_dim[2]
        rocke_factors = hardin_factor_numeric(n=n, dimension=d + 1)
        rocke_factor1 = rocke_factors['factor1']
        rocke_cutoff = rocke_factors['factor2']
        
        cutoff_value = rocke_cutoff / rocke_factor1
        outliers_index = np.where(dir_result['distance'] > cutoff_value)[0]
        median_curve = np.argmin(dir_result['distance'])
        
        if plot:
            myx = np.sqrt(np.sum(dir_result['mean_outlyingness']**2, axis=1))
            myy = dir_result['var_outlyingness']
            if xlabel is None:
                xlabel = "||MO||"
    
    if plot:
        plt.figure(figsize=(10, 8))
        plt.scatter(myx, myy, c='gray', edgecolors='none', alpha=0.6)
        plt.scatter(myx[outliers_index], myy[outliers_index], c='red', marker='x')
        
        plt.xlabel(xlabel, color='gray20')
        plt.ylabel(ylabel, color='gray20')
        plt.title(plot_title, fontsize=title_cex * 12, color='gray20')
        
        plt.grid(color='gray', linestyle=':', linewidth=0.5)
        plt.box(on=True)
        
        if show_legend:
            plt.legend(['normal', 'outlier'], loc='upper right', frameon=False, fontsize=10)
        
        plt.show()
    
    result = {
        'outliers': outliers_index,
        'median_curve': median_curve
    }
    
    if return_mvdir:
        result.update({
            'mean_outlyingness': dir_result['mean_outlyingness'],
            'var_outlyingness': dir_result['var_outlyingness']
        })
    
    return result

# You'll need to implement these functions:
def dir_out(dts, data_depth, n_projections, seed):
    # Implement directional outlyingness
    # (You can use the implementation from the previous response)
    pass

def hardin_factor_numeric(n, dimension):
    # Implement Hardin-Rocke correction factors
    pass
