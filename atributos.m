function [features] = atributos(img)
    img = double(img);
    cont = 1;
    [nFilas, nCols] = size(img);
    centro = [(nFilas/2), (nCols/2)];        
    borde = bwmorph(img,'remove');
    %% centroide X, centroide Y
    [y, x] = find( borde );
    centroide = [mean(x) mean(y)];
    features(cont) = centroide(1);  
    cont = cont + 1;
    features(cont) = centroide(2);  
    cont = cont + 1;    
    %% distancia del centro al centroide
    features(cont) = sqrt( ...
        (centro(1) - centroide(1))^2 + ...
        (centro(2) - centroide(2))^2);    
end