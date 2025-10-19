function params = initParams()
    
    % --- Physical constants ---
    params.c = 343;                             % [m/s], speed of sound
    params.temp = 20;                           % [Celsius], simulation temperature 
    params.rho0 = 1.204;                        % [kg/m3], density of air
    
    
    % --- Pipe geometry ---
    params.Lx = 2;                              % [m], length of pipe
    params.Ly = 0.2;                            % [m], width of pipe

    % --- Frequency and resolution ---
    params.f_max = 2000;                         % [Hz], maximum frequency
    params.lambda_min = params.c/params.f_max;   % [m] shortest wavelength
    params.nppw = 40;                            % number of points per wavelength, should be >=10
    params.dl = params.lambda_min / params.nppw; % [m], step length between mesh points

    % --- Grid discretization ---
    params.Nx = ceil(params.Lx / params.dl);     % #of nodes in x-direction
    params.Ny = ceil(params.Ly / params.dl);     % #of nodes in y-direction

    % --- Time discretization ---
    params.dt = params.dl / params.c;            % [s] amount of time it takes to propogate a distance dl
    params.t_max = 1;                            % [s], maximum simulation time
    params.Nt = ceil(params.t_max / params.dt);  % # of time steps in simulation
    
    % -- Source signal parameters ---
    params.source.type = 'sweep';                % Set 'sweep', 'dirac' or 'harmonic' to make the source generator make different types
    params.source.pos  = [1,1];                  % source node position in the mesh
    % --- sweep source parameters ---
    params.source.f1 = 100;                      % [Hz], Start frequency of the sweep
    params.source.f2 = params.f_max;             % [Hz], Maximum frequency of the sweep
    params.source.T = 0.1 * params.t_max;        % duration of sweep pulse (as a function of total simulation time)
    %add direction?
    % ---harmonic source parameters
    params.source.freq = 858;                    % [Hz], Frequency for harmonic source 
    
      
    %boundary conditions
    params.R = 1;                               % Reflection coefficient at boundaries
    
    % --- Scattering Matrix 4x4 ---
    params.S = [-1, 1, 1, 1; 1, -1, 1, 1; 1, 1, -1, 1; 1, 1, 1, -1]; %Describes the scattering at every node
    
end