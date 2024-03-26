function pred = mhe(meas)

persistent mhe_initialized
persistent webviewer_init
persistent s a ua ca

if isempty(mhe_initialized),
    s = 'http://byu.apmonitor.com';
    a = ['mhe' int2str(10000*rand())];
    msg = mhe_init(s,a);
    disp(msg)
    mhe_initialized = true;
end

% input from block
T = meas(1);
Tc = meas(2);

% input measurements
apm_meas(s,a,'t',T);
apm_meas(s,a,'tc',Tc);

% solve MHE
output = apm(s,a,'solve');

% check if successful
if (apm_tag(s,a,'nlc.appstatus')==1),
    % retrieve solution
    ua = apm_tag(s,a,'ua.newval');
    ca = apm_tag(s,a,'ca.model');
else
    % display failed run
    disp(output)
    
    % switch to IPOPT
    apm_option(s,a,'nlc.solver',3);
    % try again
    output = apm(s,a,'solve');
    disp(output);
    
    if (apm_tag(s,a,'nlc.appstatus')==1),
        % retrieve solution
        ua = apm_tag(s,a,'ua.newval');
        ca = apm_tag(s,a,'ca.model');
    else
        ua = 0;
        ca = 0;
    end
end

% output from block
pred(1) = ca;
pred(2) = ua;

disp(['MHE results: Ca=' num2str(ca) ' UA (estimated)=' num2str(ua) ' UA (actual)=50000'])

% open web-viewer
if isempty(webviewer_init),
    apm_web(s,a);
    webviewer_init = true;
end

return