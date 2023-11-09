function sys = add_body(sys, name, initial_coordinates)
%ADD_BODY Adds body to the multibody system sys 
%   Body that is added to the multibody system is defined by it name and
%   initial_coordinates. 
%   initial_coordinates holds the value of the x, y, and theta coordinates.
%   Missing values of the coordinates are assumed to be zero. 
arguments
    sys(1,1) struct;
    name string {mustBeNonempty};
    initial_coordinates (3,1) double {mustBeFinite} = [0; 0; 0];
end

body.name = name;
body.initial_coordinates = initial_coordinates;
body.coordinate_indices = number_of_coordinates(sys) + (1:3);

sys.bodies = [sys.bodies, body];
end