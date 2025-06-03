function aperture = aperture1D(Grid,W0,y0)
aperture = zeros(size(Grid));
top_limit = W0/2 + y0;
bottom_limit = -W0/2 + y0;
[~,top_idx] = min(abs(top_limit - Grid));
[~,bottom_idx] = min(abs(bottom_limit - Grid));
idx = bottom_idx:top_idx;
aperture_size = length(idx);
aperture(idx) = ones(1,aperture_size);

end