function beta = tmt_beta_comp(k0, ns, ws, pol, ns0, ws0, delta_min, verbose)
    if ~exist('delta_min', 'var')
        delta_min = 1E-4;
    end
    if ~exist('verbose', 'var')
        verbose = false;
    end
    betas = double(tmt_betas(k0, ns0, ws0, pol));
    beta = betas(end);
%     neff = 4.6040; beta = k0 * neff;
%     syms b;
%     bmin = k0 * min(ns); bmax = k0 * max(ns);
%     assume(b >= bmin | b <= bmax);
%     tm = eye(2, 2);
%     for j = 2:length(ns)
%         tm = tm * tmt_matrix(j, b, k0, ws, ns, pol);
%     end
%     tosolve = tm(2, 2);
%     tomin = @(x) abs(double(subs(tosolve, x))) .^ 2; 

    tomin = @(x) abs(transc(x, k0, ws, ns, pol)) .^ 2;

    delta = 1E-3 * k0; F = tomin(beta); iterations = 0; max_it = 1000;
    frame = [-1, 1, -1j, 1j]; delta_F = 0; 
    while delta > delta_min && iterations < max_it
        if mod(iterations, 10) == 0 && verbose
            disp("Iterations: " + string(iterations) + ",");
            disp("Neff = " + string(beta / k0) + ",");
            disp("delta_eff = " + string(delta / k0));
        end
        bs = frame * delta + beta;
        Fs = zeros(1, length(bs));
        for i = 1:length(bs)
            Fs(i) = tomin(bs(i));
        end
        [F0, pos] = min(Fs);
        beta = beta + frame(pos) * delta;
        delta_F0 = abs(F - F0);
        if all(abs(F0 - F) < .02 * F0) || delta_F == delta_F0
            delta = delta / 2;
        end
        F = F0; delta_F = delta_F0;
        iterations = iterations + 1;
    end
    disp("Total number of iterations: " + string(iterations));
end