params = initParams();
b = zeros(params.NX, Params.Ny);   %scattered waves
p_recording = zeros(1, params.Nt); %recording of pressure at a location for every timestep

t = (0:params.NT-1) *params.dt;    % column vector of every time instance.


%Simulation loop
for k = 1:params.Nt
    [b, p_recording(k)] = tlm_step(b,params,t(k)); %records pressure over time, and updates b for every step k
end


% Plot results
figure;
plot(t, p_recording);
xlabel('Time [s]');
ylabel('Pressure [Pa]');
title('Receiver response');

% Optional: FFT to see frequency content
Y = fft(rec);
f = (0:length(Y)-1)/params.T;
figure;
plot(f, abs(Y));
xlabel('Frequency [Hz]');
ylabel('|Amplitude|');
title('Frequency spectrum at receiver');