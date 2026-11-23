%% ELE 3613 Signals and Systems - Project
% Noise reduction with a lowpass filter
%
% We make a clean signal, add noise to it, and use a lowpass
% filter (Lab 5) to reduce the noise. Then we compare the signal
% before and after, in time and in frequency (FFT, Labs 7 and 8).

clc; clear; close all;

%% Step 1: clean signal
fs = 8000;                     % sampling frequency (Hz)
t  = 0:1/fs:0.5-1/fs;          % 0.5 seconds -> 4000 samples
x  = 0.6*sin(2*pi*300*t) + 0.4*sin(2*pi*600*t);   % two tones: 300 Hz and 600 Hz

%% Step 2: add noise
rng(1)                                               % same noise every time we run
noise = 0.2*randn(size(x)) + 0.3*sin(2*pi*1500*t);   % random noise + 1500 Hz whistle
xn = x + noise;                                      % noisy signal

%% Step 3: lowpass filter
fc = 1000;                     % cutoff frequency (Hz)
y  = lowpass(xn, fc, fs);      % keeps below 1000 Hz, removes the rest

%% Step 4: time domain - noisy, clean and filtered in one plot
k = t <= 0.02;                 % first 20 ms so we can see the waves
figure
plot(t(k)*1000, xn(k), 'Color', [0.7 0.7 0.7]), hold on
plot(t(k)*1000, x(k), 'k--', 'LineWidth', 1.5)
plot(t(k)*1000, y(k), 'Color', [0.85 0.33 0.10], 'LineWidth', 1.5)
hold off, grid on
xlabel('Time (ms)'), ylabel('Amplitude')
legend('Noisy signal', 'Clean signal', 'Filtered signal', 'Location', 'southoutside', 'Orientation', 'horizontal')
title('Time domain: noisy, clean and filtered signal')

%% Step 5: frequency domain - before and after (FFT)
N  = length(xn);
f  = (0:N/2-1)*fs/N;                      % frequency axis (Hz)
Xn = abs(fft(xn))/N;  Xn = 2*Xn(1:N/2);   % spectrum before filtering
Y  = abs(fft(y))/N;   Y  = 2*Y(1:N/2);    % spectrum after filtering

figure
subplot(1,2,1)
plot(f, Xn, 'Color', [0.2 0.4 0.8]), grid on
xlim([0 2500]), ylim([0 0.7])
xlabel('Frequency (Hz)'), ylabel('Amplitude')
title('Before filtering')
subplot(1,2,2)
plot(f, Y, 'Color', [0.85 0.33 0.10]), grid on
xlim([0 2500]), ylim([0 0.7])
xlabel('Frequency (Hz)'), ylabel('Amplitude')
title('After filtering')
xline(fc, 'k--', 'cutoff 1000 Hz')

%% Step 6: how much did the filter help? (SNR)
SNR_before = 10*log10(sum(x.^2) / sum((xn - x).^2))   % in dB
SNR_after  = 10*log10(sum(x.^2) / sum((y  - x).^2))   % in dB
