function f = forces(sys, q, t)
%FORCES Return the vector of generalized external forces
f = zeros(number_of_coordinates(sys), 1);

for b = sys.bodies
    f(b.coordinate_indices(1:2)) = b.mass * sys.gravitational_acceleration;
end

