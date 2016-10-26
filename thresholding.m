clc
clear all
close all
i=imread('cameraman.tif');
figure;
imshow(i);
[m n]=size(i);
for j=1:m
    for k=1:n
        if i(j,k)>=128
        i(j,k)=255;
        else
        i(j,k)=0;
        end
     end
end
figure;
imshow(i);