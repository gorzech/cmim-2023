% Script to build on our kinematic solver and solve a simple dynamic
% problem of a single pendulum moving in the gravitational field.
clear;

%% TODO for dynamical solver
% [X] Add inertia information to the bodies
% [X] Assembly mass matrix
% [X] Add gravitational forces
% [X] Solve the free-fall example
% [ ] g vector for rotational joints
% [ ] Include alpha and beta in the system
% [ ] Generate equations of motion for the constrained system
% [ ] Solve equations of motion

% Note: we assume that the initial values of our coordinates may not be
% exact (so the equation C = 0 is not met). Therefore, before solving the
% dynamic problem, we should solve a kinematic one. 

%% Add inertia information to the system
% Units we are using are mm and grams
g = 9810; % mm / s^2
sys = make_system([0; -g]);

sys = add_body(sys, "ground");

pendulum_mass = 100;
pendulum_length = 100;
pendulum_inertia_center_of_mass = 1/12 * pendulum_mass * pendulum_length ^ 2;
sys = add_body(sys, "pendulum", [30; -50; -deg2rad(31)], ...
    pendulum_mass, pendulum_inertia_center_of_mass);

%% Get mass matrix
m = assemble_mass_matrix(sys);
f = forces(sys);

q_dd_0 = f ./ m;

%% Solution of the ODEs using the Euler-Cromer scheme

time = linspace(0, 1, 10001);
q0 = assemble_coordinates(sys);

dt = time(2) - time(1);
n_time = length(time);

Q = zeros(length(q0), n_time);
Qp = zeros(length(q0), n_time);

qn = q0;
qpn = zeros(size(q0));

Q(:, 1) = qn';
Qp(:, 1) = qpn';

m = assemble_mass_matrix(sys); % constant

for ii = 2 : n_time   
    f = forces(sys, qn, time(ii));
    qppn = f ./ m;
    qpn1 = qpn + dt * qppn;
    qn1 = qn + dt * qpn1;
    Q(:, ii) = qn1';
    Qp(:, ii) = qpn1';
    qn = qn1;
    qpn = qpn1;
end