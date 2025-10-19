function b = apply_boundaries(b,params)
%APPLY_BOUNDARIES 
    b(1,:,:)       = params.boundary.R * b(1,:,:);   %left side
    b(end,:,:)     = params.boundary.R * b(end,:,:); %right side
    b(:,1,:)       = params.boundary.R * b(:,1,:);   %bottom
    b(:,end,:)     = params.boundary.R * b(:,end,:); %top
end