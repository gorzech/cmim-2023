function sys = make_system()
%MAKE_SYSTEM Create an empty placeholder for a multibody system

sys = struct("bodies", []);
sys.constraints.simple = [];
sys.constraints.revolute = [];
end