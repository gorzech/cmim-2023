%% Does empty system has zero coordinates? 
sys = make_system();
nc = number_of_coordinates(sys);

assert(nc == 0, "New system has zero coordinates")