function [b, pressure_recording_receiver, pressure_recording_source] = tlm_step(b, params, t_step)
%TLM_STEP Calculation that happens for every timestep k
%must calculate incident waves, source generation, the scattering for next
%step k+1, and change scattering of b to account for scattering. Also
%record value at receiver. 

    a = tlm_incident(b, params); %incident on each node calculated as a result of scattering from every node in same time-step
    
    %Inject generated source acoustic signal
    % --- indices of source
    src_i = params.source.pos(1); 
    src_j = params.source.pos(2);
    
    source_signal = generate_source(params, t_step);
    a(src_i, src_j, params.source.dir) = a(src_i, src_j, params.source.dir) + source_signal; %signal gets injected into one of the branches


    %record the pressure value at receiver/source
    rec_i = params.recPos(1);
    rec_j = params.recPos(2);
    pressure_recording_receiver = 0.5 * sum(a(rec_i, rec_j, :)); %pressure recording at params.recPos
    pressure_recording_source = 0.5 * sum(a(src_i, src_j, :));   %pressure recording at source
    %calculate the scattering for next time step k+1
    b_next = tlm_scatter(a, params);

    %return value for next time step k+1
    b = b_next; 
end