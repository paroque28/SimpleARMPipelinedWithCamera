img = imread('lenna.png');
count = 0;
for i = 1:200
  for j = 1:200
    count = count+1;
    printf("%d",count);
    printf([ " : 00",dec2hex(img(i,j,1),2), dec2hex(img(i,j,2),2), dec2hex(img(i,j,3),2), " ;"]);
    printf("\n");
  endfor
endfor
