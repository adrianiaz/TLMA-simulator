clearvars;          % clears all variables but keeps functions in memory
close all;          % closes all figure windows
clc;                % clears command window

params = initParams();
b = zeros(params.Nx, params.Ny, 4);   %scattered waves
p_recording_receiver = zeros(1, params.Nt); %recording of pressure at receiver for every timestep
p_recording_source = zeros(1, params.Nt);   %recording of pressure at source for every timestep
t = (0:params.Nt-1) *params.dt;    % column vector of every time instance.


%Simulation loop
for k = 1:params.Nt
    [b, p_recording_receiver(k), p_recording_source(k)] = tlm_step(b,params,t(k)); %records pressure over time, and updates b for every step k

    if mod(k, round(params.Nt/10)) == 0                     % -- -- progress status
        fprintf('Progress: %.0f%%\n', 100*k/params.Nt);
    end
end

%FFT for frequency content of recorded signal (frequency response)
%win = hann(length(p_recording_receiver))';
%p_windowed = p_recording_receiver .* win;

Y = fft(p_recording_receiver);
Y_pos = Y(1:floor(params.Nt/2));
f = (0:params.Nt/2-1)/(params.Nt * params.dt);

% Plot results
figure;
plot(t, p_recording_receiver);
xlabel('Time [s]');
ylabel('Pressure [Pa]');
title('Receiver response');

% Plot results
figure;
plot(t, p_recording_source);
xlabel('Time [s]');
ylabel('Pressure [Pa]');
title('source signal');


figure;
plot(f, abs(Y_pos));
xlabel('Frequency [Hz]');
ylabel('|Amplitude|');
title('Frequency spectrum at receiver');
xlim([0 params.f_max]);  % optional, limit x-axis to max frequency of interest

%SPL 
p_ref = 20e-6;   % 20 µPa reference
SPL = 20 * log10( abs(Y_pos) / p_ref );

figure;
plot(f, SPL);
xlabel('Frequency [Hz]');
ylabel('SPL [dB re 20 µPa]');
title('Frequency spectrum at receiver (SPL)');
xlim([0 params.f_max]);   % optional
grid on;