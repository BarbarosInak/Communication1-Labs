%% Part_2.1
% a)

Fs=2000;
Ts=1/Fs;

t=0:Ts:0.2-Ts;

%% b)

Ac=1;
fc=200;

c=Ac*cos(2*pi*fc*t);

%% c)

Am=2;
fm=50;

m=Am*cos(2*pi*fm*t);

integral_m=(1/(2*pi*fm))*Am*sin(2*pi*fm*t);

%% d)
kf=[5,25,50];

cumsum_m=cumsum(m);

cumsum_m_2=[0,cumsum_m(1:end-1)];



s1=Ac*((c.*cos(2*pi*kf(1)*cumsum(m)*Ts))-(sin(2*pi*fc*t).*sin(2*pi*kf(1)*cumsum(m)*Ts)));

s2=Ac*((c.*cos(2*pi*kf(2)*cumsum(m)*Ts))-(sin(2*pi*fc*t).*sin(2*pi*kf(2)*cumsum(m)*Ts)));

s3=Ac*((c.*cos(2*pi*kf(3)*cumsum(m)*Ts))-(sin(2*pi*fc*t).*sin(2*pi*kf(3)*cumsum(m)*Ts)));

%% e)

figure;
subplot(4,1,1);
plot(t,m);
ylabel('m(t)');
xlabel('time(s)');
title('m(t) vs Time');

subplot(4,1,2);
plot(t,s1);
ylabel('s1(t)');
xlabel('time(s)');
title('s1(t) vs Time');

subplot(4,1,3);
plot(t,s2);
ylabel('s2(t)');
xlabel('time(s)');
title('s2(t) vs Time');

subplot(4,1,4);
plot(t,s3);
ylabel('s3(t)');
xlabel('time(s)');
title('s3(t) vs Time');

%% Part_2.2
% a)

N=length(t);

f_vector=linspace(-Fs/2,Fs/2,N);

%% b)

figure;
subplot(2,1,1);
plot(f_vector, fftshift(abs(fft(m,N)))/N);
ylabel('M(f)');
xlabel('Frequency(Hz)');
title('M(f) vs Frequency');

subplot(2,1,2);
plot(f_vector, fftshift(abs(fft(c,N)))/N);
ylabel('C(f)');
xlabel('Frequency(Hz)');
title('C(f) vs Frequency');


%% c)

figure;
subplot(3,1,1);
plot(f_vector, fftshift(abs(fft(s1,N)))/N);
ylabel('S1(f)');
xlabel('Frequency(Hz)');
title('S1(f) vs Frequency');

subplot(3,1,2);
plot(f_vector, fftshift(abs(fft(s2,N)))/N);
ylabel('S2(f)');
xlabel('Frequency(Hz)');
title('S2(f) vs Frequency');

subplot(3,1,3);
plot(f_vector, fftshift(abs(fft(s3,N)))/N);
ylabel('S3(f)');
xlabel('Frequency(Hz)');
title('S3(f) vs Frequency');

%% Part_2.3
% a)

freq_dev_1=Am*kf(1);
freq_dev_2=Am*kf(2);
freq_dev_3=Am*kf(3);

fmdemoded_s1=fmdemod(s1,fc,Fs,freq_dev_1);
fmdemoded_s2=fmdemod(s2,fc,Fs,freq_dev_2);
fmdemoded_s3=fmdemod(s3,fc,Fs,freq_dev_3);

%% b)

figure;
subplot(3,1,1);
plot(t,m);
hold on;
plot(t,Am*fmdemoded_s1);
ylabel('Amplitude');
xlabel('time(s)');
legend('m(t)','fmdemoded s1(t)');
title('m(t) and FM Demodulated s1(t)');

subplot(3,1,2);
plot(t,m);
hold on;
plot(t,Am*fmdemoded_s2);
ylabel('Amplitude');
xlabel('time(s)');
legend('m(t)','fmdemoded s2(t)');
title('m(t) and FM Demodulated s2(t)');

subplot(3,1,3);
plot(t,m);
hold on;
plot(t,Am*fmdemoded_s3);
ylabel('Amplitude');
xlabel('time(s)');
legend('m(t)','fmdemoded s3(t)');
title('m(t) and FM Demodulated s3(t)');
