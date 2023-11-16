function A = rot(fi)
%ROT Rotational matrix
sfi = sin(fi);
cfi = cos(fi);
A = [cfi, -sfi
    sfi, cfi];
end

