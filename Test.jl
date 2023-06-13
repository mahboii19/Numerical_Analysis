using LinearAlgebra, Statistics, Plots, LaTeXStrings

# Single line functions
# Original function
f(x) = 2x^2 + 2x + 1

# f'(x) - Derivative function
f_prime(x) = 4x + 2

# Derivative function at a single point (uses step_size as denominator)
function derivative(f, x, step_size)
    xph = x + step_size
    deriv = (f(xph) - f(x)) / step_size
    return deriv
end

print("Derivative Value: ") 
derivative(f, 2, .001)

