clc
clear all
close all
i=imread('cameraman.tif');
figure;
imshow(i);
figure;
h=[0 -1 0;-1 4 -1;0 -1 0];
j=conv2(h,i);
imshow(j,[]);