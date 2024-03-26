function msg = init_mhe(s,a)

addpath('apm')
apm(s,a,'clear all');

% load model and data files
apm_load(s,a,'mhe.apm');
csv_load(s,a,'mhe.csv');

% classify variables
apm_info(s,a,'FV','ua');
apm_info(s,a,'MV','tc');
apm_info(s,a,'SV','ca');
apm_info(s,a,'CV','t');

% options
apm_option(s,a,'nlc.imode',5); % 5 = MHE
apm_option(s,a,'nlc.ev_type',1); % 1 = l1-norm, 2 = sq_error
apm_option(s,a,'nlc.nodes',3); % 3 = collocation nodes
apm_option(s,a,'nlc.solver',3); % 3 = IPOPT

% FV tuning
apm_option(s,a,'ua.status',1); % estimate this parameter
apm_option(s,a,'ua.fstatus',0); % no measurement (feedback status)
apm_option(s,a,'ua.lower',10000); % lower bound
apm_option(s,a,'ua.upper',100000); % upper bound

% MV tuning
apm_option(s,a,'tc.status',0); % don't estimate this parameter
apm_option(s,a,'tc.fstatus',1); % measurement available (feedback status)

% CV tuning
apm_option(s,a,'t.status',1); % estimate this parameter
apm_option(s,a,'t.fstatus',1); % measurement available (feedback status)
apm_option(s,a,'t.meas_gap',0.1); % measurement deadband gap

msg = 'MHE Initialized';

return



