%% FOR CODE DEVELOPMENT ONLY - Test script for charges.m

close all; clear; clc;

nc = 24;
% Generate nc random inital locations for charges
r0 = rand(nc,3);
for i = 1:nc
    r0(i,:) = r0(i,:)/(norm(r0(i,:)));
end

tmax = 10;
level = 9;
gamma = 2;
epsec = 1.0e-3;

[t, r, v, v_ec] = charges(r0, tmax, level, gamma, epsec);

charges_video(t, r);