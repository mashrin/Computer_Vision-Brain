clc; clear all; close all

im=imread('C:\Users\HP\Desktop\normal\N5.tif');
imshow(im); axis on; title('Original MRI Image'); figure
% image(im); colormap('bone'); figure

% [height, width, planes] = size(im);
% rgb = reshape(im, height, width*planes);
rgb=im(:,:,1);
imagesc(rgb); colormap('default'); figure

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
    ir1=horzcat(pad,ir1);
end

subplot(121); imshow(il); title('Left Half');
subplot(122); imshow(ir1); title('Flipped Right Half'); figure

diff=abs(il-ir1);
imshow(imadjust(diff)); title('Difference');

% for i=1:size(diff,1)
%     for j=1:size(diff,2)
%         if diff(i,j)<100
%             diff(i,j)=0;
%         end
%     end
% end
% imshow(diff); title('Enhanced Difference')

%Histogram
hist_l=imhist(il);
for i=1:length(hist_l)
    if(hist_l(i)==0)
        histo_l(i)=1;
    else
        histo_l=hist_l(i);
    end
end
hist_r=imhist(ir);
for i=1:length(hist_r)
    if(hist_r(i)==0)
        histo_r(i)=1;
    else
        histo_r(i)=hist_r(i);
    end
end

%Entropy
etp_l=-sum(histo_l.*log2(histo_l))
etp_r=-sum(histo_r.*log2(histo_r))

if (etp_l>etp_r)
    tumor=im2bw(il);
    disp('Entropy on left half is greater. Therefore abnormality is in left half of brain.');
else
    tumor=im2bw(ir);
    disp('Entropy on right half is greater. Therefore abnormality is in right half of brain.');
end

%Region Properties
statsl=regionprops(tumor,'Solidity');
Solidity_Left=statsl.Solidity

statsr=regionprops(im2bw(ir),'Solidity');
Solidity_Right=statsr.Solidity

if (Solidity_Left>Solidity_Right)
    disp('Solidity on left half is greater. Therefore abnormality is in left half of brain.');
else
    disp('Solidity on right half is greater. Therefore abnormality is in right half of brain.');
end

glcml=graycomatrix(il,'Offset',[2 0;0 2]);
[outleft]=GLCMFeatures(glcml)

glcmr=graycomatrix(ir,'Offset',[2 0;0 2]);
[outright]=GLCMFeatures(glcmr)