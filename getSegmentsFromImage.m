function [segments] = getSegmentsFromImage(testImage,DEBUG)


    %% 1. Carga de la imagen
    grayImageOriginal = imread(testImage);
    % si la imagen es RGB, se convierte a escala de grises
    if ndims(grayImageOriginal) == 3
        grayImageOriginal = rgb2gray(grayImageOriginal);
    end
    grayImage = imadjust(uint8(grayImageOriginal));    

%% 2. Obtener los segmentos de la imagen
    segments = getSegments(grayImage,DEBUG);
end