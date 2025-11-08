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
win = hann(length(p_recording_receiver))';
p_windowed = p_recording_receiver .* win;

Y = fft(p_recording_receiver);
Y_pos = Y(1:floor(params.Nt/2));

%SPL 
p_ref = 20e-6;   % 20 µPa reference
SPL = 20 * log10( abs(Y_pos) / p_ref );


f = (0:params.Nt/2-1)/(params.Nt * params.dt);

%% === Plot results ===

% --- Store figure handles in correct order ---
h = gobjects(4,1);  % Preallocate for figure handles

% Receiver time response
h(1) = figure;
plot(t, p_recording_receiver);
xlabel('Time [s]');
ylabel('Pressure [Pa]');
title('Receiver response');
grid on;

% Source signal
h(2) = figure;
plot(t, p_recording_source);
xlabel('Time [s]');
ylabel('Pressure [Pa]');
title('Source signal');
grid on;

% Amplitude spectrum
h(3) = figure;
plot(f, abs(Y_pos));
xlabel('Frequency [Hz]');
ylabel('|Amplitude|');
title('Frequency spectrum at receiver');
xlim([0 params.f_max]);
grid on;

% SPL spectrum
h(4) = figure;
plot(f, SPL);
xlabel('Frequency [Hz]');
ylabel('SPL [dB re 20 µPa]');
title('Frequency spectrum at receiver (SPL)');
xlim([0 params.f_max]);
grid on;


%% === Automatically save all figures and data ===

% Ensure main figures directory exists
if ~exist('figures', 'dir')
    mkdir('figures');
end

% Create subfolder for this source type, e.g. ./figures/sweep/
srcType = params.source.type;
srcDir = fullfile('figures', srcType);
if ~exist(srcDir, 'dir')
    mkdir(srcDir);
end

% Create additional subfolder for R value, formatted safely (no dots)
R_value = params.R;
R_str = sprintf('R%.2f', R_value);   % e.g. "R1.00"
R_str = strrep(R_str, '.', '_');     % -> "R1_00"
subDir = fullfile(srcDir, R_str);
if ~exist(subDir, 'dir')
    mkdir(subDir);
end

% Descriptive filenames for each figure
figNames = {'receiver_time', 'source_time', 'amplitude_spectrum', 'SPL_spectrum'};

% --- Save figures ---
for k = 1:numel(h)
    fig = h(k);

    % Construct base name: e.g. sweep_R1_00_receiver_time
    baseName = sprintf('%s_%s_%s', srcType, R_str, figNames{k});

    % Full file paths
    savePathPNG = fullfile(subDir, [baseName, '.png']);
    savePathFIG = fullfile(subDir, [baseName, '.fig']);

    % Save files
    exportgraphics(get(fig, 'CurrentAxes'), savePathPNG, 'Resolution', 300);
    savefig(fig, savePathFIG);

    fprintf('Saved: %s\n', savePathPNG);
end

% --- Save simulation data ---
dataFile = fullfile(subDir, sprintf('%s_%s_data.mat', srcType, R_str));
save(dataFile, 'params', 't', 'p_recording_receiver', 'p_recording_source', 'f', 'Y_pos', 'SPL');
fprintf('Saved simulation data to: %s\n', dataFile);
