function x = generate_source(params, t)
%GENERATE_SOURCE creates sound source based on type ('sweep', 'dirac',
%'harmonic'), written in the initParams file.
    switch params.source.type
        case 'sweep'
            if t <= params.source.T
                f1 = params.source.f1;
                f2 = params.source.f2;
                T  = params.source.T; % total duration of sweep
                x  = params.source.amp * sin(2*pi*(f1*t + (f2 - f1)/(2*T) * t.^2));
            else
                x = 0; 
            end
        case 'dirac'
            if abs(t) < 1e-12             %small tolerance, 
                x = params.source.amp;    %sets x = 1, only for t = 0
            else
                x = 0; 
            end
        case 'harmonic'
            f = params.source.freq;
            x = params.source.amp * sin(2*pi*f*t);
        otherwise
            warning('Unknown source type: %s', params.source.type);
            x = 0;
     end