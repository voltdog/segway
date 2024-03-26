function output = controller(input)

persistent controller_initialize
persistent s a
global u_control

K_mhe = input(1);
xmeas = input(2);

% Only execute first cycle ----------------------------------
if (isempty(controller_initialize)),
    addpath('apm');

    % Define Server
    s = 'http://xps.apmonitor.com';

    % Define application name
    a = 'nmpc';

    % Initialize application
    controller_init(s,a);
end

% insert values into model
apm_meas(s,a,'K',K_mhe);
apm_meas(s,a,'x',xmeas);

% solve and display output
solver_output = apm(s,a,'solve');
disp(solver_output)

% check solution status
status = apm_tag(s,a,'nlc.appstatus');

% get cpu time
cpu_time = apm_tag(s,a,'nlc.solvetime');

disp(['Application Status: ' int2str(status) ' CPU Time: ' num2str(cpu_time)]);

u_control = apm_tag(s,a,'u.NEWVAL');

output(1) = u_control;

% Only load web-viewer on first cycle ----------------------------------
if (isempty(controller_initialize)),
    % Open a web viewer
    apm_web(s,a);
        
    % Turn on feedback status after first cycle
    % for some reason the simulink is giving values of zero for the
    %   first cycle - discard these by turning on FSTATUS after the
    %   initial cycle
    apm_option(s,a,'x.fstatus',1);
   
    controller_initialize = true;
end

end