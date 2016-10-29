clc
clear all
close all
i=imread('cameraman.tif');
figure;
imshow(i);
h=fspecial('average');
j=conv2(i,h);
figure;
imshow(j,[]);
figure;
z=imfilter(i,h);
imshow(z);
i1=1*i;
%i1=double(i1);
size(i1)
size(z)
i1=i1-z;
figure;
imshow(i1);
