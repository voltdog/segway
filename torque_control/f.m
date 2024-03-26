function x_ = f(x,u)
    fm = evalin('base', 'fm');
    x_ = [fm, fw, g, h, W, R, H]
%     alpha = n*Kt;
%     beta = fm;
% 
%     F_11 = 2*(beta+fw);
%     F_12 = -beta;
%     F_21 = -beta;
%     F_22 = beta;
% 
%     E_11 = (2*m+M)*R^2 + 2*Jw + 2*n^2*Jm;
%     E_12 = M*L*R - 2*n^2*Jm;
%     E_21 = E12;
%     E_22 = M*L^2 + Jpsi + 2*n^2*Jm;
%     detE = E_11*E_22 - E_12*E_21;
%     
% 
%     eq4 = -E_12*(-F_21*x(4) - F_22*x(5) + L^2*M*x(7)^2*sin(x(3))*cos(x(3)) + L*M*g*sin(x(3)) + alpha*(-u_1 - u(2)))/detE + E_22*(-F_11*x(4) - F_12*x(5) + L*M*R*x(5)^2*sin(x(3)) + alpha*(u(1) + u(2)))/detE;
%     eq5 = E_11*(-F_21*x(4) - F_22*x(5) + L^2*M*x(7)^2*sin(x(3))*cos(x(3)) + L*M*g*sin(x(3)) + alpha*(-u_1 - u(2)))/detE - E_21*(-F_11*x(4) - F_12*x(5) + L*M*R*x(5)^2*sin(x(3)) + alpha*(u_1 + u(2)))/detE;
%     eq6 = (-J*x(7) + K*(-u(1) + u(2)) - 2*L^2*M*x(5)*x(7)*sin(x(3))*cos(x(3)))/I;
% 
%     x_ = [x(1) + x(2)*Ts; 
%           x(2) + x(4)*Ts; 
%           x(3) + x(5)*Ts; 
%           x(4) + eq4*Ts; 
%           x(5) + eq5*Ts; 
%           x(6) + x(7)*Ts; 
%           x(7) + eq6*Ts];

end

