%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% charges: Top-level function for solution of charges-on-a-sphere
% problem.
%
% Input arguments
%
% r0: Initial positions (nc x 3 array, where nc is the number of
% charges)
% tmax: Maximum simulation time
% level: Discretization level
% gamma: Dissipation coefficient
% epsec: Tolerance for equivalence class analysis
%
% Output arguments
%
% t: Vector of simulation times (length nt row vector)
% r: Positions of charges (nc x 3 x nt array)
% v: Potential vector (length nt row vector)
% v_ec: Equivalence class counts (row vector with length determined
% by equivalence class analysis)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [t, r, v, v_ec] = charges(r0, tmax, level, gamma, epsec)

    nt = 2^level + 1;           % Number of timesteps 
    dt = tmax / (nt - 1);       % Time period between steps 
    t = linspace(0, tmax, nt);  % Vector of simulation times 

    % Number of charges 
    nc = height(r0);

    % Intialize array for locations of charges throughout all timesteps
    r = zeros(nc, 3, nt);
    r(:,:,1) = r0; r(:,:,2) = r0; % No initial velocity

    % Array for storing the potential at each time step
    v = zeros(1, nt);

    % Compute for all time steps
    for n = 1:nt
        % Compute the position of each charge at the current time step
        for i = 1:nc
            % We already know all positions at the first two time steps
            if n == 1 || n == 2
                continue
            end

            % Compute electrostatic forces on the current charge 
            es_disp = [0 0 0];
            for j = 1:nc
                if j == i 
                    continue
                end
                es_disp = es_disp + (r(j,:,n-1) - r(i,:,n-1)) / ...
                          norm(r(j,:,n-1) - r(i,:,n-1))^3;
            end

            % Displacement term depending on location of the charge from 1 ts ago
            one_ts_disp = (2 / dt^2) * r(i,:,n-1);
            % Displacement term depending on location of the charge from 2 ts ago
            two_ts_disp = (gamma/(2 * dt) - 1/(dt^2)) * r(i,:,n-2);

            % Combining all computed displacements prior to normalization
            pos_before_norm = (two_ts_disp + one_ts_disp - es_disp) / ...
                               (1 / dt^2 - gamma/(2 * dt));

            % Normalize the position
            pos_norm = pos_before_norm / (norm(pos_before_norm));
            % Add to r matrix 
            r(i,:,n) = pos_norm;
        end

        % Compute potential at the current time step
        for i = 2:nc
            for j = 1:i-1
                v(n) = v(n) + 1/(norm(r(j,:,n) - r(i,:,n)));
            end
        end 
    end

    % Compute equivalence classes
    v_ec = [1 2 3 4 5]; % DELETE ME 
end
