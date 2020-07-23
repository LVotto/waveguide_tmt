function h = field(x, beta, k0, ws, ns, coeffs)
    ind = 1;
    for i = 1:length(ws) - 1
        ind = ind + heaviside(x - sum(ws(1:i)));
    end
    t = sum(ws(1:ind));
    gamma = sqrt(beta.^2 - k0.^2 .* ns(ind).^2);
    h = double(coeffs(1, ind) .* exp( gamma .* (x - t)) ...
      + coeffs(2, ind) .* exp(-gamma .* (x - t)));
end