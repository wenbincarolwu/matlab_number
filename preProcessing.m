function [index, mask, files] = preProcessing()
% compute subgraph index using 'IMG_0026.PNG'
% return index

%% cut header and footer, convert to gray
    origin = imread('IMG_0026.PNG');
    m = size(origin, 1);
    img = origin(uint32(m*0.2):uint32(m*0.9),:,:);
    img_gray = rgb2gray(img);

%% detect edge for rectangles
    BW = edge(img_gray,'canny');
    [h,w] = size(img_gray);

%% 
% find len, gap, start etc parameter
% for both width and height
    row = BW(uint32(h*0.6),:);
    col = BW(:, uint32(w*0.2));
    row = find(row>0);

    wstart = row(1);
    width = row(3)-row(2);
    gap_w = row(2)-row(1);

    col = find(col>0);
    hstart = col(1);
    gap_h = col(2) - col(1);

    col_tmp = col(2:end);
    col = col(1:end-1);
    col = col_tmp - col;
    height = max(col);

%% return subgraph index
    windex = findIndex(wstart, 2, width, gap_w);
    hindex = findIndex(hstart+10, 20, height, gap_h+5);
    
    index = zeros(16, 4);

    for i = 1:4
        for j = 1:4
            index(4*(i-1)+j,1) = hindex(i*2-1);
            index(4*(i-1)+j,2) = hindex(i*2);
            index(4*(i-1)+j,3) = windex(j*2-1);
            index(4*(i-1)+j,4) = windex(j*2);
        end
    end
%% load mask
    mask_dir = 'mask';
    files = dir(mask_dir);

    nfile = max(size(files));
    mask = cell(1, nfile-3);
    for i=4:nfile
        mask{i-3} = imread(fullfile(mask_dir,files(i).name));
    end
end