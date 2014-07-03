function num = detect(subimg, masks, files)
    
    level = graythresh(subimg);
    BW = im2bw(subimg, level);
    
    if (BW(1, 1)>0)
        BW = ~BW;
    end
    
    s = regionprops(BW, 'BoundingBox');
    num = 0;
    for i=1:size(s,1)
        subImage = BW(round(s(i).BoundingBox(2):s(i).BoundingBox(2)+s(i).BoundingBox(4)),...
           round(s(i).BoundingBox(1):s(i).BoundingBox(1)+s(i).BoundingBox(3)));
       min = -1;
       mid = 0;
       for j=1:length(masks)
           mask = masks{j};
           sub = imresize(subImage, size(mask));
           tmp = sum(sum(abs(mask - sub)));
           if(tmp<100)
               mid = j;
               break;
           end
           if(min<0||tmp<min)
               min = tmp;
               mid = j;
           end
       end
        num = num*10 + files(mid+3).name(1)-'0';
    end
end