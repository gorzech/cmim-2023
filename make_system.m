function sys = make_system(gravitational_acceleration)
%MAKE_SYSTEM Create an empty placeholder for a multibody system
arguments
    gravitational_acceleration (2,1) double = [0; 0];
end

sys = struct("bodies", []);
sys.constraints.simple = [];
sys.constraints.revolute = [];
sys.constraints.driving = [];
sys.gravitational_acceleration = gravitational_acceleration;
end