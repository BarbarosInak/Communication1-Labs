%% Part_1
% a)

Fs=2000;
Ts=1/Fs;

t=0:Ts:0.5;

m=sawtooth(2*pi*10*t+90*pi/180,0.5);

%% b)

fc=100;
kf=80;

s_FM=cos(2*pi*fc*t+2*pi*kf*cumsum(m)*Ts);

%% c)

kp=2*pi;

s_PM=cos(2*pi*fc*t+kp*m);

%% d)

figure;
subplot(3,1,1);
plot(t,m);
ylabel('m(t)');
xlabel('Time(s)');
title('m(t) vs Time');

subplot(3,1,2);
plot(t,s_FM);
ylabel('S_F_M(t)');
xlabel('Time(s)');
title('S_F_M(t) vs Time');

subplot(3,1,3);
plot(t,s_PM);
ylabel('S_P_M(t)');
xlabel('Time(s)');
title('S_P_M(t) vs Time');

%% f)

kp2=3*pi;
kp3=4*pi;


s_PM2=cos(2*pi*fc*t+kp2*m);

s_PM3=cos(2*pi*fc*t+kp3*m);

figure;
subplot(3,1,1);
plot(t,s_PM);
ylabel('S_P_M(t)');
xlabel('Time(s)');
title('S_P_M(t) vs Time');

subplot(3,1,2);
plot(t,s_PM2);
ylabel('S_P_M_2(t)');
xlabel('Time(s)');
title('S_P_M_2(t) vs Time');

subplot(3,1,3);
plot(t,s_PM3);
ylabel('S_P_M_3(t)');
xlabel('Time(s)');
title('S_P_M_3(t) vs Time');

%% Part_2
% b)

x_PM=hilbert(s_PM);

%% c)

N=length(t);

f_vector=linspace(-Fs/2,Fs/2,N);


figure;
subplot(3,1,1);
plot(f_vector,fftshift(abs(fft(m,N)))/N);
ylabel('M(f)');
xlabel('Frequency(Hz)');
title('M(f) vs Frequency');

subplot(3,1,2);
plot(f_vector,fftshift(abs(fft(s_PM,N)))/N);
ylabel('S_P_M(f)');
xlabel('Frequency(Hz)');
title('S_P_M(f) vs Frequency');

subplot(3,1,3);
plot(f_vector,fftshift(abs(fft(x_PM,N)))/N);
ylabel('X_P_M(f)');
xlabel('Frequency(Hz)');
title('X_P_M(f) vs Frequency');

%% d)

teta=phase(x_PM);

m_head=(unwrap(teta)-2*pi*fc*t)/(2*pi);

%% e)

x_PM3=hilbert(s_PM3);

teta3=phase(x_PM3);

m_head3=(unwrap(teta3)-2*pi*fc*t)/(4*pi);

%% f)

figure;
plot(t,m);
hold on;
plot(t,m_head,'r');
hold on;
plot(t,m_head3,'blue');
ylabel('Amplitude');
xlabel('Time(s)');
title('m(t),m_h_e_a_d(t), and m_h_e_a_d3(t) vs Time');
legend('m(t)','m_h_e_a_d(t)','m_h_e_a_d3(t)');
