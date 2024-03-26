% theta - wheels average angle (theta = 0.5*(theta_l + theta_r)
% psi - CoM pitch angle
% phi - CoM yaw angle
% x = [i_theta theta psi d_theta d_psi phi d_phi]


x0_ekf = [0; 0; 0; 0; 0; 0; 0]; % initial state
% sigma_x = [10.1 
%            10.1 
%            10.1 
%            10.1 
%            10.1 
%            10.1 
%            10.1]; % variance of the state X
sigma_y_ekf  = [0.001 
            0.01 
            0.01 
            0.01 
            0.01]; % variance of measurements [theta psi d_theta d_psi phi d_phi]

Q_ekf = [0.1*Ts^4/4     Ts^3/2     0          Ts^2/2     0          0          0;
         Ts^3/2     2*Ts^2       0          Ts         0          0          0;
         0          0          100       0             0*Ts         0          0;
         Ts^2/2     Ts         0          1        0          0          0;
         0          0          0*Ts         0          50         0          0;
         0          0          0          0          0          100*Ts^2       50*Ts;
         0          0          0          0          0          50*Ts         50]*0.02;
% sigma_x = 0.1;
% Qa = zeros(7);
% Qa(4,4) = 1;
% Qa(5,5) = 1;
% Qa(7,7) = 1;
% Q_lkf = Fd * Qa * (Fd.');
R_ekf = [sigma_y_ekf(1) 0          0          0          0;
         0          sigma_y_ekf(2) 0          0          0;
         0          0          sigma_y_ekf(3) 0          0;
         0          0          0          sigma_y_ekf(4) 0;
         0          0          0          0          sigma_y_ekf(5)];

P0_ekf = eye(7)*0.1;

H_ekf = [0 1 0 0 0 0 0;
         0 0 1 0 0 0 0;
         0 0 0 0 1 0 0;
         0 0 0 0 0 1 0;
         0 0 0 0 0 0 1];

