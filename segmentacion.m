function segmentos = segmentacion(img_act)
    %% 1. Adquisición de la imagen para entremamiento
    % si la imagen es RGB, se convierte a escala de grises
    if ndims(img_act) == 3
        img_act = rgb2gray(img_act);
    end
    img_act = imadjust(uint8(img_act));        
    %% 2. Segmentación en regiones
    thresh = multithresh(img_act,1);   
    img_seg = imquantize(img_act,thresh);
    img_seg = -1*(img_seg -2);
    %% 3. Erosion de regiones
    fact_er=4;
    se = strel('disk',fact_er);
    img_ero = imerode(img_seg,se);    
    %% 4. Etiquetado de las regiones hallados
    [regiones, num_seg] = bwlabel(img_ero);        
    %% 5. Se obtiene el Bounding Box de las regiones conectadas
    bBox = regionprops(regiones, 'BoundingBox');
    k = 1;
    for k = 1 : num_seg
        %se obtiene la región de imagen segmentada
        segmentos(k).image = regiones( ...
            ceil(bBox(k).BoundingBox(1,2)) : floor(bBox(k).BoundingBox(1,2)) + floor(bBox(k).BoundingBox(1,4)), ...
            ceil(bBox(k).BoundingBox(1,1)) : floor(bBox(k).BoundingBox(1,1)) + floor(bBox(k).BoundingBox(1,3)));            
        %se obtiene el centro
        segmentos(k).center = ceil(size(segmentos(k).image)/2);
        segmentos(k).bBox = bBox(k).BoundingBox;
        %se obtiene el tamaño
        segmentos(k).size = size(segmentos(k).image);
    end
    %% 6. limpieza 
    while k <= num_seg
       if sum(sum(segmentos(k).size)) < 10
           segmentos(k) = [];  
           num_seg = num_seg  - 1;
           k = k-1;
       end
       k = k+1;    
    end  
end