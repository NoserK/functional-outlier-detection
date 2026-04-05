def hardin_factor_numeric(n: int, dimension: int) -> dict:
    """
    Calculate Hardin factors based on sample size and dimension.

    Args:
    n (int): Sample size
    dimension (int): Dimension of the data

    Returns:
    dict: A dictionary containing 'factor1' and 'factor2'

    Raises:
    ValueError: If dimension is less than 2
    """
    if dimension >= 2:
        asymp_result = croux_hesbroeck_asymptotic(n=n, dimension=dimension)
        factor1 = asymp_result['factor1']
        factor2 = asymp_result['factor2']
    else:
        raise ValueError("Argument 'dimension' must be greater than or equal to 2.")

    return {'factor1': factor1, 'factor2': factor2}

# Note: You need to implement the croux_hesbroeck_asymptotic function
def croux_hesbroeck_asymptotic(n: int, dimension: int) -> dict:
    # Implement this function based on your R code
    pass
