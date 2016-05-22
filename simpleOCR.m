function simpleOcr()
    %% load dataset
    load('trainset.mat');
    load('className.mat');    
    %% clasificación KNN
    model = fitcknn(trainset,className);
    model.NumNeighbors = 5;
    %% predicción de imagen completa   
    % se obtienen los segmentos de la imagen
    [baseFileName, folder] = uigetfile('*.*', 'Elija una imagen');
    fullImageFileName = fullfile(folder, baseFileName);
    img_act = imread(fullImageFileName);
    segmentos = segmentacion(img_act);
    
    numObj = length(segmentos);
    %show image
    imageToTest = imread(fullImageFileName);
    figure; imshow(imageToTest); hold on;
    title('Imagen Original');     
    %dibujar segmentos y 
     for k = 1:numObj
        label = predictionGivenImage(model,segmentos(k).image);
        rectangle('Position', segmentos(k).bBox,'EdgeColor','r');
        text(segmentos(k).bBox(1),segmentos(k).bBox(2)... 
            + 2.2*segmentos(k).center(1),label,'Color','k','FontSize',10);
     end
end
function [label_str] = predictionGivenImage(model,imgTest)
    instance4test = atributos(imgTest);
    label = predict(model,instance4test);
    label_str = ntostr(label);
end