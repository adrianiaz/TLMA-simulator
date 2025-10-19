function x = generate_source(params, t)
%GENERATE_SOURCE creates sound source based on type ('sweep', 'dirac',
%'harmonic'), written in the initParams file.
    switch params.source.type
        case 'sweep'
            f1 = params.source.f1;
            f2 = params.source.f2;
            T  = params.T; % total duration of sweep
            x  = params.source.amp * sin(2*pi*(f1*t + (f2 - f1)/(2*T) * t.^2));
        case dirac
            x = zeros(size(t));
            x(1) = params.source.amp;  % approximate Dirac pulse at t=0
        case 'harmonic'
            f = params.source.freq;
            x = params.source.amp * sin(2*pi*f*t);
end