function b = apply_boundaries(b,params)
%APPLY_BOUNDARIES 
    b(1,:,:)       = params.R * b(1,:,:);   %left side
    b(end,:,:)     = params.R * b(end,:,:); %right side
    b(:,1,:)       = params.R * b(:,1,:);   %bottom
    b(:,end,:)     = params.R * b(:,end,:); %top
end