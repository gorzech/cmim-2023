function sys = add_simple_constrain(sys, body_name,...
    constrain_coordinate, coordinate_value)
%ADD_SIMPLE_CONSTRAIN Add definition of simple constrain to the system
b = get_body(sys, body_name);
c_idx = get_local_coordinate_id(constrain_coordinate);

c.coordinate_idx = b.coordinate_indices(c_idx);
c.coordinate_value = coordinate_value;
c.constraint_indices = number_of_constrains(sys) + 1;

sys.constraints.simple = [sys.constraints.simple, c];
end
