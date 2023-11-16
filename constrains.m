function C = constrains(sys, q, t)
%CONSTRAINS Return the vector of constrain equations
C = zeros(number_of_constrains(sys), 1);

for s = sys.constraints.simple
    C(s.constraint_indices) = q(s.coordinate_idx) - s.coordinate_value;
end

for r = sys.constraints.revolute
    r_i = q(r.bodyi_idx(1:2));
    fi_i = q(r.bodyi_idx(3));
    r_j = q(r.bodyj_idx(1:2));
    fi_j = q(r.bodyj_idx(3));
    C(r.constraint_indices) = r_i ...
        + rot(fi_i) * r.si_local ...
        - r_j ...
        - rot(fi_j) * r.sj_local;
end

for d = sys.constraints.driving
    cf = d.coordinate_function(t);
    C(d.constraint_indices) = q(d.coordinate_idx) - cf;
end

end

