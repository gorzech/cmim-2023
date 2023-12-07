function [Q, Qp] = kinematic_analysis(sys, time)
%KINEMATIC_ANALYSIS Function to solve kinematic analysis problem in time

q0 = assemble_coordinates(sys);

dt = time(2) - time(1);
n_time = length(time);

Q = zeros(length(q0), n_time);
Qp = zeros(length(q0), n_time);

q0_ii = q0;
for ii = 1:n_time
    t_ii = time(ii);
    q_ii = kinematic_analysis_position(sys, q0_ii, t_ii);
    % position analysis is done - perform velocity analysis
    Cq = jacobian_of_constrains(sys, q_ii);
    Ct = constrains_dt(sys, t_ii);
    qp_ii = -Cq\Ct;

    Q(:, ii) = q_ii';
    Qp(:, ii) = qp_ii';
    q0_ii = q_ii + qp_ii * dt;
end

