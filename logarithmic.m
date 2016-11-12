clc
clear all
close all
i=imread('cameraman.tif');
figure;
imshow(i);
[m n]=size(i);
i=double(i);
for j=1:m
    for k=1:n
        i(j,k)=log(1+i(j,k));
    end
end
figure;
imshow(i,[]);