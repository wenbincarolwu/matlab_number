tic
clc;clear all;close all;

origin = imread('input//IMG_0029.PNG');
figure, imshow(origin, 'InitialMagnification', 50);
m = size(origin, 1);

img = origin(uint32(m*0.2):uint32(m*0.9),:,:);
img_gray = rgb2gray(img);
% figure, imshow(img_gray);

% [index, masks, files] = preProcessing();
% save('preProcessing.mat', 'index', 'masks', 'files');

load preProcessing.mat

t = toc;

for i=1:16
    ix = index(i, :);
    subimg = img_gray(ix(1):ix(2), ix(3):ix(4));
    if((max(subimg)-min(subimg))<20)
        fprintf('  X ');
    else
        num = detect(subimg, masks,files);
        fprintf(' %2d ',num);
    end
    if(mod(i,4)==0)
        fprintf('\n');
    end
end
disp('used');
disp(toc - t);





