function getSegmentsFromTrainingSet(nTrainingSet, folderName)
%% 1. Adquisición de la imagen para entremamiento
    grayImageOriginal = imread(['trainingSet/' num2str(nTrainingSet) '.jpg']);
    % si la imagen es RGB, se convierte a escala de grises
    if ndims(grayImageOriginal) == 3
        grayImageOriginal = rgb2gray(grayImageOriginal);
    end
    grayImage = imadjust(grayImageOriginal);    

    
%% 2. Obtener los segmentos de la imagen
    segments = getSegments(grayImage,0);

%% 3. Guardar los segmentos
    numObj = length(segments);
    for k = 1 : numObj        
        imwrite(segments(k).image,['trainingSet/' folderName '/' num2str(nTrainingSet) '/' num2str(nTrainingSet) '_' num2str(k,'%03d') '.png']); 
    end
end