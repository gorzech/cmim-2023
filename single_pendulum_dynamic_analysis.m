% Script to build on our kinematic solver and solve a simple dynamic
% problem of a single pendulum moving in the gravitational field.
clear;

%% TODO for dynamical solver
% [X] Add inertia information to the bodies
% [X] Assembly mass matrix
% [X] Add gravitational forces
% [X] Solve the free-fall example
% [X] g vector for rotational joints
% [X] complete definition of the pendulum system
% [X] Solve the system kinematically to get initial coordinate values
% [X] Include alpha and beta in the system
% [X] Generate equations of motion for the constrained system
% [X] Solve equations of motion
% [ ] Verify the results

% Note: we assume that the initial values of our coordinates may not be
% exact (so the equation C = 0 is not met). Therefore, before solving the
% dynamic problem, we should solve a kinematic one. 

%% Add inertia information to the system
% Units we are using are mm and grams
g = 9810; % mm / s^2
sys = make_system([0; -g], 100, 100);

sys = add_body(sys, "ground");

pendulum_mass = 100;
pendulum_length = 100;
pendulum_inertia_center_of_mass = 1/12 * pendulum_mass * pendulum_length ^ 2;
sys = add_body(sys, "pendulum", [30; -50; -deg2rad(31)], ...
    pendulum_mass, pendulum_inertia_center_of_mass);

%% Add joints
sys = add_simple_constrain(sys, "ground", "x", 0);
sys = add_simple_constrain(sys, "ground", "y", 0);
sys = add_simple_constrain(sys, "ground", "fi", 0);

sys = add_revolute_joint(sys, "ground", "pendulum", [0; 0], [-50; 0]);

%% Get mass matrix
m = assemble_mass_matrix(sys);
f = forces(sys);

q_dd_0 = f ./ m;

%% Test if g vector works
q0 = assemble_coordinates(sys);
qd0 = ones(size(q0));

g_joints = constrains_g_vector(sys, q0, qd0, 0.0);

%% Kinematic solution to get consistent q0

% How to do this? 
% 1. Add driving contraints to complement the system (so Jacobian has a
% full rank)
% 2. Run kinematic solution on the position level to get q0 at t = 0
% 3. Remove driving constraints from 1 and proceed with dynamical solution

sys = add_driving_constrain(sys, "pendulum", "fi", @(t) -deg2rad(30), @(t) 0, @(t) 0);
q0 = kinematic_analysis_position(sys, q0, 0);
sys = remove_all_driving_constrains(sys);
C0 = constrains(sys, q0, 0)

%% Equations of motion for the constrained MBD system

t0 = 0;
qd0 = zeros(size(q0));
qdd0 = system_accelerations(sys, q0, qd0, t0);

%% Solution of the ODEs using the Euler-Cromer scheme

time = linspace(0, 10, 10001);

[Q, Qp] = ode_EulerCromer(@(q, qd, t) system_accelerations(sys, q, qd, t), ...
    q0, qd0, time);

%% Plots for the position and see if they looks reasonable

plot(time, Q(4, :), 'LineWidth', 3)
xlabel('Time [s]')
grid on
fontsize(24, "points")
fontname("Gill Sans")

%% Plot the CM trajectory

plot(Q(4, :), Q(5, :), 'LineWidth', 3)
xlabel('X [m]')
xlabel('Y [m]')
grid on
axis equal
fontsize(24, "points")
fontname("Gill Sans")

%% Check the constrains

C_in_time = zeros(number_of_constrains(sys), length(time));

for ii = 1:length(time)
    t_ii = time(ii);
    C = constrains(sys, Q(:, ii), t_ii);
    C_in_time(:, ii) = C;
end

%% Plot constrains in time

plot(time, C_in_time(1:5, :), 'LineWidth', 3)
xlabel('Time [s]')
grid on
fontsize(24, "points")
fontname("Gill Sans")
