function s=kalmanf(s)


x_ = s.F*s.x + s.TU*s.u + s.G*s.we;
s.v = s.z - s.H*x_ - s.D*s.ve;
P_ = s.F*s.P*s.F' + s.G*s.Q*s.G';
s.K = P_*s.H'*inv(s.H*P_*s.H'+s.D*s.R*s.D');
s.x = x_+s.K*s.v;
s.P = P_ - s.K*s.H*P_;

end
