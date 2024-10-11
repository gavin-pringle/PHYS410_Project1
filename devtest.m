close all; clear; clc;

nc = 50;
% Generate nc inital locations for charges
r0 = 2*rand(nc,3) - 1;
for i = 1:nc
    r0(i,:) = r0(i,:)/(norm(r0(i,:)));
end

tmax = 50;
gamma = 3;
epsec = 1.0e-2;
level = 11;

[t, r, v, v_ec] = charges(r0, tmax, level, gamma, epsec);

charges_plot(t, r, false)

figure

plot(t,v)