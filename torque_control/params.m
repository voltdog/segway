Ts = 0.01;
%% Physical constants
g = 9.81;                       % gravity acceleration [m/sec^2]
%% Physical parameters
m = 1.54;						% wheel weight [kg]
hw = 0.054;                      % wheel width [m]
R = 0.122;						% wheel radius [m]
Jw = m * R^2 / 2;				% wheel inertia moment [kgm^2]
Jwx = m * (3*R^2 + hw^2) / 12;  % wheel inertia moment around x and y axes
M = 7.03;                        % body weight [kg]
W = 0.42;						% body width [m]
D = 0.2;						% body depth [m]
h = 0.39;						% body height [m]
L = h / 2;						% distance of the center of mass from the wheel axle [m]
Jpsi = M * L^2 / 3;				% body pitch inertia moment [kgm^2]
Jphi = M * (W^2 + D^2) / 12;	% body yaw inertia moment [kgm^2]
fm = 0.0022;					% friction coefficient between body & DC motor
fw = 0.0;           			% friction coefficient between wheel & floor
%% Motors parameters
Jm = 1e-5;						% DC motor inertia moment [kgm^2]
Kt = 2.28;%0.437;%0.717;						% DC motor torque constant [Nm/A]
n = 1;							% Gear ratio

Psi0 = 0.01;                    % Initial value to make disturbance