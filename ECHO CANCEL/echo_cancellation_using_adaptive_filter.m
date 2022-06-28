clear all;
close all;
clc;
disp('Welcome to ECHO & NOISE CANCELLATION')
disp('What do you want to perform-:')
disp('1.ECHO CANCELLATION')
disp('2.NOISE CANCELLATION')
choose=input('Enter your choice- ')
if choose == 1

disp('Choose one of the following algorithm for ECHO CANCELLATION')
disp('1) LMS')
disp('2) NLMS')
disp('3) RLS')
a = input('Enter your choice- ')

%% Original audio/read the audio signal 
[X,Fs] = audioread('speech_dft.wav');                    %read sound
len_aud = length(X);
soundsc(X,Fs);                                           %Speaker
figure                                                   %Visualazation
subplot(2,1,1)
plot(X);
title('Real signal and its spectrogram') ;
xlabel('Sample');
ylabel('Amplitude');
subplot(2,1,2)
%spectrogram(X);
specgram(X);
pause(len_aud/Fs);                                       %programe intrupt/programe wait


%% Audio with ECHO
Xe = gen_echo(X);                                        %Call echo function to generate echo
soundsc(Xe,Fs);     
figure                                                   %Visualazation
subplot(2,1,1)
plot(Xe);
title('ECHO induced signal') ;
xlabel('Sample');
ylabel('Amplitude');
subplot(2,1,2)
%spectrogram(X);
specgram(Xe);                                     %Speaker
pause(length(Xe)/Fs);                                    %programe intrupt/programe wait

filename = 'Echo_signal1.wav';                            %file name
audiowrite(filename,Xe,Fs);                              %Save the audio in local file


%% Adaptive filter with lms algorithm
if a == 1
[filtered_signal , error_signal ] = lms(X,Xe,1024);

figure                                                          %Visualazation
subplot(2,1,1)
plot(filtered_signal);
title('LMS output and its spectrogram') ;
xlabel('Sample');
ylabel('Amplitude');
subplot(2,1,2)
specgram(filtered_signal);

soundsc(filtered_signal,Fs);                                  %Speaker
pause(length(filtered_signal)/Fs);

sq_e=error_signal.^2;
mean_sq_e=mean(sq_e);

filename = 'lmsoutput_code.wav';                              %file name
audiowrite(filename,filtered_signal,Fs);%Save the audio in local file

elseif a==2
%% Adaptive filter with nlms algorithm

[filtered_signal , error_signal ] = nlms(X,Xe,1024);

figure                                                         %Visualazation
subplot(2,1,1)
plot(filtered_signal);
title('NLMS output and its spectrogram') ;
xlabel('Sample');
ylabel('Amplitude');
subplot(2,1,2)
specgram(filtered_signal);

soundsc(filtered_signal,Fs);                                   %Speaker
pause(length(filtered_signal)/Fs);

sq_e=error_signal.^2;
mean_sq_e=mean(sq_e);

filename = 'nlmsoutput_code.wav';                                  %file name
audiowrite(filename,filtered_signal,Fs);                                    %Save the audio in local file
elseif a==3
    %% Adaptive filter with rls algorithm

[filtered_signal , error_signal ] = rls(X,Xe);

figure()                                                         %Visualazation
subplot(2,1,1)
plot(filtered_signal);
title('RLS output and its spectrogram') ;
xlabel('Sample');
ylabel('Amplitude');
subplot(2,1,2)
specgram(filtered_signal);

soundsc(filtered_signal,Fs);                                   %Speaker
pause(length(filtered_signal)/Fs);
sq_e=error_signal.^2;
mean_sq_e=mean(sq_e);


filename = 'rlsoutput_code.wav';                                  %file name
audiowrite(filename,filtered_signal,Fs);                                    %Save the audio in local file
end

%%%%%NOISE CANCELLATION
elseif choose==2
disp('Choose one of the following algorithm for NOISE CANCELLATION')
disp('1) LMS')
disp('2) NLMS')
disp('3) RLS')
a = input('Enter your choice- ')

%% Original audio/read the audio signal 
[X,Fs] = audioread('speech_dft.wav');                    %read sound
len_aud = length(X);
soundsc(X,Fs);                                           %Speaker
figure                                                   %Visualazation
subplot(2,1,1)
plot(X);
title('Real signal and its spectrogram') ;
xlabel('Sample');
ylabel('Amplitude');
subplot(2,1,2)
%spectrogram(X);
specgram(X);
pause(len_aud/Fs);                                       %programe intrupt/programe wait


%% Audio with NOISE
SNR=1;
 Xe=awgn(X,SNR,'measured');                            %Call noise function to generate noise
soundsc(Xe,Fs);        
figure                                                   %Visualazation
subplot(2,1,1)
plot(Xe);
title('NOISE induced signal ') ;
xlabel('Sample');
ylabel('Amplitude');
subplot(2,1,2)
%spectrogram(X);
specgram(Xe);                                     %Speaker
pause(length(Xe)/Fs);                                    %programe intrupt/programe wait

filename = 'noise_signal2.wav';                            %file name
audiowrite(filename,Xe,Fs);                              %Save the audio in local file


%% Adaptive filter with lms algorithm
if a == 1
[filtered_signal , error_signal ] = lms(X,Xe,1024);

figure                                                          %Visualazation
subplot(2,1,1)
plot(filtered_signal);
title('LMS output and its spectrogram') ;
xlabel('Sample');
ylabel('Amplitude');
subplot(2,1,2)
specgram(filtered_signal);

soundsc(filtered_signal,Fs);                                  %Speaker
pause(length(filtered_signal)/Fs);



filename = 'lmsoutput_code.wav';                              %file name
audiowrite(filename,filtered_signal,Fs);%Save the audio in local file

elseif a==2
%% Adaptive filter with nlms algorithm

[filtered_signal , error_signal ] = nlms(X,Xe,1024);

figure                                                         %Visualazation
subplot(2,1,1)
plot(filtered_signal);
title('NLMS output and its spectrogram') ;
xlabel('Sample');
ylabel('Amplitude');
subplot(2,1,2)
specgram(filtered_signal);

soundsc(filtered_signal,Fs);                                   %Speaker
pause(length(filtered_signal)/Fs);



filename = 'nlmsoutput_code.wav';                                  %file name
audiowrite(filename,filtered_signal,Fs);                                    %Save the audio in local file
elseif a==3
    %% Adaptive filter with rls algorithm

[filtered_signal , error_signal ] = rls(X,Xe);

figure()                                                         %Visualazation
subplot(2,1,1)
plot(filtered_signal);
title('RLS output and its spectrogram') ;
xlabel('Sample');
ylabel('Amplitude');
subplot(2,1,2)
specgram(filtered_signal);

soundsc(filtered_signal,Fs);                                   %Speaker
pause(length(filtered_signal)/Fs);



filename = 'rlsoutput_code.wav';                                  %file name
audiowrite(filename,filtered_signal,Fs);                                    %Save the audio in local file
end
end