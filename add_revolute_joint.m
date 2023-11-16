function sys = add_revolute_joint(sys, bodyi_name, bodyj_name,...
    si_local, sj_local)
%ADD_REVOLUTE_JOINT Adds the definition of the revolute joint to the system

j.constraint_indices = number_of_constrains(sys) + (1:2);

bi = get_body(sys, bodyi_name);
j.bodyi_idx = bi.coordinate_indices;

bj = get_body(sys, bodyj_name);
j.bodyj_idx = bj.coordinate_indices;

j.si_local = si_local;
j.sj_local = sj_local;

sys.constraints.revolute = [sys.constraints.revolute, j];