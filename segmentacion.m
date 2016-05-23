function segmentos = segmentacion(img_act)
    % Segmentación de regiones
    % se convierte a escala de grises y se binariza la imagen la imagen
    % invertida
    img_act = rgb2gray(img_act);
    umbral = graythresh(img_act);   
    img_bw = not(im2bw(img_act,umbral));
    % uso del  filtros morfologicos 
    fact_cer=3;
    fact_er=4;
    se = strel('disk',fact_er);
    sc = strel('disk',fact_cer);
    img_cerr= imclose(img_bw,sc);
    img_ero = imerode(img_cerr,se);    
    % Etiquetado de las regiones hallados
    [regiones, num_seg] = bwlabel(img_ero);        
    % Se obtiene el cuadro delimitador de las regiones conectadas
    c_del = regionprops(regiones, 'BoundingBox');    
    for k = 1 : num_seg
        %se obtiene la región de imagen segmentada
        segmentos(k).image = regiones( ...
            ceil(c_del(k).BoundingBox(1,2)) : floor(c_del(k).BoundingBox(1,2)) + floor(c_del(k).BoundingBox(1,4)), ...
            ceil(c_del(k).BoundingBox(1,1)) : floor(c_del(k).BoundingBox(1,1)) + floor(c_del(k).BoundingBox(1,3)));            
        %se obtiene el centro
        segmentos(k).center = ceil(size(segmentos(k).image)/2);
        segmentos(k).c_del = c_del(k).BoundingBox;
        %se obtiene el tamaño
        segmentos(k).size = size(segmentos(k).image);
    end
    k = 1;  
    % limpieza 
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