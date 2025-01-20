%loading the dataset

load("case_1.mat")

%% 

        %%Task 1: Plotting original, before and after annotation signals together
figure
plot(eeg_time, eeg_ch)
hold on
plot(annot_time, before * 100, 'LineWidth', 2)
hold on
plot(annot_time, after * 100, 'LineWidth', 2)
hold off
xlabel('Time (sec)')
ylabel('Amplitude')
xlim([0, 500])
grid on 
legend('Original EEG', 'Before Annotation', 'After Annotation')

%% 

        %%Task2: Calculating sampling frequency

%taking time interval difference between samples
for i = 1:length(eeg_time)-1
    time_intervals(i) = eeg_time(i+1) - eeg_time(i);
end

mean_time_interval = mean(time_intervals)
fs = round(1/mean_time_interval)

%% 

        %%Task3: Designing and using the filter

%Designing highpass filter
highpass_filter = designfilt('highpassfir','FilterOrder', 45,'CutoffFrequency', 0.5, 'SampleRate',fs)

%plotting frequency and phase response
freqz(highpass_filter)

%%applyiing the filter to the signal
eeg_f = filter(highpass_filter,eeg_ch)
%% 

        %%Task 4: Plotting the filtered signal
figure;
subplot(1,2,1)
plot(eeg_time, eeg_ch)
xlabel('Time (sec)')
ylabel('Amplitude (µV)')
title('Original Signal')
ylim([-300, 300])
xlim([0, 500])

subplot(1,2,2)
plot(eeg_time, eeg_f)
xlabel('Time (sec)')
ylabel('Amplitude (µV)')
title('Filtered Signal')
xlim([0,500])
ylim([-300, 300])
            %% 
            
            %%Task 5 - Create a function
            %%Task 6: Run the function

[H,H_t] = entropy_eeg(eeg_f,fs)

           %% Task 7: Plot entropy with bis_ch

hold on
plot(H_t, H*100, 'color', 'r')
plot(bis_time, bis_ch, 'color', 'b')
plot(annot_time, before*100, 'color', 'm', 'LineWidth', 2)
plot(annot_time, after*100, 'Color', 'g', 'LineWidth', 2)
ylim([0, 110])
xlim([0, 500])
hold off

xlabel('Time (sec)')
ylabel('Values')

legend('Spectral Entropy', 'BIS values', 'Before', 'After')
