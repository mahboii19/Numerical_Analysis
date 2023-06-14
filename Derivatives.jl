using LinearAlgebra, Statistics, Plots, LaTeXStrings

# Single line functions
# Original function
f(x) = 2x^2 + 2x + 1

# f'(x) - Derivative function
f_prime(x) = 4x + 2

# f''(x) - Second Derivative Function
f_double_prime(x) = 4

# Derivative function at a single point (uses step_size as denominator)
function derivative(f, x, step_size)
    xph = x + step_size
    deriv = (f(xph) - f(x)) / step_size
    return deriv
end

derivative(f, 2, .001)

# Creating x axis values
n = 100
x_values = zeros(n+1)

initial = 0
for i in eachindex(x_values)
    x_values[i] = -50 + initial
    initial += 1
end

# Array of x-axis values
x = x_values

# Array for storing derivatives
deriv_arr = zeros(n+1)

# Creating derivative function that takes arrays as inputs (for calculating derivatives at more than one point)
function derivative(f, x, step_size)
    for i in eachindex(x)
        xph = x[i] + step_size
        dx = xph - x[i]
        deriv_arr[i] = (f(xph) - f(x[i])) / dx
    end
    return deriv_arr
end


derivatives = derivative(f, x, .001)
y = f_prime.(x)

plot(x, derivatives, label=L"f'(x) ≈ 4x+2")
plot!(x, y, label=L"f'(x) = 4x+2")

# Function for calculating f'(x+h)
function derivative2(f, x, step_size, n_points, deriv1)
    # Creating array to store f(x+h) derivative values in
    deriv_arr = zeros(n_points+1)
    # Creating array to store f''(x) values
    deriv2 = zeros(n_points+1)
    
    # Creating array of x values shifted by h (step_size) distance
    x2 = broadcast(+, x, step_size)

    # Creating array of f'(x+h) values
    for i in eachindex(x)
        xph = x2[i] + step_size
        dx = xph - x2[i]
        deriv_arr[i] = (f(xph) - f(x2[i])) / dx

        # Calculating second derivative values
        h = x2[i] - x[i]
        deriv2[i] = (deriv_arr[i] - deriv1[i]) / h
    end

    return deriv2
end

derivatives2 = derivative2(f, x, .001, 100, derivatives)
y = f_double_prime.(x)

# Plotting second derivative analytical solution vs numerical solution for x ∈ [-50, 50]
plot(x, derivatives2, label=L"f''(x)")
plot!(x, y, label=L"f''(x) = 4")