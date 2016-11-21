clc
clear all
close all
p=imread('cameraman.tif');
b=zeros(255);
[k l]=size(p)
for a=1:256
    c=0;
    for i=1:k
        for j=1:k
            if (p(i,j)==(a-1))
                c=c+1;
            end
        end
    end
    b(a)=c;
end
