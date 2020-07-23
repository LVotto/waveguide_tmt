function [xs, hs] = plot_mode(m, betas, k0, ws, ns, pol, nsamp, is_pow)
    if ~exist('nsamp', 'var')
        nsamp = 250;
    end
    if ~exist('pol', 'var')
        pol = 'te';
    end
    if ~exist('is_pow', 'var')
        is_pow = false;
    end
    % Assuming the greatest beta stands for mode 0
    beta = betas(end - m);    
    coeffs = tmt_coeffs(beta, k0, ws, ns, pol, true);
    if ~is_pow
        [xs, hs] = plotfield(beta, k0, ws, ns, coeffs, pol, nsamp);
    else
        [xs, hs] = plotfieldpow(beta, k0, ws, ns, coeffs, pol, nsamp);
    end
end