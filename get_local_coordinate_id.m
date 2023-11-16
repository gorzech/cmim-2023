function c_idx = get_local_coordinate_id(constrain_coordinate)
switch constrain_coordinate
    case "x"
        c_idx = 1;
    case "y"
        c_idx = 2;
    case "fi"
        c_idx = 3;
    otherwise
        error("Unrecognized body coordinate name '%s'", constrain_coordinate)
end
end