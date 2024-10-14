%% 6.1 - 4-level convergence test

close all; clear; clc;

% Simulation parameters as described in project description
nc = 4;
tmax = 10;
gamma = 1;
epsec = 1.0e-5;

% Initial conditions of charges 
r0 = [[1, 0, 0]; [0, 1, 0]; [0, 0, 1]; (sqrt(3)/3) * [1, 1, 1]];

% Run computation at each discretization level
[t10, r10, v10, v_ec10] = charges(r0, tmax, 10, gamma, epsec);
[t11, r11, v11, v_ec11] = charges(r0, tmax, 11, gamma, epsec);
[t12, r12, v12, v_ec12] = charges(r0, tmax, 12, gamma, epsec);
[t13, r13, v13, v_ec13] = charges(r0, tmax, 13, gamma, epsec);

% x coordinate values of charge one at level 10 
x10 = reshape(r10(1,1,:), size(t10)); 
x11 = reshape(r11(1,1,:), size(t11)); 
x12 = reshape(r12(1,1,:), size(t12)); 
x13 = reshape(r13(1,1,:), size(t13)); 

% Calculating the level-to-level differences, taking every second 
% value of the larger length array
dx10 = downsample(x11, 2) - x10; 
dx11 = downsample(x12, 2) - x11; 
dx12 = downsample(x13, 2) - x12;

% First plot all curves for rho = 2 
fig1 = figure(1);
rho = 2;
hold on
plot(t10, dx10, 'LineWidth', 2);
plot(t11, rho*dx11, 'LineWidth', 2);
plot(t12, rho^2*dx12, 'LineWidth', 2);
xlabel("Time");
ylabel("Difference between level");
legend('dx10', 'rho * dx11', 'rho^2 * dx12');
title("Convergence test: rho = 2");
ax = gca;
ax.FontSize = 12;

% First plot all curves for rho = 4
fig2 = figure(2);
rho = 4;
hold on 
plot(t10, dx10, 'LineWidth', 2);
plot(t11, rho*dx11, 'LineWidth', 2);
plot(t12, rho^2*dx12, 'LineWidth', 2);
xlabel("Time");
ylabel("Difference between level");
legend('dx10', 'rho * dx11', 'rho^2 * dx12');
title("Convergence test: rho = 4");
ax = gca;
ax.FontSize = 12;
