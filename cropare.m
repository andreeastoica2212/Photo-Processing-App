function [Wimg2] = cropare (Wimg)

[x,y]=size(Wimg);

for i=1:x
  for j=1:y/2
       Wimg2(i,j)=Wimg(i,j+y/2);
  end 
end

end