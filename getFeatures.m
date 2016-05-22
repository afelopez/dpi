function [features] = getFeatures(img, DEBUG)
    %casting
    img = double(img);
    %contador de caracteristicas
    cont = 1;
    [nFilas, nCols] = size(img);
    center = [(nFilas/2), (nCols/2)];        
    borde = bwmorph(img,'remove');
    %% centroide X, centroide Y
    [y, x] = find( borde );
    centroid = [mean(x) mean(y)];
    features(cont) = centroid(1);  
    cont = cont + 1;
    features(cont) = centroid(2);  
    cont = cont + 1;    
    %% distancia del centro al centroide
    features(cont) = sqrt( ...
        (center(1) - centroid(1))^2 + ...
        (center(2) - centroid(2))^2);    
   
end