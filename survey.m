close all; clear; clc;

tmax = 500;
level = 12;
gamma = 2;
epsec = 1.0e-3;

% Creating file to be written to
fid_v = fopen('vsurvey.dat','w');
fid_ec = fopen('ecsurvey.dat', 'w');

for nc = 2:60
    r0 = 2*rand(nc,3) - 1;
    for i = 1:nc
        r0(i,:) = r0(i,:)/(norm(r0(i,:)));
    end
    [t, r, v, v_ec] = charges(r0, tmax, level, gamma, epsec);

    fprintf(fid_v, '%3d %16.10f\n', nc, v(end));
    fprintf(fid_ec, '%3d ', nc);
    fprintf(fid_ec, '%d ', v_ec);
    fprintf(fid_ec, '\n');
end

fclose(fid_v);
fclose(fid_ec);
