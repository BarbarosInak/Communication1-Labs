%% Part_1
fs=500;
Ts=1/fs;

t1=0:Ts:1;
t2=1+Ts:Ts:2;
t3=2+Ts:Ts:3;
t4=3+Ts:Ts:4;

x_1=zeros(1,length(t1));
x_2=ones(1,length(t2));
x_3=-2*ones(1,length(t3));
x_4=zeros(1,length(t4));

x=[x_1 x_2 x_3 x_4];
t=[t1 t2 t3 t4];

figure;
plot(t,x);
xlabel('Time(seconds)');
ylabel('x(t)');
title('x(t) vs Time');

x2=cos(2*pi*50*t);

y1=x.*x2;

figure;
plot(t,y1);
xlabel('Time(seconds)');
ylabel('y1(t)');
title('y1(t) vs Time');

%% Part_2

N=length(x);

fft_x=fft(x,N);

fft_y1=fft(y1,N);

f_vector=-fs/2:fs/N:fs/2-fs/N;

step=fs/N;
f_vector2=-fs/2:step/2:fs/2-step;

figure;
subplot(2,1,1);
plot(f_vector,fftshift(abs(fft_x)));
xlabel('Frequency');
title('fft(x(t)) in Frequency Domain');

subplot(2,1,2);
plot(f_vector,fftshift(abs(fft_y1)));
xlabel('Frequency');
title('fft(y1(t)) in Frequency Domain');

fft_x2=fft(x2,2*N-1);
fft_xnew=fft(x,2*N-1);
fft_y2=fft_xnew.*fft_x2;

figure;
plot(f_vector2,fftshift(abs(fft_y2)));
xlabel('Frequency');
title('fft y2 in Frequency Domain');

y2=ifft(fft_y2,2*N-1);

t_new=0:Ts:8;

figure;
plot(t_new,y2);
xlabel('Time(seconds)');
ylabel('y2(t)');
title('Inverse Fourier Transform y2');

y2_second=conv(x,x2);

figure;
plot(t_new,y2_second);
xlabel('Time(seconds)');
ylabel('y2(t)');
title('y2 by Convolution');


figure;
plot(t_new,y2-y2_second);
axis([0 8 -4 4]);
xlabel('Time(seconds)');
ylabel('y2(t)-y2second(t)');
title('Differnece Between y2 and y2second');