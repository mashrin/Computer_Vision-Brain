clc
clear all
close all
i=imread('cameraman.tif');
h=[0.11 0.11 0.11;0.11 0.11 0.11;0.11 0.11 0.11];
j=conv2(i,h);
figure;
l=imshow(i)
figure;
n=imshow(j,[])