close all; clear; clc;

nc = 12;
% Generate nc inital locations for charges
r0 = zeros(nc, 3);
for i = 1:nc
    r0(i,:) = rand(1,3);
    r0(i,:) = r0(i,:)/(norm(r0(i,:)));
end

tmax = 10;
gamma = 1;
epsec = 1.0e-5;
level = 10;

[t, r, v, v_ec] = charges(r0, tmax, level, gamma, epsec);

charges_plot(t, r, false)