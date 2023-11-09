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
% - [ ] Get coordinates
% - [ ] Simple constraints
% - [ ] Revolute joints
% - [ ] Driving constraints
% - [ ] Test call to fsolve
% - [ ] Use of Newton Raphson 

% Firstly, create a system to hold all the information about the multibody
% system
sys = make_system();

% To have coordinates - create a structure with bodies
% ground = struct("name", "ground", "idx", 1:3, "q0", [0;0;0])
sys = add_body(sys, "ground");
