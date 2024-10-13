close all; clear; clc;

nc = 13;
% Generate nc random inital locations for charges
r0 = 2*rand(nc,3) - 1;
for i = 1:nc
    r0(i,:) = r0(i,:)/(norm(r0(i,:)));
end

tmax = 500;
level = 12;
gamma = 2;
epsec = 1.0e-3;

[t, r, v, v_ec] = charges(r0, tmax, level, gamma, epsec);

%charges_plot(t, r, false)

figure

plot(t,v)

v_ec