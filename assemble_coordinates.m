function q0 = assemble_coordinates(sys)
%ASSEMBLE_COORDINATES Returns the global vector of system coordinates from
%the bodies
%   The vector will store coordinates for each body in order
%   q0 = [x1; y1; fi1; x2; y2; fi2; ... xn; yn; fin];
q0 = zeros(number_of_coordinates(sys), 1);
for b = sys.bodies
    q0(b.coordinate_indices) = b.initial_coordinates;
end
end

