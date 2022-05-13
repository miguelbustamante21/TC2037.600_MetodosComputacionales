"""
Testing recursion in Python
"""

def factorial(x):
    """ Compute the factorial of x """
    if x == 0:
        return 1
    else:
        return x * factorial(x - 1)

print(factorial(5))
