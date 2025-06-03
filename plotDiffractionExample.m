zmin = 0.001;
zmax = 0.5;
z_length = 500;
freq = 120;
W0 = 200; % in mm
Beamtype = 'Airy';
Y_bound = 2; % in m
Y_view = 0.25; % in m
OBA = true;
E0 = 1;

M_par = [0.13, 0.005, 0.02, 0.05]; % Blockage Information
RX_par = [0.28, -0.088, 1e-5, 0.025]; % Receiver Information
focal_BF = sqrt((RX_par(1))^2 + (RX_par(2))^2);
steering_BF = atand(RX_par(2)/RX_par(1));

% Airy Beam Parameters(Fig. S2)
B = -6.7507; 
focal = 0.1;
steering_angle = -10;

RX_info = [RX_par(2), RX_par(1), RX_par(3), RX_par(4)];
freq = freq*1e9;
% coordinates points and source creation
[L,Y,Z,res] = Grid_Creation(freq,zmin,zmax,z_length,Y_bound);
E = Source_Gen(Beamtype,'Planar',E0,res,zmin,W0,Y);
z_res = abs(Z(2) - Z(1));
H = prop_RS_channel(res, L, freq, z_res);

RX_idx = RX_pos(RX_info,Y,Z);

if(OBA)
    M = OB(Z,Y,M_par(1),M_par(2),M_par(3),M_par(4));
else
    M = ones(res,z_length);
end

E_matrix = BeamPropagation1D(Beamtype,steering_angle,E,W0,M,H,freq,Y,Z,focal,RX_idx,B);

figure
surface(Z,Y,abs(E_matrix).^2)
shading interp
colorbar
xlim([0, 0.5])
xticks(0:0.1:0.5)
colormap(hot)
% title('Propagation Profile (E-Field Power)')
ylabel('Transverse [m]')
xlabel('Propagation [m]')
ylim([-Y_view Y_view])
caxis([0 10])
colorbar off
grid off
axis square;
% axis off
hold on
set(gca,'Linewidth',2,'Fontname','Calibri','FontSize',18);


% plot3(RX_par(1), RX_par(2), 1e10, 'square', 'MarkerSize', 18, 'MarkerFaceColor', 'w', 'LineWidth', 4)

if OBA == true
    x = [M_par(1) + M_par(3)/2, M_par(1) - M_par(3)/2, M_par(1) - M_par(3)/2, M_par(1) + M_par(3)/2, M_par(1) + M_par(3)/2];
    y = [M_par(2) - M_par(4)/2, M_par(2) - M_par(4)/2, M_par(2) + M_par(4)/2, M_par(2) + M_par(4)/2, M_par(2) - M_par(4)/2];
    plot3(x, y, [1e10, 1e10, 1e10, 1e10, 1e10], 'w', 'LineWidth', 3)
end

