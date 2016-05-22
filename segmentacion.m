function segmentos = segmentacion(img_act)
    %% 1. Segmentaci�n de regiones
        
    % AQUI DEBE IR CODIGO PARA BINARIZAR LA IMAGEN
    
    %% 3. Erosion de regiones
    fact_er=4;
    se = strel('disk',fact_er);
    img_ero = imerode(img_bin,se);    
    %% 4. Etiquetado de las regiones hallados
    [regiones, num_seg] = bwlabel(img_ero);        
    %% 5. Se obtiene el Bounding Box de las regiones conectadas
    bBox = regionprops(regiones, 'BoundingBox');    
    for k = 1 : num_seg
        %se obtiene la regi�n de imagen segmentada
        segmentos(k).image = regiones( ...
            ceil(bBox(k).BoundingBox(1,2)) : floor(bBox(k).BoundingBox(1,2)) + floor(bBox(k).BoundingBox(1,4)), ...
            ceil(bBox(k).BoundingBox(1,1)) : floor(bBox(k).BoundingBox(1,1)) + floor(bBox(k).BoundingBox(1,3)));            
        %se obtiene el centro
        segmentos(k).center = ceil(size(segmentos(k).image)/2);
        segmentos(k).bBox = bBox(k).BoundingBox;
        %se obtiene el tama�o
        segmentos(k).size = size(segmentos(k).image);
    end
    k = 1;    
    %% 6. limpieza 
    tam = segmentos(k).size(1)*segmentos(k).size(2);
    while k <= num_seg
       if (tam < 10000) || (tam > 62500)
           segmentos(k) = [];  
           num_seg = num_seg  - 1;
           k = k-1;
       end
       k = k+1;    
    end  
end