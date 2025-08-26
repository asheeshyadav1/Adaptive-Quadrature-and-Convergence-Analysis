% clear past results
clc; clear; close all;

% def func fm(x) based on m
function y = fm(x, m)
    y = x.^2;  
    y(x >= 0.5) = y(x >= 0.5) + (x(x >= 0.5) - 0.5).^m;
end

% CSR func
function iFunc = simRule(f, a, b, n, m)
    if mod(n, 2) ~= 0
        error('n = even only');
    end
    hVal = (b - a) / n;
    xVal = a:hVal:b;
    fx = f(xVal, m);
    iFunc = (hVal/3) * (fx(1) + 4*sum(fx(2:2:end-1)) + 2*sum(fx(3:2:end-2)) + fx(end));
end

% comp integr exact
syms x;
% given vals
mVal = [3, 5];  
excInt = zeros(size(mVal));

for i = 1:length(mVal)
    m = mVal(i);
    f_sym = piecewise(x < 0.5, x^2, x >= 0.5, x^2 + (x - 0.5)^m);
    excInt(i) = double(int(f_sym, x, 0, pi));
end

% conv anly for a & b 
 % ensure even values of n
nVal = 2.^(3:9); 
err = zeros(length(nVal), length(mVal));

for j = 1:length(mVal)
    m = mVal(j);
    exact_val = excInt(j);
    
    for i = 1:length(nVal)
        n = nVal(i);
        appr = simRule(@fm, 0, pi, n, m);
        err(i, j) = abs(appr - exact_val);
    end
end

% graph for part A
figure;
loglog(nVal, err(:, 1), '-o', 'Color', 'b', 'MarkerFaceColor', 'b', 'DisplayName', 'm = 3');
xlabel('n (number of subintervals)');
ylabel('Absolute Error');
title('Convergence Analysis (Part A) - m = 3');
legend;
grid on;

% graph for part B
figure;
loglog(nVal, err(:, 2), '-s', 'Color', 'r', 'MarkerFaceColor', 'r', 'DisplayName', 'm = 5');
xlabel('n (number of subintervals)');
ylabel('Absolute Error');
title('Convergence Analysis (Part B) - m = 5');
legend;
grid on;

% est err ordr loglog regression
p_est = polyfit(log(nVal), log(err(:, 1)), 1);
q_est = polyfit(log(nVal), log(err(:, 2)), 1);
fprintf('err order for m = 3: O(h^%.2f)\n', -p_est(1));
fprintf('err order for m = 5: O(h^%.2f)\n', -q_est(1));
