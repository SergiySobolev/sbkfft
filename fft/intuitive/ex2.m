A = 0.5; %amplitude of the cosine wave
fc=10;%frequency of the cosine wave
phase=30; %desired phase shift of the cosine in degrees
fs=32*fc;%sampling frequency with oversampling factor 32
t=0:1/fs:2-1/fs;%2 seconds duration
 
phi = phase*pi/180; %convert phase shift in degrees in radians
x=A*cos(2*pi*fc*t+phi);%time domain signal with phase shift
 
figure;subplot(5,1,1);plot(t,x);hold on; %plot the signal
title('x[n]=0.5*cos(2*pi*10*t)');

N=2^(nextpow2(length(t))-1);
X = 1/N*fftshift(fft(x,N));

df=fs/N; %frequency resolution
sampleIndex = -N/2:N/2-1; %ordered index for FFT plot
f=sampleIndex*df; %x-axis index converted to ordered frequencies
subplot(5,1,2);stem(f,abs(X));hold on; %magnitudes vs frequencies
xlabel('f (Hz)'); ylabel('|X(k)|');


phase=atan2(imag(X),real(X))*180/pi; %phase information
subplot(5,1,3);plot(f,phase); %phase vs frequencies
xlabel('f (Hz)'); ylabel('angle(X(k))');
title('Phase noised');



X2=X;%store the FFT results in another array
%detect noise (very small numbers (eps)) and ignore them
 
threshold = max(abs(X))/10000; %tolerance threshold
X2(abs(X)<threshold) = 0; %maskout values that are below the threshold
phase=atan2(imag(X2),real(X2))*180/pi; %phase information
subplot(5,1,4);plot(f,phase);
xlabel('f (Hz)'); ylabel('angle(X(k))');
title('Phase filtered from noise');

x_recon = N*ifft(ifftshift(X),N); %reconstructed signal
t = [0:1:length(x_recon)-1]/fs; %recompute time index 
subplot(5,1,5);plot(t,x_recon);
title('Reconstructed signal');