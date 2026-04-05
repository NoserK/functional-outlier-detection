import numpy as np
from scipy import stats

def croux_hesbroeck_asymptotic(n: int, dimension: int) -> dict:
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
