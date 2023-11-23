function Cq = jacobian_of_constrains(sys, q)
%JACOBIAN_OF_CONSTRAINS Return the matrix with Jacobian of constrain equations
Cq = zeros(number_of_constrains(sys), number_of_coordinates(sys));

for s = sys.constraints.simple
    Cq(s.constraint_indices, s.coordinate_idx) = 1;
end

for r = sys.constraints.revolute
    fi_i = q(r.bodyi_idx(3));
    fi_j = q(r.bodyj_idx(3));
    Cq(r.constraint_indices, r.bodyi_idx) = [eye(2), omega * rot(fi_i) * r.si_local];
    Cq(r.constraint_indices, r.bodyj_idx) = -[eye(2), omega * rot(fi_j) * r.sj_local];
end

for d = sys.constraints.driving
    Cq(d.constraint_indices, d.coordinate_idx) = 1;
end

end

