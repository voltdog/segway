function output = estimator_new(input)

persistent estimator_initialize
persistent s a

xmeas = input(1);
umeas = input(2);

% Only execute first cycle ----------------------------------
if (isempty(estimator_initialize)),
    addpath('apm');

    % Define Server
    s = 'http://xps.apmonitor.com';

    % Define application name
    a = 'mhe_john';

    % Initialize application
    estimator_new_init(s,a);
end

% insert measurements
apm_meas(s,a,'x',xmeas);
apm_meas(s,a,'u',umeas);

% solve and display output
solver_output = apm(s,a,'solve');
disp(solver_output)

% check solution status
status = apm_tag(s,a,'nlc.appstatus');

% get cpu time
cpu_time = apm_tag(s,a,'nlc.solvetime');

disp(['Application Status: ' int2str(status) ' CPU Time: ' num2str(cpu_time)]);

output(1) = apm_tag(s,a,'K.NEWVAL');

% Only load web-viewer on first cycle ----------------------------------
if (isempty(estimator_initialize)),
    % Open a web viewer
    apm_web(s,a);
        
    % Turn on feedback status after first cycle
    % for some reason the simulink is giving values of zero for the
    %   first cycle - discard these by turning on FSTATUS after the
    %   initial cycle
    apm_option(s,a,'x.fstatus',1);
   
    estimator_initialize = true;
end

end