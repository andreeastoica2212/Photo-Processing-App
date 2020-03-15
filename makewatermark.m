function [Simg,Wimg] = makewatermark (img, img_wat)

[Uimg,Simg,Vimg]=svd(img);
Simg_temp=Simg;

%watermark
   
   alfa=1;
   [x,y]=size(img_wat);
   
   for i=1:x
       for j=1:y
          Simg(i,j) =Simg(i,j) + alfa * img_wat(i,j);
       end 
   end
   
% SVD for Simg (SM)
[U_SHL_w,S_SHL_w,V_SHL_w]=svd(Simg);
Wimg =Uimg* S_SHL_w * Vimg';

end