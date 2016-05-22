function segmentos = segmentacion(img_act)
%% 1. Adquisición de la imagen para entremamiento
    % si la imagen es RGB, se convierte a escala de grises
    if ndims(img_act) == 3
        img_act = rgb2gray(img_act);
    end
    grayImage = imadjust(uint8(img_act));        
    %% Segmentación en regiones
    thresh = multithresh(grayImage,1);   
    segmentedImage = imquantize(grayImage,thresh);
    segmentedImage = -1*(segmentedImage -2);
    %% Erosion de regiones
    erodeFactor=4;
    se = strel('disk',erodeFactor);
    erodedImage = imerode(segmentedImage,se);    
    %% Etiquetado de las regiones hallados
    [regions, numObj] = bwlabel(erodedImage);        
    %% Se obtiene el Bounding Box de las regiones conectadas
    bBox = regionprops(regions, 'BoundingBox');
    %% Se llena la estructura de regiones encontradas
    k = 1;
    for k = 1 : numObj
        %se obtiene la región de imagen segmentada
        segmentos(k).image = regions( ...
            ceil(bBox(k).BoundingBox(1,2)) : floor(bBox(k).BoundingBox(1,2)) + floor(bBox(k).BoundingBox(1,4)), ...
            ceil(bBox(k).BoundingBox(1,1)) : floor(bBox(k).BoundingBox(1,1)) + floor(bBox(k).BoundingBox(1,3)));            
        %se obtiene el centro
        segmentos(k).center = ceil(size(segmentos(k).image)/2);
        segmentos(k).bBox = bBox(k).BoundingBox;
        %se obtiene el tamaño
        segmentos(k).size = size(segmentos(k).image);
    end
    %% limpieza 
    while k <= numObj
       if sum(sum(segmentos(k).size)) < 10
           segmentos(k) = [];  
           numObj = numObj  - 1;
           k = k-1;
       end
       k = k+1;    
    end  
end