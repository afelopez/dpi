function segmentos = getSegmentsFromTrainingSet(nTrainingSet)
%% 1. Adquisición de la imagen para entremamiento
    grayImageOriginal = imread(['trainingSet/' num2str(nTrainingSet) '.jpg']);
    % si la imagen es RGB, se convierte a escala de grises
    if ndims(grayImageOriginal) == 3
        grayImageOriginal = rgb2gray(grayImageOriginal);
    end
    grayImage = imadjust(grayImageOriginal);        
%% 2. Obtener los segmentos de la imagen
    segmentos = getSegments(grayImage);    
end