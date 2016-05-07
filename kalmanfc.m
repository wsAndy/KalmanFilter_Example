% 为什么这边的量测只有对位置的量测，没有对速度的量测？
% 这个该如何添加？ 
% 对匀速直线运动的目标的位置以及速度的估计

function kalmanfc(pos,vel,var,Q,R,count)

T=0.25;
F=[1 T; 0 1];
G=[T^2/2;T];
TU=[0 0; 0 0];
u=[0;0];
H=[1 0];
% Q=1; %
% R=1; %
%初始状态以及协方差
x=[pos; vel];      %
% P=[20 0; 0 10];  %
P = var;

tru = [0;0];
z=[0];
iteration=count;   % 

for t=1:iteration    
    tru(:,end+1)=F*tru(:,end)+G*randn;%真实状态,受过程噪声影响. 
    z(end+1)=H*tru(:,end)+randn; %构造量测值
 
    %预测
    xbar=F*x(:,end)+TU*u;%状态预测值
    zbar=H*xbar;        %量测预测值
    Pbar=F*P(:,end-1:end)*F'+G*Q*G';%预测状态协方差
    
    v=z(end)-zbar;%新息
    S=R+H*Pbar*H';%新息协方差
    K=Pbar*H'*inv(S);%权重
    x(:,end+1)=xbar+K*v;%状态更新
    P(:,end+1:end+2)=Pbar-K*S*K';%协方差更新
    
end

figure;
hold on;
grid on;
ht = plot(tru(1,:),'b--');
hx = plot(x(1,:),'r-');
hz = plot(z(1,:),'g.');
hp = plot(P(1,1:2:end));
legend([ht hx hz hp],'true position','estimate position','measure position','position error variance');
xlabel('Time');
ylabel('Position');
title('Position Estimation');
hold off;

figure;
hold on;
grid on;
ht = plot(tru(2,:),'b--');
hx = plot(x(2,:),'r-');
hp = plot(P(2,2:2:end));
xlabel('Times');
ylabel('Velocity');
legend([ht hx hp],'true velocity','estimate velocity','velocity error variance');
title('Velocity Estimation');
hold off;

end