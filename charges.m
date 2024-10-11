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

    % Compute dij matrix
    dij = zeros(nc); 
    for i = 1:nc
        for j = 1:nc
            dij(i, j) = norm(r(j,:,nt) - r(i,:,nt));
        end
    end
    % Sort each row of matrix to be in ascending order 
    dij_sorted = sort(dij, 2);

    % Vector for storing the number of charges in each equivalence class.
    % The number of equivalence classes is the number of nonzero entries 
    v_ec = zeros(1, nc);

    % Count number of rows that are the same for each index
    rows_already_matched = zeros(1, nc);
    for i = 1:nc
        if rows_already_matched(i) == 1
            continue
        end
        for j = 1:nc
            % Check if rows are the same 
            if all(abs(dij_sorted(j,:) - dij_sorted(i,:)) < epsec)
                v_ec(i) = v_ec(i) + 1;
                rows_already_matched(j) = 1;
            end 
        end
        % The row has been checked so no need to check it again
        rows_already_matched(i) = 1;
    end

    % Remove zero entries and sort in descending order
    v_ec(v_ec == 0) = [];
    v_ec = sort(v_ec, 'descend');

end
