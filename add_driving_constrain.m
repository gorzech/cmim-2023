function sys = add_driving_constrain(sys, body_name,...
    constrain_coordinate, coordinate_function, ...
    coordinate_velocity, coordinate_acceleration)
%ADD_DRIVING_CONSTRAIN Add definition of driving constrain to the system
b = get_body(sys, body_name);
c_idx = get_local_coordinate_id(constrain_coordinate);

c.coordinate_idx = b.coordinate_indices(c_idx);
c.coordinate_function = coordinate_function;
c.coordinate_velocity = coordinate_velocity;
c.coordinate_acceleration = coordinate_acceleration;

c.constraint_indices = number_of_constrains(sys) + 1;

sys.constraints.driving = [sys.constraints.driving, c];
end
