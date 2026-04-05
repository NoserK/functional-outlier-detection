import numpy as np
from typing import Union, Optional

def projection_depth(dts: Union[np.ndarray, list], 
                     dt: Optional[Union[np.ndarray, list]] = None, 
                     n_projections: int = 500, 
                     seed: Optional[int] = None) -> np.ndarray:
    """
    Calculate the projection depth of points in dts with respect to dt.

    Args:
    dts (array-like): The points for which to calculate the projection depth.
    dt (array-like, optional): The reference set of points. If None, use dts.
    n_projections (int): Number of random projections to use.
    seed (int, optional): Random seed for reproducibility.

    Returns:
    np.ndarray: Projection depths for each point in dts.
    """
    dts = np.asarray(dts)
    if dt is None:
        dt = dts
    else:
        dt = np.asarray(dt)

    # Handle 1D input for dts
    if dts.ndim == 1:
        dts = dts.reshape(1, -1)

    if dts.shape[1] != dt.shape[1]:
        raise ValueError("Argument 'dts' must have the same dimension as 'dt'.")

    if not np.isfinite(dt).all() or not np.isfinite(dts).all():
        raise ValueError("Missing or infinite values are not allowed in arguments 'dt' and 'dts'.")

    if seed is not None:
        np.random.seed(seed)

    m, d = dts.shape
    n = dt.shape[0]

    # Generate and scale directions
    u_matrix = np.random.uniform(-1, 1, size=(n_projections, d))
    u_matrix /= np.sqrt(np.sum(u_matrix**2, axis=1))[:, np.newaxis]

    # Implement the core algorithm
    # Note: In R, this part calls a C function. We'll implement it in Python here.
    projections_dts = np.dot(dts, u_matrix.T)
    projections_dt = np.dot(dt, u_matrix.T)

    # Calculate the projection depth
    depths = np.zeros(m)
    for i in range(m):
        proj_dts_i = projections_dts[i]
        numerator = np.abs(proj_dts_i - np.median(projections_dt, axis=0))
        denominator = np.median(np.abs(projections_dt - np.median(projections_dt, axis=0)), axis=0)
        depths[i] = np.max(numerator / denominator)

    return 1 / (1 + depths)

# Example usage:
# data = np.random.randn(100, 5)
# depths = projection_depth(data, n_projections=1000, seed=42)
# print(depths)
