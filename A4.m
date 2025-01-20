load('data_ca4.mat');
fs = 128;

%% Task 1: Plotting RR intervals in hours

isi = 1/fs;                                      %inter sample interval
rr_intervals = diff(heart_beats) * isi;          %converting rr intervals in samples to time 
t = ((heart_beats - heart_beats(1))) / fs;       %time vector for plotting
t = t(1:end-1);

t_hours = t / 3600;

figure(1);
plot(t_hours, rr_intervals);
xlabel('Time [hour]');
ylabel('RR interval [s]');
title('Tachogram');
xlim([0, 23])
xticks(0:2:23)

%%  Task 2: Calculating time domain measures
% 1 - SDNN

sdnn = std(rr_intervals);

% 2 - SDANN

% Define the length of a 5-minute segment in samples
segment_length = 5; % 5 minutes in seconds

% Calculate the number of 5-minute segments in the entire signal
num_segments = floor(length(rr_intervals) / segment_length);

% Initialize an array to store the mean of NN intervals for each segment
mean_NN_intervals = zeros(1, num_segments);

% Loop through each 5-minute segment

for i = 1:num_segments
    % Calculate the start and end indices of the current segment
    start_index = (i - 1) * segment_length_samples + 1;
    end_index = i * segment_length_samples;
    
    % Extract the samples for the current 5-minute segment
    fivemin_segment = rr_intervals(start_index:end_index);
    
   % Calculate the mean of the NN intervals for the current segment
    mean_NN_intervals(i) = mean(fivemin_segment);
end

% Calculate the standard deviation of the means of NN intervals across all segments
SDANN = std(mean_NN_intervals);

% 3 - rMSSD
SD = diff(rr_intervals);
rMSSD = rms(SD); 

% 4 - pNN50
NN50 = sum(abs(SD) > 0.050);
pNN50 = NN50/length(SD)*100;

%% Plotting non-linear measures

% Histogram of rr intervals
figure(2);
histogram(rr_intervals*1000);
xlabel('Time [ms]')
ylabel('Count')
title('Histogram of RR intervals')
xlim([400,1500])


% Poincaré plot
figure(3);
scatter(rr_intervals(1:end-1), rr_intervals(2:end));
xlabel('nth RR interval [s]')
ylabel('(n+1)th RR interval [s]')
title('Poincaré plot of RR intervals')