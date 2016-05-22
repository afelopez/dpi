function init()
    carpetaEntrenamiento ='nums';
    %% se segmentan los números
    for i = 1:5 
        disp(['Segmentando training set: ' num2str(i)]);
        mkdir (['trainingSet/' carpetaEntrenamiento '/'  num2str(i)]);
        img_act = imread(['trainingSet/' num2str(i) '.jpg']);
        segmentos = segmentacion(img_act);
        % guarda los segmentos
        numObj = length(segmentos);
        for k = 1 : numObj        
            imwrite(segmentos(k).image,['trainingSet/' carpetaEntrenamiento '/' num2str(i) '/' num2str(i) '_' num2str(k,'%03d') '.png']); 
        end
    end
end