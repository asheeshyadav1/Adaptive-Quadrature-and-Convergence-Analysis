# Convergence Analysis of Numerical Integration for Non-Smooth Functions

This project investigates the **Composite Simpson's Rule** for approximating integrals of **piecewise non-smooth functions**.  
The objective is to study how the **smoothness of the integrand** affects the **observed convergence rate** of a high-order numerical quadrature method.

---

## Integrand and Method

The integrand is a piecewise function:

$$
f_m(x) =
\begin{cases} 
x^2, & x < 0.5 \\
x^2 + (x - 0.5)^m, & x \ge 0.5
\end{cases}
$$

where $m$ is a positive integer.  
The integral to approximate is:

$$
I_m = \int_0^{\pi} f_m(x) \, dx
$$

Composite Simpson's Rule is used, which typically achieves **$O(h^4)$** convergence for smooth functions, where $h$ is the subinterval width.

---

## Phase A — Convergence Analysis for $m=3$

This phase examines convergence when the **third derivative is discontinuous**.

### Exact Solution

- Compute $I_3$ by **analytically splitting the integral** at $x=0.5$.
- This value is used to compute **absolute errors** of numerical approximations.

### Procedure

- Apply Composite Simpson's Rule for **even values of $n$** subintervals.
- Compute step size $h = \pi / n$ and function values $f_3(x_k)$ at nodes $x_k = k \cdot h$.  
- Compute Simpson's approximation $S_n$.
- Calculate **absolute error**: $|I_3 - S_n|$.
- Plot error vs $h$ on a **log-log scale**; slope $p$ indicates observed order of convergence.

### Expected Result

- $f_3(x)$ is twice continuously differentiable; third derivative is discontinuous at $x=0.5$.  
- Convergence rate is reduced to **$O(h^3)$**.  
- Log-log plot should show slope $p \approx 3$.

---

## Phase B — Convergence Analysis for $m=5$

This phase repeats the procedure with **$m=5$**, increasing smoothness.

### Procedure and Analysis

- Compute exact integral $I_5$.  
- Apply Composite Simpson's Rule for a range of $n$.  
- Compute absolute errors $|I_5 - S_n|$ and plot vs $h$ on a log-log scale.

### Expected Result

- $f_5(x)$ is four times continuously differentiable; fifth derivative is discontinuous.  
- Simpson's Rule achieves a **higher convergence rate**, expected $O(h^4)$.  
- Log-log plot should confirm slope $p \approx 4$.

---

## Phase C — Synthesis and Prediction

### Comparison of Results

- Convergence rate $p$ depends on **function smoothness**.  
- Higher $m$ leads to **higher order of convergence**.  

### Prediction for $m=2$

- $f_2(x) = x^2 + (x-0.5)^2$ for $x \ge 0.5$  
- Only **once continuously differentiable**; second derivative is discontinuous at $x=0.5$.  
- Expected convergence rate: **$O(h^2)$**

### Explanation

- Error of numerical quadrature depends on the **highest continuous derivative**.  
- Discontinuities act as “hidden” sources of error, limiting performance.  
- Full potential of Simpson’s Rule ($O(h^4)$) is achieved only for sufficiently smooth functions.

---

## What This Investigation Demonstrates

- **Practical implementation of Composite Simpson's Rule** for piecewise functions.  
- **Link between smoothness and convergence rate**: Theoretical order is an upper bound, realized only if the function is smooth enough.  
- **Methodology for empirical convergence analysis**: Log-log error plots are used to determine effective order $p$.  
- **Understanding numerical errors**: Moves beyond computation to explain why the method performs as it does based on integrand properties.
