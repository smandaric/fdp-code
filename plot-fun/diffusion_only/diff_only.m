[uLabSpace, xLabSpace, tLabSpace] = modl3(1, 1e-11, .5, 0);
% with endtime at 1200 = 4*300 and xmesh = 1000

plotProfiles(uLabSpace, xLabSpace, tLabSpace, ceil([1 31 61 91 121 151 181 211 241 301]/4), [1 2], 'crop')