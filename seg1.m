clc
clear all
close all
image = imread('A10.tif');     % read image

% get image dimensions: an RGB image has three planes
% reshaping puts the RGB layers next to each other generating
% a two dimensional grayscale image
 [height, width, planes] = size(image);
 rgb = reshape(image, height, width*planes);


imagesc(rgb)                % visualize RGB planes

colourbar on                   % display colorbar

r = image(:, :, 1);             % red channel
g = image(:, :, 2);             % green channel
b = image(:, :, 3);             % blue channel
threshold = 100;                % threshold value
imagesc(b < threshold);         % display the binarized image
% apply the blueness calculation
blueness = double(g) - max(double(g), double(b));

imagesc(blueness);              % visualize RGB planes
colorbar on                     % display colorbar
% apply thresholding to segment the foreground
mask = blueness < 45;
%imagesc(mask);

% create a label image, where all pixels having the same value
% belong to the same object, example
% 1 1 0 1 1 0      1 1 0 2 2 0
% 0 1 0 0 0 0      0 1 0 0 0 0
% 0 0 0 1 1 0  ->  0 0 0 3 3 0
% 0 0 1 1 1 0      0 0 3 3 3 0
% 1 0 0 0 1 0      4 0 0 0 3 0
labels = bwlabel(mask);

% get the label at point (200, 200)
id = labels(200, 200);

% get the mask containing only the desired object
man = (labels == id);
%imagesc(man);

% save the image in PPM (portable pixel map) format
imwrite(man, 'abc.tif');
im=imread('abc.tif');

%%%%%%%%%%
imshow(im); axis on; title('Original MRI Image'); figure
i1=rgb2gray(im);
im=imadjust(i1);
imshow(im); title('Enhanced Image')

nx=size(im,1);
ny=size(im,2);
nrgb=size(im,3);
[xp,yp]=ginput(1);

il=im(:,1:xp(1),:);
ir=im(:,(xp(1)+1):ny,:);
nr=size(ir,2);

figure
subplot(121); imshow(il); title('Left Half');
subplot(122); imshow(ir); title('Right Half'); figure

ir1=fliplr(ir);
% imshow(ir1); title('Flipped Right Image')

nilx=size(il,2);
nirx=size(ir1,2);

if nilx-nirx>0
    pad=zeros(size(ir1,1),nilx-nirx);
    ir1=horzcat(ir1,pad);
end

subplot(121); imshow(il); title('Left Half');
subplot(122); imshow(ir1); title('Flipped Right Half'); figure

diff=abs(il-ir1);
imshow(imadjust(diff)); title('Difference'); figure

for i=1:size(diff,1)
    for j=1:size(diff,2)
        if diff(i,j)<50
            diff(i,j)=0;
        end
    end
end
imshow(diff); title('Enhanced Difference')