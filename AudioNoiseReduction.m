%% ELE 3613 Signals and Systems - Audio Noise Reduction
clc; clear; close all;

%% Step 1: clean signal
fs = 8000;
t  = 0:1/fs:0.5-1/fs;
x  = 0.6*sin(2*pi*300*t) + 0.4*sin(2*pi*600*t);

%% Step 2: add noise
rng(1)
noise = 0.2*randn(size(x)) + 0.3*sin(2*pi*1500*t);
xn = x + noise;

%% Step 3: lowpass filter
fc = 1000;
y  = lowpass(xn, fc, fs);

%% Step 4: time domain - clean, noisy and filtered signal
k = t <= 0.025;
figure
subplot(3,1,1)
plot(t(k), x(k), 'b', 'LineWidth', 1.5), grid on
ylim([-1.5 1.5]), ylabel('Amplitude')
title('Clean Signal')
subplot(3,1,2)
plot(t(k), xn(k), 'r', 'LineWidth', 1.5), grid on
ylim([-1.5 1.5]), ylabel('Amplitude')
title('Noisy Signal')
subplot(3,1,3)
plot(t(k), y(k), 'Color', [0.2 0.7 0.2], 'LineWidth', 1.5), grid on
ylim([-1.5 1.5]), ylabel('Amplitude'), xlabel('Time (s)')
title('Filtered Signal')

%% Step 5: frequency domain - before and after filtering
N  = length(xn);
f  = (0:N/2-1)*fs/N;
Xn = abs(fft(xn))/N;  Xn = 2*Xn(1:N/2);
Y  = abs(fft(y))/N;   Y  = 2*Y(1:N/2);

figure
subplot(2,1,1)
plot(f, Xn, 'Color', [0.2 0.4 0.8]), grid on
xlim([0 2500]), ylim([0 0.7])
xlabel('Frequency (Hz)'), ylabel('Amplitude')
title('Before filtering')
subplot(2,1,2)
plot(f, Y, 'Color', [0.85 0.33 0.10]), grid on
xlim([0 2500]), ylim([0 0.7])
xlabel('Frequency (Hz)'), ylabel('Amplitude')
title('After filtering')
xline(fc, 'k--', 'cutoff 1000 Hz')

%% Step 6: SNR before and after
SNR_before = 10*log10(sum(x.^2) / sum((xn - x).^2))
SNR_after  = 10*log10(sum(x.^2) / sum((y  - x).^2))

%% Step 7: listen to the signals
soundsc(xn, fs)
pause(1)
soundsc(y, fs)
