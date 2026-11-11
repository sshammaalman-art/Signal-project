# ELE 3613 Signals and Systems - Audio Noise Reduction Project

MATLAB project that adds noise to an audio signal and removes it using:
- Method A: moving average (`movmean`) - Lab 2
- Method B: `lowpass`, `bandpass`, `bandstop` - Lab 5

and compares the results in time domain, frequency domain (FFT) and with SNR / MSE.

## Files
| File | What it is |
|------|------------|
| `AudioNoiseReduction.m` | main script (run this) |
| `AudioNoiseReduction.mlx` | same code as a live script |
| `ELE3613_Project_AudioNoiseReduction_original.mlx` | first version with the saved outputs |
| `Project_Report_AudioNoiseReduction.docx` | project report |
| `figures/` | figures produced by the script |

## How to run
Open MATLAB, go to this folder and type `AudioNoiseReduction` (or press Run).
The Signal Processing Toolbox is needed for `lowpass`, `bandpass`, `bandstop` and `freqz`.
Tested in MATLAB R2026a.

## Results
| Method | SNR (dB) | MSE | Improvement (dB) |
|--------|---------:|----:|-----------------:|
| Noisy input | 4.80 | 0.0860 | 0 |
| MA 3-point | 9.39 | 0.0299 | 4.59 |
| MA 7-point | 10.74 | 0.0219 | 5.94 |
| lowpass 1000 Hz | 13.14 | 0.0126 | 8.34 |
| bandpass 200-700 Hz | 16.72 | 0.0055 | 11.91 |
| bandstop 1450-1550 Hz | 8.26 | 0.0388 | 3.46 |

Bandpass gave the best result.
