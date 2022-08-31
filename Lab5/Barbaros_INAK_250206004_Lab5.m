%% Part_1 
% a)

fm=450;
fc=5000;
Fs=20000;

Ts=1/Fs;

t=0:Ts:0.03;

m=3*cos(2*pi*fm*t);

c=cos(2*pi*fc*t);

%% b)

s=m.*c;

%% c)
N=length(t);

f_vector=linspace(-Fs/2,Fs/2,2*N-1);

[B1,A1]=butter(4,2*fc/Fs,'high');

[B2,A2]=butter(22,2*fc/Fs,'high');


%% d)

figure;

filter_1=freqz(B1,A1,f_vector,Fs);
plot(f_vector,abs(filter_1));
ylabel('Amplitude');
xlabel('Frequency(Hz)');
hold on;
filter_2=freqz(B2,A2,f_vector,Fs);
plot(f_vector,abs(filter_2));
title('Magnitude Response of The Filters');
legend('filter1','filter2');


%% e)

s_usb1=filter(B1,A1,s);

s_usb2=filter(B2,A2,s);

%% f)

figure;
subplot(3,1,1);
plot(f_vector,fftshift(abs(fft(s,2*N-1)))/(N));
ylabel('S(f)');
xlabel('Frequency(Hz)');
title('S(f) vs Frequency');

subplot(3,1,2);
plot(f_vector, fftshift(abs(fft(s_usb1,2*N-1)))/N);
ylabel('S-USB1(f)');
xlabel('Frequency(Hz)');
title('S-USB1(f) vs Frequency');

subplot(3,1,3);
plot(f_vector, fftshift(abs(fft(s_usb2,2*N-1)))/N);
ylabel('S-USB2(f)');
xlabel('Frequency(Hz)');
title('S-USB2(f) vs Frequency');

%% Part_2 
% a)

clc;
fprintf('Part_2 a)\n\n');
fprintf('As we have seen from the figures, which plotted at the part_1 f,s-usb2(t) more similar to the ideal case\nthan s-usb1(t). This happened because of the used filters` different orders. s-usb2 has greater order,\nthis makes the slope of the transition part of the filter is higher. Because of that,\ns-usb2 filters out most of the lower sideband of s(t). Due to the given reason, I chose to work with s-usb2.\n');

c_lo=4*cos(2*pi*fc*t);

v=s_usb2.*c_lo;

%% b)

[B3,A3]=butter(10,2*(3*fm)/Fs);

figure;
freqz(B3,A3);
title('Frequency Response of LPF');

fprintf('\nPart_2 b)\n\n');
fprintf('For getting the intended part of the signal, a little away from fm is the best choice for cutoff frequency of\nthe filter. Since we are not using ideal filter for getting the closest signal we need to choose cutoff frequency\na bit distant from fm. Order of the filter haven chosen iteratively. Best results have obtained\nwhile order is equal to 12.\n');

%% c) 

m_d=filter(B3,A3,v);

%% d)

figure;
subplot(3,1,1);
plot(f_vector,fftshift(abs(fft(m,2*N-1)))/N);
ylabel('M(f)');
xlabel('Frequency(Hz)');
title('M(f) vs Frequency');

subplot(3,1,2);
plot(f_vector,fftshift(abs(fft(v,2*N-1)))/N);
ylabel('V(f)');
xlabel('Frequency(Hz)');
title('V(f) vs Frequency');


subplot(3,1,3);
plot(f_vector,fftshift(abs(fft(m_d,2*N-1)))/N);
ylabel('M_d(f)');
xlabel('Frequency(Hz)');
title('M_d(f) vs Frequency');


fprintf('\nPart_2 d)\n\n');
fprintf('For getting the best results that we can, fft`s number of output elements are chosen as 2*N-1.\nA dercrease have been observed at the signals amplitude. This happend because of the non-ideal filters.\nThere is no big difference in the frequencies of the signals.\n');

%% e)

figure;
plot(t,m);
ylabel('Amplitude');
xlabel('Time(s)');
hold on;
plot(t,m_d);
legend('m(t)','m_d(t)');
title('m(t) and m_d(t) vs Time');

fprintf('\nPart_2 e)\n\n');
fprintf('As already told in the part_2 f amplitude of the demodulated signal is a bit less than original\nsignal. In additionally, we see a phase differnece between the orinal signal and demodulated signal.\n');


