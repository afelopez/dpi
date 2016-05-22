function segmentos = segmentacion(img_act)
%% 1. Adquisición de la imagen para entremamiento
    % si la imagen es RGB, se convierte a escala de grises
    if ndims(img_act) == 3
        img_act = rgb2gray(img_act);
    end
    grayImage = imadjust(uint8(img_act));        
%% 2. Obtener los segmentos de la imagen
    segmentos = getSegments(grayImage);    
end