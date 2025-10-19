function b_next = tlm_scatter(a)
%TLM_SCATTER scattering at timestep k+1 as a result of pressures at
%timestep k
%  Can calculate b as a result of scattering matrix S and vector a for each
%  node
    [Nx, Ny, channels] = size(a);
    b_next = zeros(Nx,Ny,channels); 
    S = params.S;

    for i = 1:Nx
        for j = 1:Ny
            a_node = squeeze(a(i,j,:)); %extract 4x1 column vector of incident pressures
            b_node = 0.5 * S * a_node;  %applies scattering
            b_next(i,j,:) = b_node;     %Puts them in the total b_next
        end
    end
end