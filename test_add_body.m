%% Does adding body ground to a new system work?
sys = make_system();
sys = add_body(sys, "ground");
assert(length(sys.bodies) == 1, ...
    "The number of the bodies in the system is incorrect after adding one body", ...
    length(sys.bodies));

%% Check indices of the added body
sys = make_system();
sys = add_body(sys, "ground");

body = sys.bodies(1);
assert(all(body.coordinate_indices == 1:3))

%% Check name of the added body
sys = make_system();
sys = add_body(sys, "ground");

body = sys.bodies(1);
assert(body.name == "ground")

%% Check coordinates of the added body (default to zero)
sys = make_system();
sys = add_body(sys, "ground");

body = sys.bodies(1);
assert(all(body.initial_coordinates == zeros(3,1)))

%% Check coordinates of the added body
sys = make_system();
q0 = rand(3, 1);
sys = add_body(sys, "ground", q0);

body = sys.bodies(1);
assert(all(body.initial_coordinates == q0))

%% Check if you can add more bodies
sys = make_system();
sys = add_body(sys, "ground");
sys = add_body(sys, "link");

assert(length(sys.bodies) == 2)
body = sys.bodies(2);
assert(body.name == "link")
body = sys.bodies(1);
assert(body.name == "ground")