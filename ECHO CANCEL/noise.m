clear;
clc;
close all;
blms = dsp.BlockLMSFilter(10,5);
blms.StepSize = 0.01;
blms.BlockSize = 11;
blms.WeightsOutputPort = false;
filt = dsp.FIRFilter;
filt.Numerator = fir1(10,[.5, .75]);
[my_signal,Fs] = audioread('speech_dft.wav');
x = randn(110033,1); % Noise
soundsc(my_signal,Fs);
pause(length(my_signal)/Fs);
figure;
plot(my_signal); title('My train signal');
my_signal = reshape(my_signal , [1,110033]);
d = filt(x) + my_signal'; % Noise + Signal
soundsc(d,Fs);
pause(length(d)/Fs);
[y, err] = blms(x, d); 
figure
subplot(2,1,1);
plot(d);
title('Noise + Signal');
filename = 'noise_signal2.wav';                            %file name
audiowrite(filename,d,Fs);   
subplot(2,1,2);
plot(err);
title('Signal');
figure;
plot(err);
soundsc(err,Fs);
title('Signal');
axis ([0 25000 -0.4 0.5]);