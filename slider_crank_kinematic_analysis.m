% Perform kinematic analysis of planar slider crank mechanism
% using the multibody formulation.
%
% The design goal is to implement the software as a general solver. While
% we will use it to analyse the slider crank, the same procedures can be
% used to analyse a wide variety of mechanisms. Like pendulums, or quick
% return mechanism. 
clear;

% TODO list - to implement our example and solve kinematic analysis on
% position level
% - [X] Create an empty system
% - [X] Add bodies
% - [X] Get coordinates
% - [X] Simple constraints
% - [X] Revolute joints
% - [X] Driving constraints
% - [X] Constrains equation
% - [X] Test call to fsolve
% - [X] Jacobian of constraint equations
% - [X] Use of Newton Raphson 
% - [X] Position analysis in time
% - [X] Velocity analysis in time

%% Firstly, create a system to hold all the information about the multibody
% system
sys = make_system();
% our system will be in mm and radians

% To have coordinates - create a structure with bodies
% ground = struct("name", "ground", "idx", 1:3, "q0", [0;0;0])
sys = add_body(sys, "ground");
sys = add_body(sys, "crank", [-100; 20; -deg2rad(31)]);
sys = add_body(sys, "link", [-400; 20; deg2rad(10)]);
sys = add_body(sys, "slider", [-500; 0.1; 0.1]);

%% Get coordinates for the whole system
% The vector will store coordinates for each body in order
% q = [x1; y1; fi1; x2; y2; fi2; ... xn; yx; fin];
q0 = assemble_coordinates(sys);

%% Simple constrains for our system
sys = add_simple_constrain(sys, "ground", "x", 0);
sys = add_simple_constrain(sys, "ground", "y", 0);
sys = add_simple_constrain(sys, "ground", "fi", 0);

sys = add_simple_constrain(sys, "slider", "y", 0);
sys = add_simple_constrain(sys, "slider", "fi", 0);

%% Add revolute joints to our system
sys = add_revolute_joint(sys, "ground", "crank", [0; 0], [100; 0]);
sys = add_revolute_joint(sys, "crank", "link", [-100; 0], [300; 0]);
sys = add_revolute_joint(sys, "link", "slider", [-200; 0], [0; 0]);

%% Add driving constrain
fi_crank_0 = -deg2rad(30);
omega = -1.2;
sys = add_driving_constrain(sys, "crank", "fi", ...
    @(t)fi_crank_0 + omega * t, @(t) omega, @(t) 0);

fprintf("We have a system with %d bodies, %d coordinates, and %d constrains.\n", ...
    number_of_bodies(sys), number_of_coordinates(sys), ...
    number_of_constrains(sys));

%% Constrain equations
C = constrains(sys, q0, 0);

%% Test call to fsolve
tic
q_fsolve = fsolve(@(q) constrains(sys, q, 0.0), q0);
toc

%% Check if constraints are met for fsolve
norm(constrains(sys, q_fsolve, 0.0))

%% Test call our Jacobian
Cq = jacobian_of_constrains(sys, q0);

% %% Only for verification to help check if jacobian in correct
% Cq_approximation = approximate_jacobian(@(q) constrains(sys, q, 0.0), q0);

%% Use of NR to get q
t = 0;
tic
[q, iteration_counter] = NR_method(@(q) constrains(sys, q, t), ...
    @(q) jacobian_of_constrains(sys, q), q0, 1e-12);
toc
if iteration_counter > 0
    disp("Kinematic solution on position level for t=0 works")
else
    disp("Kinematic solution on position level for t=0 DOES NOT work")
end

%% Check if constraints are met for NR solution
norm(constrains(sys, q, 0.0))

%% Kinematic analysis solution
T = 0:0.01:1;
[Q, Qp] = kinematic_analysis(sys, T);

%% make some plots to check the solution
plot(T, Q(6, :), "LineWidth", 3.0)

%% Plot the position of CMs
plot(0, 0, 'o', Q(4, :), Q(5, :), Q(7, :), Q(8, :), Q(10, :), Q(11, :), "LineWidth", 3.0)
xlabel("X [mm]")
ylabel("Y [mm]")
legend("Center of the world", ...
    "CM position of the crank", ...
    "CM position of the link", ...
    "CM position of the slider")
axis equal

%% Plot the velocities of CMs
figure
plot(0, 0, 'o', Qp(4, :), Qp(5, :), Qp(7, :), Qp(8, :), Qp(10, :), Qp(11, :), "LineWidth", 3.0)
xlabel("X [mm/s]")
ylabel("Y [mm/2]")
legend("Velocity of the center of the world", ...
    "CM velocity of the crank", ...
    "CM velocity of the link", ...
    "CM velocity of the slider")
axis equal
