import numpy as np
import pandas as pd
from scipy import linalg

class MatrixMEWMA:
    """
    Multivariate/Matrix Exponentially Weighted Moving Average implementation.
    Handles multiple variables and their covariance structure.
    """
    
    def __init__(self, lambda_values=[0.9, 0.9, 0.9], sigma=None):
        """
        Initialize the MEWMA calculator.
        
        Parameters:
        -----------
        lambda_values : list
            List of smoothing factors (between 0 and 1)
        sigma : ndarray, optional
            Initial covariance matrix. If None, will be estimated from data
        """
        self.lambda_values = np.array(lambda_values)
        self.sigma = sigma
        self.means = None
        self.mewma_statistics = None
        
    def fit(self, X):
        """
        Estimate parameters from the data.
        
        Parameters:
        -----------
        X : ndarray
            Input matrix of shape (n_samples, n_features)
        """
        if self.sigma is None:
            self.sigma = np.cov(X, rowvar=False)
        
        self.means = np.mean(X, axis=0)
        return self
    
    def transform(self, X):
        """
        Calculate MEWMA for each lambda value.
        
        Parameters:
        -----------
        X : ndarray
            Input matrix of shape (n_samples, n_features)
            
        Returns:
        --------
        dict: Dictionary containing MEWMA values and control statistics for each lambda
        """
        X = np.array(X)
        n_samples, n_features = X.shape
        
        results = {}
        
        for lambda_val in self.lambda_values:
            # Initialize MEWMA matrix
            Z = np.zeros_like(X)
            # Initialize control statistics
            T2 = np.zeros(n_samples)
            
            # Calculate MEWMA recursively
            for t in range(n_samples):
                if t == 0:
                    Z[t] = lambda_val * (X[t] - self.means)
                else:
                    Z[t] = lambda_val * (X[t] - self.means) + (1 - lambda_val) * Z[t-1]
                
                # Calculate covariance matrix for MEWMA
                sigma_z = (lambda_val / (2 - lambda_val)) * self.sigma
                
                # Calculate Hotelling's T² statistic
                T2[t] = Z[t] @ linalg.inv(sigma_z) @ Z[t]
            
            results[f'lambda_{lambda_val}'] = {
                'Z': Z,  # MEWMA values
                'T2': T2,  # Control statistics
                'UCL': self._calculate_ucl(n_features, lambda_val)  # Upper control limit
            }
            
        self.mewma_statistics = results
        return results
    
    def _calculate_ucl(self, p, lambda_val, alpha=0.05):
        """
        Calculate Upper Control Limit for the MEWMA control chart.
        
        Parameters:
        -----------
        p : int
            Number of variables
        lambda_val : float
            Smoothing factor
        alpha : float
            Significance level
        
        Returns:
        --------
        float: Upper control limit
        """
        # This is a simplified UCL calculation
        # In practice, you might want to use more sophisticated methods
        from scipy.stats import chi2
        h = chi2.ppf(1 - alpha, p)
        return h
    
    def get_out_of_control_points(self, lambda_val):
        """
        Get indices of out-of-control points for a specific lambda value.
        
        Parameters:
        -----------
        lambda_val : float
            The smoothing factor to analyze
        
        Returns:
        --------
        ndarray: Indices of out-of-control points
        """
        stats = self.mewma_statistics[f'lambda_{lambda_val}']
        return np.where(stats['T2'] > stats['UCL'])[0]

# Example usage
def example_usage():
    # Generate sample multivariate data
    np.random.seed(42)
    n_samples = 100
    n_features = 3
    
    # Generate normal data with some correlation
    cov = np.array([[1.0, 0.5, 0.2],
                    [0.5, 1.0, 0.3],
                    [0.2, 0.3, 1.0]])
    X = np.random.multivariate_normal(mean=[0, 0, 0], cov=cov, size=n_samples)
    
    # Add some outliers
    X[50:55] += 3
    
    # Initialize and fit MEWMA
    mewma = MatrixMEWMA(lambda_values=[0.1, 0.3, 0.5])
    mewma.fit(X)
    results = mewma.transform(X)
    
    # Print results for one lambda value
    lambda_val = 0.1
    stats = results[f'lambda_{lambda_val}']
    print(f"\nResults for λ = {lambda_val}:")
    print("First 5 MEWMA values:")
    print(stats['Z'][:5])
    print("\nOut of control points:")
    print(mewma.get_out_of_control_points(lambda_val))

if __name__ == "__main__":
    example_usage()
