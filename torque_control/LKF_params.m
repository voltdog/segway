% theta - wheels average angle (theta = 0.5*(theta_l + theta_r)
% psi - CoM pitch angle
% phi - CoM yaw angle
% x = [i_theta theta psi d_theta d_psi phi d_phi]

% discretise plant model
sysd = c2d(s4, Ts);
Fd = sysd.A;
Gd = sysd.B;


x0_lkf = [0; 0; 0; 0; 0; 0; 0]; % initial state
% sigma_x = [10.1 
%            10.1 
%            10.1 
%            10.1 
%            10.1 
%            10.1 
%            10.1]; % variance of the state X
sigma_y  = [0.01 
            0.01 
            0.01 
            0.01 
            0.01]; % variance of measurements [theta psi d_theta d_psi phi d_phi]

% Q_lkf = [1000        0          0         0          0          0          0;
%          0          0.1        0          0          0          0          0;
%          0          0          0.1        0          0          0          0;
%          0          0          0          2000         0          0          0;
%          0          0          0          0          0.1        0          0;
%          0          0          0          0          0          0.1        0;
%          0          0          0          0          0          0          1];
Q_lkf = [Ts^4/4     Ts^3/2     0          Ts^2/2     0          0          0;
         Ts^3/2     Ts^2       0          Ts         0          0          0;
         0          0          1       0             Ts         0          0;
         Ts^2/2     Ts         0          1.4        0          0          0;
         0          0          Ts         0          20         0          0;
         0          0          0          0          0          Ts^2       Ts;
         0          0          0          0          0          Ts         1]*1;

% sigma_x = 0.1;
% Qa = zeros(7);
% Qa(4,4) = 1;
% Qa(5,5) = 1;
% Qa(7,7) = 1;
% Q_lkf = Fd * Qa * (Fd.');
R_lkf = [sigma_y(1) 0          0          0          0;
         0          sigma_y(2) 0          0          0;
         0          0          sigma_y(3) 0          0;
         0          0          0          sigma_y(4) 0;
         0          0          0          0          sigma_y(5)];

P0_lkf = eye(7)*0.1;

H_lkf = [0 1 0 0 0 0 0;
         0 0 1 0 0 0 0;
         0 0 0 0 1 0 0;
         0 0 0 0 0 1 0;
         0 0 0 0 0 0 1];

