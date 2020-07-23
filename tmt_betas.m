function betas = tmt_betas(k0, ns, ws, pol, eliminate_local_mins)
    if nargin == 4
        eliminate_local_mins = false;
    end
    bmin = k0 * min(real(ns)); bmax = k0 * max(real(ns));
    bs = linspace(bmin, bmax, 1000001); fs = zeros(1, length(bs));
    for i = 1:length(bs)
        fs(i) = abs(1 / transc(bs(i), k0, ws, ns, pol)) ^ 2;
    end
    [~, is] = findpeaks(fs);
    betas = bs(is);
    if eliminate_local_mins
        the_betas = [];
        for beta = betas
            if abs(transc(beta, k0, ws, ns, pol)) .^ 2 < 1E-6
                the_betas = [the_betas, beta];
            end
        end
        betas = the_betas;
    end
    
    betas = unique(betas);
    betas = betas(~isnan(betas));
    betas = sort(betas);
    betas = betas(betas~=0);
end