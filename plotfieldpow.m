function [xs, hs] = plotfieldpow(beta, k0, ws, ns, coeffs, pol, nsamp)
    ts = zeros(1, length(ws));
    for i = 1:length(ws)
        ts(i) = sum(ws(1:i));
    end
    ts(1) = -max(ws);
    ts(end) = ts(end - 1) + max(ws);
    xs = linspace(ts(1), ts(end), nsamp);
    hs = zeros(1, length(xs));
    for i = 1:length(xs)
        hs(i) = imag(field(xs(i), beta, k0, ws, ns, coeffs)) .^ 2;
    end
    plot(xs, hs);
    hold on;
    pbaspect([(1 + sqrt(5)) / 2, 1, 1]);
    uy = max(ylim); ly = min(ylim);
    greys = [linspace(0, 1, length(unique(ns))); sort(unique(ns))];
    grey = zeros(1, length(ns));
    for i = 1:length(ns)
        col = find(greys(2,:) == ns(i));
        grey(i) = greys(1, col);
    end
    white = ones(1, 3);
    alpha_value = .18;
    patches = zeros(length(ws));
    patches(1) = patch([ts(1) ts(1) 0 0],       ...
        [ly uy uy ly], (1 - grey(1)) * white)   ;
    alpha(patches(1), alpha_value);
    ts(1) = 0;
    for i = 2:length(ws)
        patches(i) = patch([ts(i - 1) ts(i - 1) ts(i) ts(i)],   ...
            [ly uy uy ly], (1 - grey(i)) * white)               ;
        alpha(patches(i), alpha_value);
    end
    grid on;
    plot(xs, hs, 'LineWidth', 2, 'color', [.5 0 .5]);
    set(gca, 'YTickLabel', []); xlim([-max(ws), ts(end)]);
    xlabel("$x\ [m]$", "Interpreter", "latex");
    ylabel("Distribuição de Potência [U.A.]");
    hold off
end