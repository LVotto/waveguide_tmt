clear;
close all;
format longg;

% EX SCHLERETH
% lambda0 = 6.7E-6; k0 = 2 * pi / lambda0;
% d2 = .25E-6; neff = 4.61; decay = 37.6 * 100; scaling = 10; %%% FIG 4
% % d2 = 2E-6; neff = 4.75; decay = .6 * 100; scaling = 100;  %%% FIG 3
% d3 = .5E-6; d4 = 4E-6;
% n1 = 2.6 - 1j * 36.5; n2 = 4.6; n3 = 5.2; n4 = 4.6; n5 = 5.2 - 1j * 0.01;
% ns = [n1, n2, n3, n4, n5]; ws = [0, d2, d3, d4, 0];
% ns0 = real(ns(2:4)); ws0 = [0, d2, 0]; delta_min = 1E-9;

% EX PROFESSOR
lambda0 = 1.5E-6; k0 = 2 * pi / lambda0;
d2 = 1E-6; d3 = .4E-6; ws = [0, d2, d3, 0]; nim5 = -1E-3j;
ns = [1, 2, 1.5, 3.5 + nim5];
ns0 = real(ns(1:3)); ws0 = [0, d2, 0]; delta_min = 1E-9;

pol = "te"; % te_betas = tmt_betas(k0, ns, ws, pol, true)
mybetas0 = tmt_betas(k0, ns0, ws0, pol); myneffs0 = mybetas0 / k0
mybeta = tmt_beta_comp(k0, ns, ws, pol, ns0, ws0, delta_min, true);

% myneff = 4.6040 - 1j * 1.9980e-05; mybeta = k0 * myneff;
% paper_neff = neff - 1j * decay / 2 / k0
myneff = mybeta / k0
[xs, hs] = plot_mode(0, mybeta, k0, ws, ns, pol, 1000, true);
hold on
scaling = 100;
ylim(ylim)
xxs = xs(xs > sum(ws(1:end-2)));
hhs = scaling * hs((length(xs) - length(xxs) + 1):end);
plot(xxs, hhs, '-.', "color", [1, 0, 0]);
hold off