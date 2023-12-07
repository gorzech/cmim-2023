function g = constrains_g_vector(sys, q, qd, t)
%CONSTRAINS_G_VECTOR Return the vector of the second derivative of 
% constrain equations without acceleration terms
g = zeros(number_of_constrains(sys), 1);

for r = sys.constraints.revolute
    fi_i = q(r.bodyi_idx(3));
    fi_d_i = qd(r.bodyi_idx(3));
    fi_j = q(r.bodyj_idx(3));
    fi_d_j = qd(r.bodyj_idx(3));
    g(r.constraint_indices) = rot(fi_i) * r.si_local * fi_d_i^2 ...
        - rot(fi_j) * r.sj_local * fi_d_j^2;
end

for d = sys.constraints.driving
    cf_dd = d.coordinate_acceleration(t);
    g(d.constraint_indices) = cf_dd;
end

end

