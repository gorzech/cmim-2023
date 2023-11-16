%% Does empty system has zero coordinates? 
sys = make_system();
nc = number_of_coordinates(sys);

assert(nc == 0, "New system has zero coordinates")

%% Does the system with two bodies has six coordinates? 
sys = make_system();
sys = add_body(sys, "ground");
sys = add_body(sys, "link");
nc = number_of_coordinates(sys);

assert(nc == 6, "System with two bodies must have six coordinates")
