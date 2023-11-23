function Ct = constrains_dt(sys, t)
%CONSTRAINS_DT Return the vector of derivative of constrain with respect to
%time
Ct = zeros(number_of_constrains(sys), 1);

for d = sys.constraints.driving
    cf_dt = d.coordinate_velocity(t);
    Ct(d.constraint_indices) = -cf_dt;
end

end

