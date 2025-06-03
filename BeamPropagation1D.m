%% Parameter Explanation
%zmin: starting propagation length

%zmax:  ending propagation length in m

%z_length: number of data points across propagation range

% f: Operating frequency, in GHz

% Beamtype; Gaussian, Bessel, Gaussian_BFocusing, and Airy

% W0: Aperture/Array Radius (in mm)

%OBA: Is an object of onstruction present?
% M_par, a vector of the object of objection's geometry:  z0 (center-
% distance location),y0 (center height location),Lz (height),Ly (width) all
% in m
%% Wavefront Dependent Parameter Settings (MUST BE Entered in this specfic order)

%     %% Bessel Beam Settings
%     n: refractive index 
%     refracting_angle: cone angle of axicon
% 
%     %% Gaussian Focusing Setiings
%     focal: focus distance of the lens
% 
%     %% Airy Settings
%     focal: focus distance of the lens
%     B: Curvature Parameter


function E_maxtrix = BeamPropagation1D(Beamtype,steering_angle,E,W0,M,H,freq,Y,Z,focal,RX_idx,varargin)
    %% Fixed settings
%     E0= 1;
    WF_gen = 'Rayleigh_mode';
    %WF_gen = 'fresnel_mode';
    %% Source
    Source = "Planar";
    %Source = "Gaussian";
    %% Do Not Touch
    W0 = W0*1e-3;
    %z0 = Z(1);
    c =  physconst('LightSpeed');
    lambda = c./freq;
    %k = (2*pi)/lambda;
    dy = abs(Y(1) - Y(2));
    res = length(Y);
    z_res = abs(Z(2) - Z(1));

    z_length = length(Z);
    %% Determine RX Location
 
    rx_ystart = RX_idx(1);
    rx_yend   = RX_idx(2);
    rx_zstart = RX_idx(3);
    %rx_zend   = RX_idx(4);

    %% Check that Fresnel Condition is being fullfilled
    if(strcmp(WF_gen,'fresnel_mode'))
        zcondition = (res*(dy)^2)/lambda;
        if (z_res <= zcondition)
            disp('Fresnel Condition Step Size Fullfilled')
        else
            disp('Fresnel Condition Step Size Not Fullfilled')
            return
        end
    end

    %% Transfer Function Equation
    tr = Wavefront_Structure(Beamtype,Y,lambda,W0,varargin);
    %% Apply Phase Shift for Beam Steering
    tr = Steering_Weight(freq,tr,Y,W0,dy,steering_angle,Beamtype,focal);
    %% Determine Source Type and Configure Array
    E_maxtrix = zeros(res,z_length);
    E = E.*tr.*M(:,1);
    E_maxtrix(:,1) = E;
    %% Generate Wavefronts    
    for i = 2:z_length
        E = M(:,i).*prop_RS_cal(E, H);
        E_maxtrix(:,i) = E;
    end
end









