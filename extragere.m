function [Watermark] = extragere (img,img_wat,Simg,Wimg)

[x,y]=size(img_wat);
[Uimg,Simg_temp,Vimg]=svd(img);
[U_SHL_w,S_SHL_w,V_SHL_w]=svd(Simg);

[UWimg,SWimg,VWimg]=svd(Wimg);
D_1=U_SHL_w * SWimg * V_SHL_w'; 
alfa=1;
for i=1:x 
  for j=1:y
     Watermark(i,j)= (D_1(i,j) - Simg_temp(i,j) )/alfa ;
  end 
end

end