function msg = init_sim(s,a)

addpath('apm')
apm(s,a,'clear all');

% load model and data files
apm_load(s,a,'sim.apm');
csv_load(s,a,'sim.csv');

% classify variables
apm_info(s,a,'FV','ua');
apm_info(s,a,'MV','tc');
apm_info(s,a,'SV','ca');
apm_info(s,a,'SV','t');

% options
apm_option(s,a,'nlc.imode',4); % 4 = simulation
apm_option(s,a,'nlc.nodes',3); % 3 = collocation nodes
apm_option(s,a,'nlc.solver',3); % 3 = IPOPT

% MV tuning
apm_option(s,a,'tc.fstatus',1); % measurement available (feedback status)

msg = 'Simulator Initialized';

return



