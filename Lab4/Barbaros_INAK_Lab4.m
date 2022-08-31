%% Part-1
% a)

fs=100000;
fm=100;
fc=1000;

Ts=1/fs;

t=0:Ts:0.08;

m=cos(2*pi*fm*t);

c=cos(2*pi*fc*t);

%% b)

s=m.*c;

%% c)

figure;
subplot(3,1,1);
plot(t,m);
xlabel('Time(s)');
ylabel('m(t)');
title('m(t) vs Time');

subplot(3,1,2);
plot(t,c);
xlabel('Time(s)');
ylabel('c(t)');
title('c(t) vs Time');

subplot(3,1,3);
plot(t,s);
xlabel('Time(s)');
ylabel('s(t)');
title('s(t) vs Time');

%% d)
N=length(t);
f_vector=linspace(-fs/2,fs/2,N);

figure;
subplot(2,1,1);
plot(f_vector,fftshift(abs(fft(m)))/N);
xlabel('Frequency(Hz)');
ylabel('M(f)');
title('M(f) vs Frequency');

subplot(2,1,2);
plot(f_vector,fftshift(abs(fft(s)))/N);
xlabel('Frequency(Hz)');
ylabel('S(f)');
title('S(f) vs Frequency');
clc;
fprintf('Part-1 d:\n\n');
fprintf('Multiplication operation in time domain corresponds to convolution operation in frequency domain.\nBecause of that we get two delta functions around carrier frequencies around.\nAlso, we are dealing with cos functions, which means that in frquency domain we get half of the amplitude in time\ndomain. After that we are multiplying two halved signal eachother. As a result of that at S(f) we get amplitude\nvalues at 0.25 as expected.');

%% Part_2
% a)

c_lo=2*cos(2*pi*fc*t);

v=s.*c_lo;

%% b)

figure;
plot(f_vector,fftshift(abs(fft(v)))/N);
xlabel('Frequency(Hz)');
ylabel('V(f)');
title('V(f) vs Frequency');

fprintf('\n\nPart-2 b:\n\n');
fprintf('For reproducing the message signal amplitude of c_lo choosen as 2.After that, as a result of the convolution\noperation in frequency domain we ended up with having message signal and 4 delta functions 2 of them centered at\n+2 kHz and rest of them centered at -2 kHz with 0.25 V amplitude. m(t) part has twice of the amplitude of s(t)\ndue to the voncolution operation and amplitude of the c_ol.');

%% c)

[B,A]=butter(8,0.009,'low');
v0=filter(B,A,v);

fprintf('\n\nPart-2 c:\n\n');
fprintf('I have chosen corner frequency around the middle of the 2fc and fm. Between these values there are not any value,\nThen 0.009 is safe to choose. Order of the filter as choosen itteretionally.\nI get the best results at the 8th order.');

%% d)

figure;
subplot(2,1,1);
plot(f_vector,fftshift(abs(fft(v0)))/N);
xlabel('Frequency(Hz)');
ylabel('V0(f)');
title('V0(f) vs Frequency');

subplot(2,1,2);
plot(t,v0);
xlabel('Time(s)');
ylabel('v0(t)');
title('v0(t) vs Time');

figure;
plot(f_vector,fftshift(abs(fft(m)))/N,'r',f_vector,fftshift(abs(fft(v0)))/N);
xlabel('Frequency(f)');
ylabel('Amplitude');
legend('M(f)','V0(f)');
title('M(f) and V0(f)');

fprintf('\n\nPart-2 d:\n\n');
fprintf('As seen from M(f) and V0(f) graph, delta functions are at same frequency values, which are +- 100 Hz. A little\ndiffernece at the bottom of the signal,at the other parts they are nearly identical to each other.\n');
