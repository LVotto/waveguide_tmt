clear;
close all;
format longg;

%%% EXAMPLE 1: Orfanidis 9.12.1
% lambda0 = 1.55E-6; k0 = 2 * pi / lambda0;
% n1 = 1; n2 = 3.5; n3 = 1.45; w2 = 1E-6;
% ns = [n1, n2, n3]; ws = [0, w2, 0];
% folder = "./pictures/"; alias = "orf-9-12-1";
% load BETAS

%%% EXAMPLE 2: BH asked for this
% lambda0 = 1.5E-6; k0 = 2 * pi / lambda0;
% d = 2E-6; ws = [0, 2 * d, 20 * d, 100 * d, 0]; ns = [1, 3, 2.5, 5, 1];
% folder = "./pictures/"; alias = "bh-1";

%%% EXAMPLE 3: Marcuse
lambda0 = 1.5E-6; k0 = 2 * pi / lambda0;
d2 = 1E-6; s3 = 6E-7; d4 = 3E-7;

%%% EXAMPLE 3.1: Both waveguides
ns = [1, 3.3, 3.2, 3.5, 3]; ws = [0, d2, 2 * s3, d4, 0];
% folder = "./pictures/"; alias = "marc-both-s3-" + (s3 * 1E7);
% %%% EXAMPLE 3.2: Marcuse upper
% ns = [1, 3.3, 3.2]; ws = [0, d2, 0];
% folder = "./pictures/"; alias = "marc-uppr";
% %%% EXAMPLE 3.3: Marcuse lower
% ns = [3.2, 3.5, 3]; ws = [0, d4, 0];
%folder = "./pictures/"; alias = "marc-lowr";

% Acquire betas for both modes
te_betas = tmt_betas(k0, ns, ws, "te", true);
% tm_betas = tmt_betas(k0, ns, ws, "tm", false);

% Computing field figures for modes TE and TM
pol = "te"; betas = te_betas;
nsamp = 1000;
for m = 0:length(betas) - 1
%     filename = alias + "_" + pol + m + ".png";
%     fig = figure("Name", filename);
    figure;
    [xs, hs] = plot_mode(m, te_betas, k0, ws, ns, pol, nsamp);
    %saveas(fig, folder + filename);
end
% pol = "tm";  betas = tm_betas;
% for m = 0:length(betas) - 1
%     filename = alias + "_" + pol + m + ".png";
%     fig = figure("Name", filename);
%     [xs, hs] = plot_mode(m, tm_betas, k0, ws, ns, pol, nsamp);
% %    saveas(fig, folder + filename);
% end