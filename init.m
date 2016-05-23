function init()
    % Init esta encargado de inicializar el programa
    % en primera estancia segmenta un conjunto de aprendizaje que consta 
    % de una matriz con numeros de la misma clase
    % como segunda estancia guarda dichos segmentos en las carpetas de
    % clases.
    % Por ultimo corre la funcion (memoria) para finalizar el aprendizaje.
    delete('clases.mat')
    delete('atributos.mat')
    for i = 1:5 
        disp(['Segmentando training set: ' num2str(i)]);
        mkdir (['trainingSet/rep/'  num2str(i)]);
        % segmenta elementos del conjunto de entramiento
        img_act = imread(['trainingSet/' num2str(i) '.jpg']);
        segmentos = segmentacion(img_act);
        % guarda los segmentos
        numObj = length(segmentos);
        for k = 1 : numObj        
            imwrite(segmentos(k).image,['trainingSet/rep/' num2str(i) '/' num2str(i) '_' num2str(k,'%03d') '.png']); 
        end
    end
    memoria
end