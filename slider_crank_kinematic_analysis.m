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
% - [ ] Simple constraints
% - [ ] Revolute joints
% - [ ] Driving constraints
% - [ ] Test call to fsolve
% - [ ] Use of Newton Raphson 

%% Firstly, create a system to hold all the information about the multibody
% system
sys = make_system();
% our system will be in mm and radians

% To have coordinates - create a structure with bodies
% ground = struct("name", "ground", "idx", 1:3, "q0", [0;0;0])
sys = add_body(sys, "ground");
sys = add_body(sys, "crank", [-100; 20; -deg2rad(30)]);
sys = add_body(sys, "link", [-400; 20; deg2rad(10)]);
sys = add_body(sys, "slider", [-500; 0; 0]);

fprintf("We have a system with %d bodies and %d coordinates.\n", ...
    number_of_bodies(sys), number_of_coordinates(sys));

%% Get coordinates for the whole system
% The vector will store coordinates for each body in order
% q = [x1; y1; fi1; x2; y2; fi2; ... xn; yx; fin];
q0 = assemble_coordinates(sys);

%% Simple constrains for our system
sys = add_simple_constrain(sys, "ground", "x");
sys = add_simple_constrain(sys, "ground", "y");
sys = add_simple_constrain(sys, "ground", "fi");





