% Ϊʲô��ߵ�����ֻ�ж�λ�õ����⣬û�ж��ٶȵ����⣿
% ����������ӣ� 
% ������ֱ���˶���Ŀ���λ���Լ��ٶȵĹ���

function kalmanfc(pos,vel,var,Q,R,count)

T=0.25;
F=[1 T; 0 1];
G=[T^2/2;T];
TU=[0 0; 0 0];
u=[0;0];
H=[1 0];
% Q=1; %
% R=1; %
%��ʼ״̬�Լ�Э����
x=[pos; vel];      %
% P=[20 0; 0 10];  %
P = var;

tru = [0;0];
z=[0];
iteration=count;   % 

for t=1:iteration    
    tru(:,end+1)=F*tru(:,end)+G*randn;%��ʵ״̬,�ܹ�������Ӱ��. 
    z(end+1)=H*tru(:,end)+randn; %��������ֵ
 
    %Ԥ��
    xbar=F*x(:,end)+TU*u;%״̬Ԥ��ֵ
    zbar=H*xbar;        %����Ԥ��ֵ
    Pbar=F*P(:,end-1:end)*F'+G*Q*G';%Ԥ��״̬Э����
    
    v=z(end)-zbar;%��Ϣ
    S=R+H*Pbar*H';%��ϢЭ����
    K=Pbar*H'*inv(S);%Ȩ��
    x(:,end+1)=xbar+K*v;%״̬����
    P(:,end+1:end+2)=Pbar-K*S*K';%Э�������
    
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