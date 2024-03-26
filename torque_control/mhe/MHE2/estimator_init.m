function [] = estimator_init(s,a)

global u_control

    % Clear previous application
    apm(s,a,'clear all');

    %Load model
    apm_load(s,a,'model.apm');

    % load data
    csv_load(s,a,'estimator.csv');

    %Define Parameters
    apm_info(s,a,'FV','K');
    apm_info(s,a,'FV','tau');

    %Define Manipulated Variables
    apm_info(s,a,'MV','u');

    %Define Controlled / Measured Variables
    apm_info(s,a,'CV','x');

    %Moving Horizon Estimation mode
    apm_option(s,a,'nlc.imode',5);

    % set some additional options
    apm_option(s,a,'nlc.ev_type',1);
    apm_option(s,a,'nlc.mv_type',0);
    apm_option(s,a,'nlc.solver',1);

    % some additional options
    %apm_option(s,a,'nlc.coldstart',1);
    apm_option(s,a,'nlc.mv_step_hor',1);
    apm_option(s,a,'nlc.hist_hor',100);
    apm_option(s,a,'nlc.web_plot_freq',5);
    
    %setup CV (x) 
    % turn this on later after initialization
    apm_option(s,a,'x.fstatus',0);
    
    %setup FV (K) 
    apm_option(s,a,'K.status',1);
    apm_option(s,a,'K.fstatus',0);
    apm_option(s,a,'K.lower',0);
    apm_option(s,a,'K.upper',10);
    apm_option(s,a,'K.dmax',1);  % rate of change limits

    %setup MV (u) 
    apm_option(s,a,'u.status',0);
    apm_option(s,a,'u.fstatus',1);
    % initialize u_control
    u_control = 0;
    
    % time units (1=sec, 2=min, 3=hr, 4=day, 5=yr)
    apm_option(s,a,'nlc.ctrl_units',1);

    % read csv file
    apm_option(s,a,'nlc.csv_read',1);
end