function a = tlm_incident(b, params)
%TLM_INCIDENT_FROM_B incident pressure on node
%Calculates the incident pressure on node in timestep k as a result of
%scattering in previous timestep k-1. a is a Nx 


    [Nx, Ny, channels] = size(b); %channels is the vector containing pressure on each of the 4 tube channels (w;n;e;s)

    a = zeros(Nx, Ny, channels); %3D array of all nodes, with 4 tube-channels for each node

    % --- interior reflections --- channels: (1= west; 2 = north; 3 = east; 4 = south)

    %--- incidence on western channel -- comes from node (i-1,j) eastern channel 
    a(2:end,:,1) = b(1:end-1,:,3);
    %--- incidence on northern channel -- comes from node (i,j+1) southern channel 
    a(:,1:end-1,2) = b(:,2:end,4);
    %--- incidence on eastern channel -- comes from node (i+1,j) western channel 
    a(1:end-1,:,3) = b(2:end,:,1);
    %--- incidence on southern channel -- comes from node (i,j-1) northern channel 
    a(:,2:end,4) = b(:,1:end-1,2);
   
    % --- boundary reflections ---
    R = params.R;

    % --- left side boundary ---
    a(1,:,1) = R * b(1,:,1);
    
    % --- top side boundary ---
    a(:,end,2) = R * b(:,end,2);

    % --- right side boundary ---
    a(end,:,3) = R * b(end,:,3);
    
    % --- bottom side boundary ---
    a(:,1,4) = R * b(:,1,4);
    
end