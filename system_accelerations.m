function qdd = system_accelerations(sys, q, qd, t)
%SYSTEM_ACCELERATIONS Returns accelerations of the constrained multibody
%system

m = assemble_mass_matrix(sys);
Cq = jacobian_of_constrains(sys, q);
n_constr = number_of_constrains(sys);
LHS = [diag(m), Cq'
    Cq, zeros(n_constr, n_constr)];

f = forces(sys);
g = constrains_g_vector(sys, q, qd, t);
C = constrains(sys, q, t);
C_dot = Cq * qd + constrains_dt(sys, t);
rhs = [f
    g - sys.baumgarte_position .* C - sys.baumgarte_velocity .* C_dot];

qdd_lambda = LHS\rhs;

qdd = qdd_lambda(1:number_of_coordinates(sys));
