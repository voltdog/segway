% theta - wheels average angle (theta = 0.5*(theta_l + theta_r)
% psi - CoM pitch angle
% phi - CoM yaw angle
% x = [i_theta theta psi d_theta d_psi phi d_phi]

x0_ukf = [0; 0; 0; 0; 0; 0; 0]; % initial state

% sigma transform parameters
N_ukf = length(x0_ukf);
kappa_ukf = 0; %3 - N; % tuning parameter
alpha_ukf = 0.1; % tuning parameter. The higher alpha the higher spread of sigma points
beta_ukf = 2; % Gaussian distribution
lambda_ukf = alpha_ukf^2 * (N_ukf + kappa_ukf) - N_ukf;

w0_m = lambda_ukf/(N_ukf+lambda_ukf);
w0_c = lambda_ukf/(N_ukf+lambda_ukf) + 1 - alpha_ukf^2 + beta_ukf;
wi = 1/(2*(N_ukf+lambda_ukf));

w_m_ukf = wi*ones([1, 2*N_ukf+1]);
w_m_ukf(1) = w0_m;
% w_m_ukf(1,2) = w0_m;

w_c_ukf = diag(wi*ones([1, 2*N_ukf+1]));
w_c_ukf(1,1) = w0_c;


chi0 = zeros(N_ukf, 2*N_ukf+1);
Z0_ukf = zeros(5, 2*N_ukf+1);

% Filter parameters
sigma_y_ukf  = [0.001 
            0.01 
            0.01 
            0.01 
            0.01]; % variance of measurements [theta psi d_theta d_psi phi d_phi]

% Q_ukf = [Ts^8/16     Ts^6/12    0          Ts^6/12     0          0          0;
%          Ts^6/12     0.25*Ts^4  0          0.5*Ts^3         0          0          0;
%          0          0          640        0             320*Ts         0          0;
%          Ts^6/12     0.5*Ts^3   0          Ts^2        0          0          0;
%          0          0          320*Ts     0          320         0          0;
%          0          0          0          0          0          10*Ts^2       5*Ts;
%          0          0          0          0          0          5*Ts         5]*0.01;
Q_ukf = [0.0025*Ts^4 Ts^3/2     0          Ts^2/2     0          0          0;
         Ts^3/2      0.01*Ts^2  0          0.01*Ts         0          0          0;
         0           0          100       0             0*Ts         0          0;
         Ts^2      0.01*Ts      0          100        0          0          0;
         0           0          0*Ts         0          50         0          0;
         0           0          0          0          0          100*Ts^2       50*Ts;
         0           0          0          0          0          50*Ts         50]*0.02;

R_ukf = [sigma_y_ukf(1) 0          0          0          0;
         0          sigma_y_ukf(2) 0          0          0;
         0          0          sigma_y_ukf(3) 0          0;
         0          0          0          sigma_y_ukf(4) 0;
         0          0          0          0          sigma_y_ukf(5)];

P0_ukf = eye(7)*0.1;

H_ukf = [0 1 0 0 0 0 0;
         0 0 1 0 0 0 0;
         0 0 0 0 1 0 0;
         0 0 0 0 0 1 0;
         0 0 0 0 0 0 1];

