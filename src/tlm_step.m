function [b, pressure_recording] = tlm_step(b, params, t_step)
%TLM_STEP Calculation that happens for every timestep k
%must calculate incident waves, source generation, the scattering for next
%step k+1, and change scattering of b to account for scattering. Also
%record value at receiver. 

    a = tlm_incident();
    
end