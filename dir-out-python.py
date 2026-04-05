import numpy as np
from scipy import stats
from typing import Union, Tuple, List, Dict

def dir_out(dts: Union[np.ndarray, List[List[float]]],
            data_depth: str = "random_projections",
            n_projections: int = 200,
            seed: Union[int, None] = None,
            return_distance: bool = True,
            return_dir_matrix: bool = False) -> Dict:
    
    dts = np.array(dts)
    data_dim = dts.shape
    
    if dts.ndim not in [2, 3]:
        raise ValueError("Argument 'dts' must be a 2D or 3D array.")
    
    if np.any(~np.isfinite(dts)):
        raise ValueError("Missing or infinite values are not allowed in argument 'dts'.")
    
    if data_dim[0] < 3:
        raise ValueError("n must be greater than 3.")
    
    if dts.ndim == 2:  # univariate
        dts = dts.T
        median_vec = np.median(dts, axis=1)
        mad_vec = stats.median_abs_deviation(dts, axis=1)
        dir_out_matrix = ((dts - median_vec[:, np.newaxis]) / mad_vec[:, np.newaxis]).T
        mean_dir_out = np.mean(dir_out_matrix, axis=0)
        var_dir_out = np.var(dir_out_matrix, axis=0)
        
        if return_distance:
            ms_matrix = np.column_stack((mean_dir_out, var_dir_out))
            mcd_obj = cov_rob(ms_matrix, method="mcd", nsamp="best")
            robust_cov = mcd_obj['cov']
            robust_mean = mcd_obj['center']
            distance = stats.mahalanobis(ms_matrix, robust_mean, np.linalg.inv(robust_cov))
    
    elif dts.ndim == 3:  # multivariate
        n, p, d = dts.shape
        
        if data_depth == "random_projections":
            dir_out_matrix = np.zeros((n, p, d))
            for j in range(p):
                x = dts[:, j, :]
                outlyingness = (1 / projection_depth(x, n_projections=n_projections, seed=seed)) - 1
                median_vec = x[np.argsort(outlyingness)[0]]
                median_dev = x - median_vec
                spatial_sign = np.sqrt(np.sum(median_dev**2, axis=1))[:, np.newaxis]
                spatial_sign = median_dev / spatial_sign
                spatial_sign[~np.isfinite(spatial_sign[:, 0])] = 0
                dir_out_matrix[:, j, :] = spatial_sign * outlyingness[:, np.newaxis]
        else:
            raise ValueError("depth method not supported.")
        
        mean_dir_out = np.mean(dir_out_matrix, axis=1)
        var_dir_out = (np.sum(dir_out_matrix**2, axis=(1, 2)) / p) - np.sum(mean_dir_out**2, axis=1)
        
        if return_distance:
            ms_matrix = np.column_stack((mean_dir_out.reshape(n, -1), var_dir_out))
            mcd_obj = cov_rob(ms_matrix, method="mcd", nsamp="best")
            robust_cov = mcd_obj['cov']
            robust_mean = mcd_obj['center']
            distance = stats.mahalanobis(ms_matrix, robust_mean, np.linalg.inv(robust_cov))
    
    result = {
        'mean_outlyingness': mean_dir_out,
        'var_outlyingness': var_dir_out
    }
    
    if return_distance:
        result.update({
            'distance': distance,
            'ms_matrix': ms_matrix,
            'mcd_obj': mcd_obj
        })
    
    if return_dir_matrix:
        result['dirout_matrix'] = dir_out_matrix
    
    return result

# You'll need to implement these functions:
def projection_depth(x, n_projections, seed):
    # Implement projection depth calculation
    pass

def cov_rob(x, method, nsamp):
    # Implement robust covariance estimation
    # (You can use the implementation from the previous response)
    pass
