%https://www.mathworks.com/matlabcentral/fileexchange/64554-svd-domain-watermarking
clear all;
clc;
close all;
img= rgb2gray(imread('barca.jpg'));%host image
img=imresize(img,[256 256]);
[M,N]=size(img);
img=double(img);
[Uimg,Simg,Vimg]=svd(img);
Simg_temp=Simg;

% read watermark
 img_wat=imresize(rgb2gray(imread('img.jpg')),[256 256]);
   alfa= input('The alfa Value = ');
   [x,y]=size(img_wat);
   img_wat=double(img_wat);
   for i=1:x
       for j=1:y
          Simg(i,j) =Simg(i,j) + alfa * img_wat(i,j);
       end 
   end 
   % SVD for Simg (SM)
  [U_SHL_w,S_SHL_w,V_SHL_w]=svd(Simg);
Wimg =Uimg* S_SHL_w * Vimg';

figure
imshow(uint8(img));
title('The Original Image')
figure
imshow(uint8(img_wat));
title('The Watermark')

%pana aici am doar pt imagine normala cu watermark

[UWimg,SWimg,VWimg]=svd(Wimg);  %S_SHL_w=SWimg; UWimg=uimg; VWimg=Vimg
D_1=U_SHL_w * SWimg * V_SHL_w'; 
for i=1:x 
  for j=1:y
     Watermark(i,j)= (D_1(i,j) - Simg_temp(i,j) )/alfa ;
  end 
end

mse=mean(squeeze(sum(sum((double(img)-double(Wimg)).^2))/(M*N)));
PSNR=10*log10(255^2./mse)

figure
subplot(1,2,1);imshow(uint8(Wimg));title('The Watermarked Image')
subplot(1,2,2);imshow(uint8(Watermark));title('Watermark recovered (No attack case)');



%adding noise
Wimg1=imnoise(uint8(Wimg),'gaussian');
[UWimg,SWimg,VWimg]=svd(double(Wimg1));
D_1=U_SHL_w * SWimg * V_SHL_w';
for i=1:x 
  for j=1:y
     Watermark1(i,j)= (D_1(i,j) - Simg_temp(i,j) )/alfa ;
  end 
end
figure
subplot(1,2,1);imshow(Wimg1);title('Gaussian noised image')
subplot(1,2,2);imshow(uint8(Watermark1));title('Watermark recovered');
mse1=mean(squeeze(sum(sum((double(img)-double(Wimg1)).^2))/(M*N)));
PSNR1=10*log10(255^2./mse1)
%cropping
for i=1:x
  for j=1:y/2
       Wimg2(i,j)=Wimg(i,j+y/2);
  end 
end
Wimg2=imresize(Wimg2,[x,y]);
[UWimg,SWimg,VWimg]=svd(double(Wimg2));
D_1=U_SHL_w * SWimg * V_SHL_w';
for i=1:x 
  for j=1:y
     Watermark2(i,j)= (D_1(i,j) - Simg_temp(i,j) )/alfa ;
  end 
end
figure
subplot(1,2,1);imshow(uint8(Wimg2));title('Cropped Image')
subplot(1,2,2);imshow(uint8(Watermark2));title('Watermark recovered');

%compression

imwrite(uint8(Wimg),'op.jpg');
Wimg3=imread('op.jpg');
[UWimg,SWimg,VWimg]=svd(double(Wimg3));
D_1=U_SHL_w * SWimg * V_SHL_w';
for i=1:x 
  for j=1:y
     Watermark3(i,j)= (D_1(i,j) - Simg_temp(i,j) )/alfa ;
  end 
end
figure
subplot(1,2,1);imshow(Wimg3);title('JPEG compressed Image')
subplot(1,2,2);imshow(uint8(Watermark3));title('Watermark recovered');
