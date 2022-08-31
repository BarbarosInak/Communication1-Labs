%% 9.1 Construction
% a

M=imread('cameraman.tif');
M=im2double(M);

%% b

[m,n]=size(M);

Fs=m*n;

%% c

y=reshape(M,1,[]);

t=0:1/Fs:(numel(y)-1)/Fs;

%% d

fc=20000;

c=cos(2*pi*fc*t);

%% 9.2 Modulation
% a

X=y.*c;

%% b

X_0=awgn(X,0);

X_5=awgn(X,5);

X_10=awgn(X,10);

X_20=awgn(X,20);

X_30=awgn(X,30);

%% 9.3 Demodulation and Filtering
% a

f_vector=linspace(-Fs/2,Fs/2,length(X));
N=length(f_vector);

c_demod=2*cos(2*pi*fc*t);

X_0_demod=X_0.*c_demod;

X_5_demod=X_5.*c_demod;

X_10_demod=X_10.*c_demod;

X_20_demod=X_20.*c_demod;

X_30_demod=X_30.*c_demod;

[B,A]=butter(2,0.375);

X_0_filtered=filter(B,A,X_0_demod);

X_5_filtered=filter(B,A,X_5_demod);

X_10_filtered=filter(B,A,X_10_demod);

X_20_filtered=filter(B,A,X_20_demod);

X_30_filtered=filter(B,A,X_30_demod);

%% b

X_0_filtered=reshape(X_0_filtered,m,n);

X_5_filtered=reshape(X_5_filtered,m,n);

X_10_filtered=reshape(X_10_filtered,m,n);

X_20_filtered=reshape(X_20_filtered,m,n);

X_30_filtered=reshape(X_30_filtered,m,n);

%% 9.4 Plots

figure;
subplot(2,3,1);
imshow(M);
title('Original Message');

subplot(2,3,2);
imshow(X_0_filtered);
title('Message signal with 0 dB SNR');

subplot(2,3,3);
imshow(X_5_filtered);
title('Message signal with 5 dB SNR');

subplot(2,3,4);
imshow(X_10_filtered);
title('Message signal with 10 dB SNR');

subplot(2,3,5);
imshow(X_20_filtered);
title('Message signal with 20 dB SNR');

subplot(2,3,6);
imshow(X_30_filtered);
title('Message signal with 30 dB SNR');

%% 9.5 Mean Square Error (MSE) and Comparison
%a

SNR=[0,5,10,20,30];

MSE_values=zeros(length(SNR),1);

MSE_values(1)=MSE_Barbaros_INAK(M,X_0_filtered);

MSE_values(2)=MSE_Barbaros_INAK(M,X_5_filtered);

MSE_values(3)=MSE_Barbaros_INAK(M,X_10_filtered);

MSE_values(4)=MSE_Barbaros_INAK(M,X_20_filtered);

MSE_values(5)=MSE_Barbaros_INAK(M,X_30_filtered);

%% b

figure;
plot(SNR,MSE_values);
xlabel('SNR(dB)');
ylabel('MSE');
title('MSE results for different SNR values');
