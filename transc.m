function t = transc(b, k0, ws, ns, pol)
    tm = eye(2, 2);
    for j = 2:length(ns)
        tm = tm * tmt_matrix(j, b, k0, ws, ns, pol);
    end
    t = tm(2, 2);
end