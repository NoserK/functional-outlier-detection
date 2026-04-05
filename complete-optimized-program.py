import os
import numpy as np
import cv2
from PIL import Image
from typing import List, Dict, Union, Optional
from scipy import stats
from scipy.spatial.distance import mahalanobis
import warnings
import multiprocessing
from functools import lru_cache
from numba import jit
import math

@jit(nopython=True)
def median_along_axis0(arr):
    """Calculate median along axis 0 for a 2D array."""
    result = np.empty(arr.shape[1])
    for i in range(arr.shape[1]):
        col = arr[:, i]
        sorted_col = np.sort(col)
        mid = len(sorted_col) // 2
        if len(sorted_col) % 2 == 0:
            result[i] = (sorted_col[mid-1] + sorted_col[mid]) / 2
        else:
            result[i] = sorted_col[mid]
    return result

@jit(nopython=True)
def safe_median_along_axis0(arr):
    """Calculate median along axis 0 for a 2D array, handling empty slices."""
    result = np.empty(arr.shape[1])
    for i in range(arr.shape[1]):
        col = arr[:, i]
        if len(col) == 0:
            result[i] = np.nan
        else:
            sorted_col = np.sort(col)
            mid = len(sorted_col) // 2
            if len(sorted_col) % 2 == 0:
                result[i] = (sorted_col[mid-1] + sorted_col[mid]) / 2
            else:
                result[i] = sorted_col[mid]
    return result

@jit(nopython=True)
def projection_depth_numba(dts, dt, u_matrix):
    dts = dts.astype(np.float64)
    dt = dt.astype(np.float64)
    u_matrix = u_matrix.astype(np.float64)
    
    projections_dts = np.dot(dts, u_matrix.T)
    projections_dt = np.dot(dt, u_matrix.T)

    depths = np.zeros(dts.shape[0])
    median_proj_dt = safe_median_along_axis0(projections_dt)
    
    for i in range(dts.shape[0]):
        proj_dts_i = projections_dts[i]
        numerator = np.abs(proj_dts_i - median_proj_dt)
        abs_dev = np.abs(projections_dt - median_proj_dt)
        denominator = safe_median_along_axis0(abs_dev)
        depths[i] = np.nanmax(np.where(denominator != 0, numerator / denominator, np.nan))

    return 1 / (1 + depths)

def safe_cov(x, rowvar=False):
    """Calculate covariance matrix, handling cases with too few samples."""
    if x.shape[0] <= 1:
        return np.eye(x.shape[1])  # Return identity matrix if not enough samples
    return np.cov(x, rowvar=rowvar)

def robust_mahalanobis(x, mean, cov):
    """Calculate Mahalanobis distance, handling singular covariance matrices."""
    try:
        return mahalanobis(x, mean, np.linalg.inv(cov))
    except np.linalg.LinAlgError:
        # If covariance matrix is singular, use pseudo-inverse
        return mahalanobis(x, mean, np.linalg.pinv(cov))

def projection_depth(dts, dt=None, n_projections=500, seed=None):
    dts = np.asarray(dts, dtype=np.float64)
    if dt is None:
        dt = dts
    else:
        dt = np.asarray(dt, dtype=np.float64)

    if seed is not None:
        np.random.seed(seed)

    u_matrix = np.random.uniform(-1, 1, size=(n_projections, dts.shape[1]))
    u_matrix /= np.sqrt(np.sum(u_matrix**2, axis=1))[:, np.newaxis]
    u_matrix = u_matrix.astype(np.float64)

    return projection_depth_numba(dts, dt, u_matrix)

def cov_rob(x, cor=False, quantile_used=None, method="mve", nsamp="best", seed=None):
    x = np.asarray(x)
    if np.any(np.isnan(x)) or np.any(np.isinf(x)):
        raise ValueError("missing or infinite values are not allowed")
    
    n, p = x.shape
    if n < p + 1:
        raise ValueError(f"at least {p+1} cases are needed")
    
    if quantile_used is None:
        quantile_used = (n + p + 1) // 2
    
    if method == "classical":
        center = np.mean(x, axis=0)
        cov = np.cov(x, rowvar=False)
        ans = {"center": center, "cov": cov}
    else:
        if quantile_used < p + 1:
            raise ValueError(f"'quantile' must be at least {p+1}")
        if quantile_used > n - 1:
            raise ValueError(f"'quantile' must be at most {n-1}")
        
        # Re-scale to roughly common scale
        divisor = stats.iqr(x, axis=0)
        if np.any(divisor == 0):
            raise ValueError("at least one column has IQR 0")
        x = x / divisor
        
        qn = quantile_used
        ps = p + 1
        nexact = math.comb(n, ps)
        
        if isinstance(nsamp, str) and nsamp == "best":
            nsamp = "exact" if nexact < 5000 else "sample"
        
        if isinstance(nsamp, (int, float)) and nsamp > nexact:
            warnings.warn(f"only {nexact} sets, so all sets will be tried")
            nsamp = "exact"
        
        samp = nsamp != "exact"
        if samp:
            if nsamp == "sample":
                nsamp = min(500 * ps, 3000)
        else:
            nsamp = nexact
        
        if nsamp > 2147483647:
            if samp:
                raise ValueError(f"Too many samples ({nsamp:.3g})")
            else:
                raise ValueError(f'Too many combinations ({nsamp:.3g}) for nsamp = "exact"')
        
        if samp and seed is not None:
            np.random.seed(seed)
        
        # Here you would implement the core algorithm (mve_fitlots in R)
        # For now, we'll use a placeholder
        z = placeholder_mve_fitlots(x, n, p, qn, method=="mcd", samp, ps, nsamp)
        
        crit = z['crit'] + 2 * np.sum(np.log(divisor))
        if method == "mcd":
            crit += -p * np.log(qn - 1)
        
        best = np.where(z['bestone'] != 0)[0]
        if len(best) == 0:
            raise ValueError("'x' is probably collinear")
        
        # means = np.mean(x[best], axis=0)
        # rcov = np.cov(x[best], rowvar=False) * (1 + 15/(n - p))**2
        # dist = np.array([mahalanobis(xi, means, np.linalg.inv(rcov)) for xi in x])
        # cut = stats.chi2.ppf(0.975, p) * np.quantile(dist, qn/n) / stats.chi2.ppf(qn/n, p)
        
        # cov = divisor[:, np.newaxis] * np.cov(x[dist < cut], rowvar=False) * divisor

        means = np.mean(x[best], axis=0)
        rcov = safe_cov(x[best], rowvar=False) * (1 + 15/(n - p))**2
        dist = np.array([robust_mahalanobis(xi, means, rcov) for xi in x])
        cut = stats.chi2.ppf(0.975, p) * np.nanquantile(dist, qn/n) / stats.chi2.ppf(qn/n, p)
    
        mask = dist < cut
        if np.sum(mask) <= 1:
            warnings.warn("Too few points below the cut-off. Using all points for covariance estimation.")
            mask = np.ones_like(mask, dtype=bool)
    
        cov = divisor[:, np.newaxis] * safe_cov(x[mask], rowvar=False) * divisor
        
        ans = {
            "center": np.mean(x[dist < cut], axis=0) * divisor,
            "cov": cov,
            "msg": z['sing'],
            "crit": crit,
            "best": best
        }
    
    if cor:
        sd = np.sqrt(np.diag(ans["cov"]))
        ans["cor"] = ans["cov"] / np.outer(sd, sd)
    
    ans["n_obs"] = n
    print(f"joker cov", end="\n")
    return ans

def placeholder_mve_fitlots(x, n, p, qn, is_mcd, samp, ps, nsamp):
    # This is a placeholder for the C function in the original R code
    # You would need to implement the actual algorithm here
    return {
        'crit': 0,
        'sing': "Placeholder: 0 singular samples",
        'bestone': np.ones(n)
    }

@lru_cache(maxsize=None)
def hardin_factor_numeric(n: int, dimension: int) -> dict:
    h = int(np.floor((n + dimension + 1) / 2))
    alpha = (n - h) / n
    q_alpha = stats.chi2.ppf(1 - alpha, dimension)
    c_alpha = (1 - alpha) / stats.chi2.cdf(q_alpha, dimension + 2)
    c2 = -stats.chi2.cdf(q_alpha, dimension + 2) / 2
    c3 = -stats.chi2.cdf(q_alpha, dimension + 4) / 2
    c4 = 3 * c3
    b1 = c_alpha * (c3 - c4) / (1 - alpha)
    b2 = 0.5 + c_alpha / (1 - alpha) * (c3 - q_alpha * (c2 + (1 - alpha) / 2) / dimension)
    v1 = (1 - alpha) * (b1**2) * (alpha * (c_alpha * q_alpha / dimension - 1)**2 - 1) - \
         2 * c3 * c_alpha**2 * (3 * (b1 - dimension * b2)**2 + (dimension + 2) * b2 * (2 * b1 - dimension * b2))
    v2 = n * (b1 * (b1 - dimension * b2) * (1 - alpha))**2 * c_alpha**2
    v = v1 / v2
    m_asy = 2 / (c_alpha**2 * v)
    m = m_asy * np.exp(0.725 - 0.00663 * dimension - 0.078 * np.log(n))
    
    if m < dimension:
        m = m_asy
    
    a1 = stats.chi2.rvs(dimension + 2, size=10000)
    a2 = stats.chi2.rvs(dimension, size=10000) * (h / n)
    c = np.sum(a1 < a2) / (10000 * h / n)
    factors = c * (m - dimension + 1) / (dimension * m)
    cutoff = stats.f.ppf(0.993, dimension, m - dimension + 1)
    
    return {'factor1': factors, 'factor2': cutoff}

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
        
        # if return_distance:
        #     ms_matrix = np.column_stack((mean_dir_out, var_dir_out))
        #     mcd_obj = cov_rob(ms_matrix, method="mcd", nsamp="best")
        #     robust_cov = mcd_obj['cov']
        #     robust_mean = mcd_obj['center']
        #     distance = np.array([mahalanobis(x, robust_mean, np.linalg.inv(robust_cov)) for x in ms_matrix])
        if return_distance:
            ms_matrix = np.column_stack((mean_dir_out.reshape(n, -1), var_dir_out))
            mcd_obj = cov_rob(ms_matrix, method="mcd", nsamp="best")
            robust_cov = mcd_obj['cov']
            robust_mean = mcd_obj['center']
            distance = np.array([robust_mahalanobis(x, robust_mean, robust_cov) for x in ms_matrix])
    
    
    elif dts.ndim == 3:  # multivariate
        n, p, d = dts.shape
        
        if data_depth == "random_projections":
            dir_out_matrix = np.zeros((n, p, d), dtype=np.float64)
            for j in range(p):
                x = dts[:, j, :]
                outlyingness = (1 / projection_depth(x, n_projections=n_projections, seed=seed)) - 1
                median_vec = x[np.argsort(outlyingness)[0]]
                median_dev = x - median_vec
                spatial_sign = np.sqrt(np.sum(median_dev**2, axis=1))[:, np.newaxis]
                spatial_sign = median_dev / (spatial_sign + 1e-10)
                spatial_sign[~np.isfinite(spatial_sign[:, 0])] = 0
                dir_out_matrix[:, j, :] = spatial_sign * outlyingness[:, np.newaxis]
                print(f"med joker dir {j}", end="\n")
        else:
            raise ValueError("depth method not supported.")
        
        mean_dir_out = np.mean(dir_out_matrix, axis=1)
        var_dir_out = (np.sum(dir_out_matrix**2, axis=(1, 2)) / p) - np.sum(mean_dir_out**2, axis=1)
        
        if return_distance:
            ms_matrix = np.column_stack((mean_dir_out.reshape(n, -1), var_dir_out))
            mcd_obj = cov_rob(ms_matrix, method="mcd", nsamp="best")
            robust_cov = mcd_obj['cov']
            robust_mean = mcd_obj['center']
            distance = np.array([mahalanobis(x, robust_mean, np.linalg.inv(robust_cov)) for x in ms_matrix])

    
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

def msplot(dts: Union[np.ndarray, List[List[float]]],
           data_depth: str = "random_projections",
           n_projections: int = 200,
           seed: Union[int, None] = None,
           return_mvdir: bool = True) -> Dict:
    
    data_dim = np.array(dts).shape
    n = data_dim[0]
    print(f"start joker plot", end="\n")
    
    dir_result = dir_out(dts, data_depth=data_depth, n_projections=n_projections, seed=seed)

    print(f"end of joker dir", end="\n")
    
    if len(data_dim) == 2:  # univariate
        dist = dir_result['distance']
        rocke_factors = hardin_factor_numeric(n, 2)
        rocke_factor1 = rocke_factors['factor1']
        rocke_cutoff = rocke_factors['factor2']
        cutoff_value = rocke_cutoff / rocke_factor1
        outliers_index = np.where(np.isfinite(dir_result['distance']) & (dir_result['distance'] > cutoff_value))[0]
        median_curve = np.nanargmin(dir_result['distance'])
        # cutoff_value = rocke_cutoff / rocke_factor1
        # outliers_index = np.where(dist > cutoff_value)[0]
        # median_curve = np.argmin(dist)
        
    elif len(data_dim) == 3:  # multivariate
        d = data_dim[2]
        rocke_factors = hardin_factor_numeric(n=n, dimension=d + 1)
        rocke_factor1 = rocke_factors['factor1']
        rocke_cutoff = rocke_factors['factor2']
        
        cutoff_value = rocke_cutoff / rocke_factor1
        outliers_index = np.where(dir_result['distance'] > cutoff_value)[0]
        median_curve = np.argmin(dir_result['distance'])
    
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

def process_single_image(img_path):
    img = cv2.imread(img_path, cv2.IMREAD_GRAYSCALE)
    return np.square(img.astype(np.float32))

def process_images_parallel(base_path: str) -> Dict[str, np.ndarray]:
    processed_data = {}

    # Process training data
    train_path = os.path.join(base_path, 'train_frames')
    train_files = [os.path.join(train_path, img_name) for img_name in os.listdir(train_path)]
    
    with multiprocessing.Pool() as pool:
        train_data = pool.map(process_single_image, train_files)
    processed_data['train'] = np.array(train_data)

    # Process test data
    for i in range(1, 13):
        folder = f'f{i}'
        gt_path = os.path.join(base_path, folder, 'diff_gt')
        at_path = os.path.join(base_path, folder, 'diff_at')
        
        gt_files = [os.path.join(gt_path, img_name) for img_name in os.listdir(gt_path)]
        at_files = [os.path.join(at_path, img_name) for img_name in os.listdir(at_path)]
        
        with multiprocessing.Pool() as pool:
            gt_data = pool.map(process_single_image, gt_files)
            at_data = pool.map(process_single_image, at_files)
        
        processed_data[folder] = np.array(gt_data) + np.array(at_data)
        print(f"Finished processing images for joker {i}", end="\n")

    return processed_data

def process_test_set(args):
    folder, train_data, test_data, ground_truth = args
    combined_data = np.concatenate([train_data, test_data])
    msplot_result = msplot(combined_data)
    detected_outliers = msplot_result['outliers']
    
    # Adjust detected outliers to match test set indices
    adjusted_outliers = [idx - len(train_data) for idx in detected_outliers if idx >= len(train_data)]
    metrics = compare_with_ground_truth(adjusted_outliers, ground_truth)
    
    return folder, metrics

def main():
    base_path = '.'  # Adjust this to the path where your folders are located
    processed_data = process_images_parallel(base_path)

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

    # Prepare arguments for parallel processing
    args_list = [
        (f'f{i}', processed_data['train'], processed_data[f'f{i}'], ground_truth[i-1])
        for i in range(1, 13)
    ]

    # Process test sets in parallel
    with multiprocessing.Pool() as pool:
        results = pool.map(process_test_set, args_list)

    # Print results
    for folder, metrics in results:
        print(f"{folder}:")
        print(f"  Precision: {metrics['precision']:.4f}")
        print(f"  Recall: {metrics['recall']:.4f}")
        print(f"  F1 Score: {metrics['f1_score']:.4f}")
        print()

if __name__ == "__main__":
    main()