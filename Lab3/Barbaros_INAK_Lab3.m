%% Part_1
%a)

Fs=10000;
Ts=1/Fs;
t_last=0.1;

t=0:Ts:t_last-Ts;

%% b)
Ac=1;
Am=1;
fc=1000;
fm=100;

c=Ac*cos(2*pi*fc*t);
m=Am*cos(2*pi*fm*t);

%% c)

len=length(t);

s1=c.*(0.5*m)+c;

s2=c.*(1*m)+c;

s3=c.*(2*m)+c;

%% d)
figure;

subplot(3,1,1);
plot(t,s1);
xlabel('Time(s)');
ylabel('s1(t)');
title('s1(t) vs Time');

subplot(3,1,2);
plot(t,s2);
xlabel('Time(s)');
ylabel('s2(t)');
title('s2(t) vs Time');

subplot(3,1,3);
plot(t,s3);
xlabel('Time(s)');
ylabel('s3(t)');
title('s3(t) vs Time');

%% e)
clc;

fprintf('Part_1 e)\n\n');

fprintf("In the first graph we observ a fifty percent modulated signal according to the given modulation factor.\nModulation factor could be determined by taking the differnece at the upperside's max and min values and \nthen by dividing 1 to the differnece ka could be determined."); 

fprintf('\n\nAt the second graph we see one hundered percent modulated signal. This type of modulations  modulation \nfactor is always 1.');

fprintf('\n\nAt the last graph a one hundered and fifty percent modulated signal have shown.\nDue to the overmodulation we observe distortion at the message signal as a result of the modulation style.\n');

%% f)
f_vector=linspace(-Fs/2,Fs/2,len);
figure;
subplot(3,1,1);
plot(f_vector,fftshift(abs(fft(m)))/len);
xlabel('Frequency(f)');
ylabel('M(f)');
title('M(f) vs Frequency');

subplot(3,1,2);
plot(f_vector,fftshift(abs(fft(c)))/len);
xlabel('Frequency(f)');
ylabel('C(f)');
title('C(f) vs Frequency');

subplot(3,1,3);
plot(f_vector,fftshift(abs(fft(s1)))/len);
xlabel('Frequency(f)');
ylabel('S1(f)');
title('S1(f) vs Frequency');

%% Part_2
%a)

s_09=c.*(ones(1,len)+0.9*m);

s_2=c.*(ones(1,len)+2*m);

s_09_2=s_09.*s_09;

s_2_2=s_2.*s_2;

[B,A]=butter(10,0.25);

f_signal_1=filter(B,A,s_09_2);

f_signal_2=filter(B,A,s_2_2);

signal_1=sqrt(f_signal_1);

signal_2=sqrt(f_signal_2);

%% b)
fprintf('\n\nPart_2 b)\n\n');
fprintf('For getting best result I tried some other order values but lower than 10 values have some noise on the signal \nand for values that are higher than 10 nearly gives the same signal. Because of that I have chosen order as 10.\n');

%% c)

figure;
subplot(2,1,1);
plot(t,signal_1);
xlabel('Time(s)');
ylabel('Amplitude');
title('Signal 1 vs Frequency');

subplot(2,1,2);
plot(t,signal_2);
xlabel('Time(s)');
ylabel('Amplitude');
title('Signal 2 vs Frequency');

%% d)

fprintf('\n\nPart_2 d)\n\n');

fprintf('Since we did not filtered out carrier parts from the signal, we observe a DC signal,\nthat created because of the product with the demodulator systems oscillator output, at the demodulated signal.\nAs we expected we can demodulated signal with 0.9 modulating factor and due to the over modulation we could not\nmanage to demodulate signal with 2 modulation factor.\n');

