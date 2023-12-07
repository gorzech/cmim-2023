function [Q, Qp] = ode_EulerCromer(qddfun, q0, qd0, time)
%ODE_EULERCROMER Generic implementation of the ODE solver using the
%semi-implicit Euler-Cromer scheme
%   qddfun - funciton that returns accelerations qdd = qddfun(q, qd, t)
%   q0 - initial coordinates
%   qd0 - initial velocities
%   time - time vector for which we want to get solutions

dt = time(2) - time(1);
n_time = length(time);

Q = zeros(length(q0), n_time);
Qp = zeros(length(q0), n_time);

qn = q0;
qpn = qd0;

Q(:, 1) = qn';
Qp(:, 1) = qpn';

for ii = 2 : n_time
    t_ii = time(ii);
    qppn = qddfun(qn, qpn, t_ii);

    qpn1 = qpn + dt * qppn;
    qn1 = qn + dt * qpn1;

    Q(:, ii) = qn1';
    Qp(:, ii) = qpn1';
    
    qn = qn1;
    qpn = qpn1;
end
end

