function M = OB(Z,Y,z0,y0,Lz,Ly)

M = ones(length(Y),length(Z));
Y_top_limit = Ly/2 + y0;
Y_bottom_limit = -Ly/2 + y0;
[~,Y_top_idx] = min(abs(Y_top_limit - Y));
[~,Y_bottom_idx] = min(abs(Y_bottom_limit - Y));

Z_top_limit = Lz/2 + z0;
Z_bottom_limit = -Lz/2 + z0;
[~,Z_top_idx] = min(abs(Z_top_limit - Z));
[~,Z_bottom_idx] = min(abs(Z_bottom_limit - Z));

M(Y_bottom_idx:Y_top_idx,Z_bottom_idx:Z_top_idx) = zeros(Y_top_idx-Y_bottom_idx + 1,Z_top_idx-Z_bottom_idx + 1);


end