load('Parent_Fetus_ECGs.mat')

%% 

%plotting abdomen signal
figure(1); 
subplot(1, 2, 1)
plot(S_abdomen(1500:2500)); 
xlim([0,1000])
ylim([-100, 300])
ylabel('Amplitude [mV]')
xlabel('Time [sec]')
title('ECG signal from abdomen')

%%% plotting chest signal
subplot(1,2,2); 
plot(S_chest(1500:2500));
xlim([0,1000])
ylim([-100, 300])
ylabel('Amplitude [mV]')
xlabel('Time [sec]')
title('ECG signal from chest')

%% 

N = 50; % order, odd-number
delta = 0.000001; % small number
H = zeros(1,N); %start value

for i = 1:50;
    [e,H] = adaptive(S_chest, S_abdomen, delta, N, H);

    figure(2);
    subplot(1,2,1) 
    plot(e(1500:2499));  %a part of the fetus2s ECG
    ylim([-100, 300])
    ylabel('Amplitude [mV]')
    xlabel('Time [sec]')
    title('Fetus signal (Error signal)')

    subplot(1,2,2)
    plot(abs(fft(H,1024))); %filter3s freq resp
    ylabel('Magnitude')
    xlabel('Frequency (Hz)')
    title('Frequency response of Adaptive Filter')
end