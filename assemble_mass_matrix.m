function m = assemble_mass_matrix(sys)
%ASSEMBLE_MASS_MATRIX Returns the global vector of body inertias
%   The vector will store coordinates for each body in consistent order
%   q0 = [m1; m1; Ic1; m2; m2; Ic2; ... mn; mn; Icn];
m = zeros(number_of_coordinates(sys), 1);
for b = sys.bodies
    m(b.coordinate_indices) = [b.mass; b.mass; b.rotational_inertia];
end

