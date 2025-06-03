function [L,Y,Z,res] = Grid_Creation(freq,zmin,zmax,z_length,Y_bound,varargin)
    %% Do not Touch
    if(~isempty(varargin))
        z_metric = 'manual';
        res = varargin{1};
        disp('Transverse (Y) Resolution Manually Configured')
    else
        c =  physconst('LightSpeed');
        lambda = c./(freq);
        z_metric = 'critical';
    end
    %% coordinates points creation
    Z = linspace(zmin,zmax,z_length);
%     Z = single(Z);
    if(strcmp(z_metric,'manual'))
%         res= 1000;
        Y= linspace(-Y_bound,Y_bound,res)';
%         Y = single(Y);
        L = Y_bound*2;
    elseif(strcmp(z_metric,'critical'))
        z_critical = (lambda*zmax/(2*Y_bound));
        end_lengths = round(Y_bound/z_critical);
        Y  = (-end_lengths*z_critical:z_critical:end_lengths*z_critical)';
        L = end_lengths*z_critical*2;
        res = length(Y);
    end
end