function E = Source_Gen(Beamtype,Source,E0,res,z0,W0,Y)
    if(strcmp(Source,"Planar"))
        E = E0*ones(res,1);
    elseif(strcmp(Source,"Gaussian") || strcmp(Beamtype,"Gaussian")) 
        zr = 0.5*k*(W0)^2; %Rayleigh length or Rayleigh range
        W = W0*sqrt(1+(z0/zr).^2);
        R = z0.*(1+(zr./z0).^2);  %radius of curvature;
        %R = Inf; %% Assume planar
        xi = atan(z0./zr);         % Gouy-Phase
        E = E0*W0./W.*exp(-Y.^2./W.^2).*exp(-1i*(k*z0+k*Y.^2./(2*R)-xi));
    end
end