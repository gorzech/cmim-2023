function sys = make_system(gravitational_acceleration, baumgarte_alpha, baumgarte_beta)
%MAKE_SYSTEM Create an empty placeholder for a multibody system
arguments
    gravitational_acceleration (2,1) double = [0; 0];
    baumgarte_alpha (1,1) double = 10;
    baumgarte_beta (1,1) double = 10;
end

sys = struct("bodies", []);
sys.constraints.simple = [];
sys.constraints.revolute = [];
sys.constraints.driving = [];
sys.gravitational_acceleration = gravitational_acceleration;
sys.baumgarte_velocity = 2 * baumgarte_alpha;
sys.baumgarte_position = baumgarte_beta ^ 2;
end