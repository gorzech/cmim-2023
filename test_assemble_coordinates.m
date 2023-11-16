%% Add two bodies and check the vector of initial coordinates
sys = make_system();
sys = add_body(sys, "ground", [1; 2; 3.5]);
sys = add_body(sys, "pendulum", [0; -7.12; 14]);

q0_expected = [1; 2; 3.5; 0; -7.12; 14];

q0 = assemble_coordinates(sys);

assert(length(q0) == 6);
assert(norm(q0_expected - q0) < 10*eps(10),...
    "The expected value of the coordinates is incorrect")