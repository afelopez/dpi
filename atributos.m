function [attr] = atributos(img)
    img = double(img);
    cont = 1;
    [nfilas, ncols] = size(img);
    centro = [(nfilas/2), (ncols/2)];         
    %% centroide X, centroide Y
    [y, x] = find(img);
    centroide = mean([y,x]);
    attr(cont) = centroide(1);  
    cont = cont + 1;
    attr(cont) = centroide(2);  
    cont = cont + 1;    
    %% distancia del centro al centroide
    attr(cont) = sqrt((centro(1) - centroide(1))^2 + (centro(2) - centroide(2))^2);    
end