close all; clear; clc;

nc = 13;
% Generate nc inital locations for charges
r0 = zeros(nc, 3);
for i = 1:nc
    r0(i,:) = rand(1,3);
    r0(i,:) = r0(i,:)/(norm(r0(i,:)));
end

tmax = 1000;
gamma = 3;
epsec = 1.0e-2;
level = 10;

[t, r, v, v_ec] = charges(r0, tmax, level, gamma, epsec);

plot(t,v);

%charges_plot(t, r, false)