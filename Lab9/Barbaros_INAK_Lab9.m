%% 9.1 Construction
%a)

x=load('gong');

%% b)

mt=x.y;
mt=mt';

fs=x.Fs;

%% c)

t=0:1/fs:(numel(mt)-1)/fs;

%% d)

fc=2000;

c=cos(2*pi*fc*t);

%% 9.2 Modulation
%a)
   
Ts=1/fs;
kf=10000;% I think that there could be an error while writing kf value. kf
%1000 is better to analysing and work with. Because of that I used kf as
%1000.
%kf=1000;

s=cos(2*pi*fc*t+2*pi*kf*cumsum(mt)*Ts);

Hpre_em=500*ones(1,length(s));

s_new=ifft(fft(s).*Hpre_em);
%s_clone=ifft(fft(s));

%% b)

SNR=[0 5 10 20];

s_0=awgn(s,SNR(1),'measured');
s_5=awgn(s,SNR(2),'measured');
s_10=awgn(s,SNR(3),'measured');
s_10_new=awgn(s_new,SNR(3),'measured');
s_20=awgn(s,SNR(4),'measured');

%% 9.3 Demodulation and Filtering
%a)
Hemp=(1/500)*ones(1,length(s_20));
%s_20=ifft(fft(s_20).*Hemp);
s_10_new=ifft(fft(s_10).*Hemp);

s_0_demod=fmdemod(s_0,fc,fs,kf);
s_5_demod=fmdemod(s_5,fc,fs,kf);
s_10_demod=fmdemod(s_10,fc,fs,kf);
s_10_new_demod=fmdemod(s_10_new,fc,fs,kf);
s_20_demod=fmdemod(s_20,fc,fs,kf);

%s_0_demod=s_0_demod/50;
%s_5_demod=s_5_demod/50;
%s_10_demod=s_10_demod/50;
%s_20_demod=s_20_demod/50;

[B,A]=butter(9,fc/(2*fs/2));

s_0_filtered=filter(B,A,s_0_demod);
s_5_filtered=filter(B,A,s_5_demod);
s_10_filtered=filter(B,A,s_10_demod);
s_10_new_filtered=filter(B,A,s_10_new_demod);
s_20_filtered=filter(B,A,s_20_demod);

%% b and c)

%sound(s_0_filtered);
%ause(6);
%sound(s_5_filtered);
%pause(6);
sound(s_10_filtered);
pause(6);
sound(s_10_new_filtered);
%sound(s_20_filtered);


%% 9.4 MSE and Comparison
%a)

MSE=zeros(1,length(SNR));

MSE(1)=MSE_Barbaros_INAK(mt,s_0_filtered);
MSE(2)=MSE_Barbaros_INAK(mt,s_5_filtered);
MSE(3)=MSE_Barbaros_INAK(mt,s_10_filtered);
MSE(4)=MSE_Barbaros_INAK(mt,s_20_filtered);

%% b)

figure;
plot(SNR,MSE);
xlabel('SNR(dB)');
ylabel('MSE');
title('MSE values for Different SNR Values');


%%
f_vector=linspace(-fs/2,fs/2,length(mt));
plot(f_vector,fftshift(abs(fft(s_20_demod))));