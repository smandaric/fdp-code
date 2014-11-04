% Plots concentration profile of Ca++ for a simple diffusion case


% 50mM initial concentration
% Time its running must be specified in modl3 code
[uLabSpace xLabSpace tLabSpace] = modl3(.05, 1e-12, .5, 0);

% Plots 10 lines at linearly spaced time. Assuming 301 time steps
plotProfiles(a, b, c, floor(linspace(1,301,10)), 1);

