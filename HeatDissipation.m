while 1
    rows = input("How many rows does the grid contain (input a value from 50-200)? ");
    if (50 <= rows && rows <= 200)
        break;
    end
    disp("Wrong input. Please enter a value between 50 and 200");
end

while 1
    cols = input("How many columns does the grid contain (input a value from 50-200)? ");
    if (50 <= cols && cols <= 200)
        break;
    end
    disp("Wrong input. Please enter a value between 50 and 200");
end

temp = [0 0 0 0];

disp("What are the temperatures at the following sides of a metal plate (input a value from 0 to 255): ");

while 1
    temp(1,1) = input("Top: ");
    if (0 <= temp(1,1) && temp(1,1) <= 255)
        break;
    end
    disp("Wrong input. Please enter a value between 0 and 255");
end

while 1
    temp(2) = input("Bottom: ");
    if (0 <= temp(2) && temp(2) <= 255)
        break;
    end
    disp("Wrong input. Please enter a value between 0 and 255");
end

while 1
    temp(3) = input("Left: ");
    if (0 <= temp(3) && temp(3) <= 255)
        break;
    end
    disp("Wrong input. Please enter a value between 0 and 255");
end

while 1
    temp(4) = input("Right: ");
    if (0 <= temp(4) && temp(4) <= 255)
        break;
    end
    disp("Wrong input. Please enter a value between 0 and 255");
end

while 1
    threshold = input("Please input the threshold value (input a value between 0 and 0.05): ");
    if (0 < threshold && threshold <= 0.05)
        break;
    end
    disp("Wrong input. Please enter a value between 0 and 0.05");
end

mat = zeros(rows,cols);
mat(1,:)=temp(1);
mat(rows,:)=temp(2);
mat(2:rows-1,1)=temp(3);
mat(2:rows-1,cols)=temp(4);

subplot(2,2,1);
imagesc(mat);
title('Heat Dissipation at Time = 0');
colormap('jet');
colorbar;

subplot(2,2,2);
contour(mat);
title('Surface Contours at Time = 0');
set(gca, 'YDir','reverse')
colormap('jet');
drawnow limitrate;

mat1=mat;
bool=1;
ctr=0;

while bool==1
    bool = 0;
    for r = 2:rows-1
        for c = 2:cols-1
            mat1(r, c) = (mat(r, c-1)+mat(r, c+1)+mat(r-1, c)+mat(r+1, c))/4;
            if (mat(r,c)-threshold >= mat1(r, c) || mat1(r,c) >= mat(r,c)+threshold)
                bool=1;
            end
        end
    end
    ctr=ctr+1;
    mat=mat1;
    
    if mod(ctr, 200)==0
      subplot(2,2,3);
      imagesc(mat);
      if ~(ctr==1)
          caxis([0 255]);
      end
      title(['Heat Dissipation at Time = ', num2str(ctr)]);
      colormap('jet');
      colorbar;
      
      subplot(2,2,4);
      contour(mat);
      title(['Surface Contours at Time = ', num2str(ctr)]);
      set(gca, 'YDir','reverse')
      colormap('jet');
      drawnow limitrate;
    end

end

subplot(2,2,3);
imagesc(mat);
if ~(ctr==1)
    caxis([0 255]);
end
title(['Heat Dissipation at Time = ', num2str(ctr)]);
colormap('jet');
colorbar;

subplot(2,2,4);
contour(mat);
title(['Surface Contours at Time = ', num2str(ctr)]);
set(gca, 'YDir','reverse')
colormap('jet');
drawnow limitrate;
