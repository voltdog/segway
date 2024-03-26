clear all; close all; clc

% specify server and application name
s = 'http://byu.apmonitor.com';
% the process
a1 = ['cstr' int2str(10000*rand())]; % randomize part of the name
% the model / estimator
a2 = ['mhe' int2str(10000*rand())];  % randomize part of the name

% initialize cstr simulator (plant)
msg = init_sim(s,a1);
disp(msg)
% initialize moving horizon estimation (model)
msg = init_mhe(s,a2);
disp(msg)

% number of cycles to run
cycles = 50;

% step in the jacket cooling temperature at cycle 6
Tc_meas(1:5) = 280;
Tc_meas(6:cycles) = 300;
dt = 0.1; % min
time = linspace(0,cycles*dt-dt,cycles); % time points

for i = 1:cycles,
    
    %% Process
    % input Tc (jacket cooling temperature)
    apm_meas(s,a1,'Tc',Tc_meas(i));
    % solve process model, 1 time step
    output = apm(s,a1,'solve');
    % retrieve Ca and T measurements from the process
    Ca_meas(i) = apm_tag(s,a1,'Ca.model');
    T_meas(i) = apm_tag(s,a1,'T.model');
    
    %% Estimator
    % input process measurements, don't use Ca_meas
    % input Tc (jacket cooling temperature)
    apm_meas(s,a2,'Tc',Tc_meas(i));
    % input T (reactor temperature)
    apm_meas(s,a2,'T',T_meas(i));
    % solve process model, 1 time step
    output = apm(s,a2,'solve');
     % check if successful
    if (apm_tag(s,a2,'nlc.appstatus')==1),
        % retrieve solution
        UA_mhe(i) = apm_tag(s,a2,'UA.newval');
        Ca_mhe(i) = apm_tag(s,a2,'Ca.model');
        T_mhe(i) = apm_tag(s,a2,'T.model');
    else
        % display failed run
        disp(output)        
        % failed solution
        UA_mhe(i) = 0;
        Ca_mhe(i) = 0;
        T_mhe(i) = 0;
    end
        
    disp(['MHE results: Ca (estimated)=' num2str(Ca_mhe(i)) ...
        ' Ca (actual)=' num2str(Ca_meas(i))...
        ' UA (estimated)=' num2str(UA_mhe(i))...
        ' UA (actual)=50000'])
    
    % open web-viewer on first cycle
    if i==1,
        apm_web(s,a2);
    end    
end

% plot results
figure(1)
subplot(4,1,1)
plot(time,Tc_meas,'k-','LineWidth',2)
ylabel('Jacket T (K)')
legend('T_c')

subplot(4,1,2)
plot(time,ones(size(time))*50000,'k--')
hold on
plot(time,UA_mhe,'r:','LineWidth',2)
axis([0 time(end) 10000 100000])
ylabel('UA')
legend('Actual UA','Predicted UA')

subplot(4,1,3)
plot(time,T_meas,'ro')
hold on
plot(time,T_mhe,'b-','LineWidth',2)
ylabel('Reactor T (K)')
legend('Measured T','Predicted T')

subplot(4,1,4)
plot(time,Ca_meas,'go')
hold on
plot(time,Ca_mhe,'m-','LineWidth',2)
ylabel('Reactor C_a (mol/L)')
legend('Measured C_a','Predicted C_a')
