%% 7-state controller
% QQ = [1     0     0     0     0     0     0;
%       0     1     0     0     0     0     0;
%       0     0     1     0     0     0     0;
%       0     0     0     1     0     0     0;
%       0     0     0     0     1     0     0;
%       0     0     0     0     0     0.1     0;
%       0     0     0     0     0     0     1000];
QQ = [0.001     0     0     0     0     0     0;
      0     1     0     0     0     0     0;
      0     0     1     0     0     0     0;
      0     0     0     3.6     0     0     0;
      0     0     0     0     1     0     0;
      0     0     0     0     0     1     0;
      0     0     0     0     0     0     8.7];
RR = [1     0
      0     1];
K = lqrd(s4.A, s4.B, QQ, RR, Ts);

% % with observer
% A_obs = [(s4.A-s4.B*K)];
% B_obs = [s4.B];
% C_obs = [s4.C];
% D_obs = [s4.D];
% 
% poles = eig(A_obs)
% P_obs = [-20 -21 -22 -23 -24 -25 -26];
% L_obs = place(s4.A',s4.C',P)';
