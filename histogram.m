clc
clear all
close all
i=imread('cameraman.tif');
figure;
imshow(i);
figure;
imhist(i);
figure;
h=histeq(i);
imshow(h);
figure;
imhist(h);