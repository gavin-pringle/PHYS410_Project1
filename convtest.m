close all; clear; clc;

nc = 4;
tmax = 10;
gamma = 1;
epsec = 1.0e-5;

r0 = [[1, 0, 0]; [0, 1, 0]; [0, 0, 1]; (sqrt(3)/3) * [1, 1, 1]];

level = 10, 11, 12, 13;