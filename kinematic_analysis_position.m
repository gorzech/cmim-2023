function q_ii = kinematic_analysis_position(sys, q0_ii, t_ii)
%KINEMATIC_ANALYSIS_POSITION Single step kinematic analysis on poision
%level
[q_ii, iteration_counter] = NR_method(@(q) constrains(sys, q, t_ii), ...
    @(q) jacobian_of_constrains(sys, q), q0_ii, 1e-12);
if iteration_counter < 0
    error("Kinematic solution on position level for t=%g DOES NOT work", t_ii);
end

