close all; clear; clc;

% Simulation parameters
nc = 12;
tmax = 10;
level = 12;
gamma = 1;
epsec = 1.0e-5;

% Generate nc random inital locations for charges
r0 = 2*rand(nc,3) - 1;
for i = 1:nc
    r0(i,:) = r0(i,:)/(norm(r0(i,:)));
end

% Run simulation 
[t, r, v, v_ec] = charges(r0, tmax, level, gamma, epsec);

% Plot V(t) vs. t 
plot(t,v)
xlabel("Time t")
ylabel("Total potential energy V(t)")
title({"Potential Energy V(t) vs. time t", ...
       "nc = 12, tmax = 10, level = 12, gamma = 1, epsec = 1.0e-5"})
ax = gca;
ax.FontSize = 12;