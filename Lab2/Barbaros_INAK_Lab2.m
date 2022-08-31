%% Construction of the Signals
%a)

fs=1000;
Ts=1/fs;

t=0:Ts:2-Ts;

x_1=cos(2*pi*60*t);
x_2=cos(2*pi*250*t);

x2=x_1+x_2;

N=length(t);

fft_x2=fft(x2,N);

%% b)

x_3=zeros(1,(((N)/2)-101));
f1=-50:1000/N:0;
f2=0:1000/N:50;

first_part=(1/50)*(f1+50);
second_part=(-1/50)*(f2-50);

fft_x=[x_3 first_part second_part x_3];

%% c)

Y1=(fftshift(abs(fft_x2))/N) +abs(fft_x);

%% d)
f_vector=linspace(-500,500,N);

figure;
subplot(3,1,1);
plot(f_vector,fft_x);
xlabel('Frequency');
ylabel('|X(f)|');
title('|X(f)| vs Frequency');

subplot(3,1,2);
plot(f_vector,fftshift(abs(fft_x2))/N);
xlabel('Frequency');
ylabel('|X2(f)|');
title('|X2(f)| vs Frequency');

subplot(3,1,3);
plot(f_vector,Y1);
xlabel('Frequency');
ylabel('|Y1(f)|');
title('|Y1(f)| vs Frequency');

%% Filtering
%a)

x_4=ones(1,200);

ideal_low_pass_filter=[0 x_3 x_4 x_3 0];

Y2=Y1.*ideal_low_pass_filter;

%% b)

figure;
subplot(2,1,1);
plot(f_vector,ideal_low_pass_filter);
xlabel('Frequency');
ylabel('Amplitude');
title('Ideal Low Pass Filter');

subplot(2,1,2);
plot(f_vector,Y2);
xlabel('Frequency');
ylabel('|Y2(f)|');
title('|Y2(f)| vs Frequency');

%% c)

ideal_bandpass_filter=zeros(1,N);

ideal_bandpass_filter(450:550)=1;
ideal_bandpass_filter(1450:1550)=1;

Y3=Y1.*ideal_bandpass_filter;

%% d)

figure;
subplot(2,1,1);
plot(f_vector,ideal_bandpass_filter);
xlabel('Frequency');
ylabel('Amplitude');
title('Ideal Bandpass Filter');

subplot(2,1,2);
plot(f_vector,Y3);
xlabel('Frequency');
ylabel('|Y3(f)|');
title('|Y3(f)| vs Frequency');

%% e)

[B,A]=butter(5,[0.4 0.6],'bandpass');

butter_bandpass=filter(B,A,x2);

Ybpf=fftshift(abs(fft(butter_bandpass,N)))/N;

%% f)

figure;
subplot(2,1,1);
freqz(B,A,f_vector,fs);
title('Butter Bandpass Filter');

subplot(2,1,2);
plot(f_vector,Ybpf);
xlabel('Frequency');
ylabel('|Ybpf(f)|');
title('|Ybpf(f)| vs Frequency');
