%% Does system store bodies?
sys = make_system();
assert(isfield(sys, "bodies"), "System does not contain place for bodies")

%% Are bodies empty after system creation
sys = make_system();
assert(isempty(sys.bodies), "The bodies of the newly created syste are not empty")
