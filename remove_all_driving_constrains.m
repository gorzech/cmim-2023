function sys = remove_all_driving_constrains(sys)
%REMOVE_ALL_DRIVING_CONSTRAINS Removes all driving constraints from the
%system
sys.constraints.driving = [];
