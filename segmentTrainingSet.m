function segmentTrainingSet()
clc
clear all
close all
    carpetaEntrenamiento ='nums';
    mkdir (['trainingSet/' carpetaEntrenamiento '/' ]);
    %% se segmentan los números
    for i = 1:5 
        disp(['Segmentando training set: ' num2str(i)]);
        mkdir (['trainingSet/' carpetaEntrenamiento '/'  num2str(i)]);        
        getSegmentsFromTrainingSet(i,carpetaEntrenamiento);
    end
    
    %% se eliminan las imagenes  "ruido"    
    %Se obtiene la lista de clases
    dirList = dir(['trainingSet/' carpetaEntrenamiento]);    
    for ndir=1:length(dirList)
        if ~(strcmp(dirList(ndir).name, '.') || strcmp(dirList(ndir).name, '..'))
            if dirList(ndir).isdir == 1,
                disp(['-Limpiando training set: ' dirList(ndir).name]);        

                % se obtiene la lista de imagenes de cada clase
                imageList = dir(['trainingSet/' carpetaEntrenamiento '/' dirList(ndir).name '/*.png']);
                area = [];
                cont = 1;                
                % se obtiene la metrica que nos servirá para eliminar las
                % imágenes diferentes a las esperadas,área
                for nImage=1:length(imageList)
                    %se obtiene la imagen actual
                    currentImage = imread(['trainingSet/' carpetaEntrenamiento '/' dirList(ndir).name '/' imageList(nImage).name]);
                    %se halla area de la letra
                    area(cont,1) = sum(sum(currentImage));
                    cont = cont + 1;                    
                end
                %se establecen umbrales
                threshold_low = mean(area) - std(area);
                threshold_high = mean(area) + std(area);
                
                %se eliminan imagenes basura
                for nImage=1:length(imageList)
                    %se obtiene la imagen actual
                    currentImage = imread(['trainingSet/' carpetaEntrenamiento '/' dirList(ndir).name '/' imageList(nImage).name]);
                    %se halla area de la letra
                    area_current = sum(sum(currentImage));
                    % se elimina si está afuera de los límites
                    if area_current < threshold_low
                        delete(['trainingSet/' carpetaEntrenamiento '/' dirList(ndir).name '/' imageList(nImage).name]);
                    end
                    if area_current > threshold_high
                        delete(['trainingSet/' carpetaEntrenamiento '/' dirList(ndir).name '/' imageList(nImage).name]);
                    end
                end
                
            end
        end
    end 
end
