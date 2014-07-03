function wid = findIndex(wstart, padding, width, gap_w)
    wid = zeros(1, 8);
    for i = 0:3
        wid(1+2*i) = uint32((wstart + gap_w + padding) + i*(width + gap_w));
        wid(2*(i+1)) = uint32((wstart + gap_w + width - padding) + i*(width + gap_w));
    end
end