
function simpleOcr()
    close all
    clc
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
    segments = getSegmentsFromImage(fullImageFileName,0);
    numObj = length(segments);
    %show image
    imageToTest = imread(fullImageFileName);
    figure; imshow(imageToTest); hold on;
    title('Imagen Original'); 
    
    %dibujar segmentos y 
    k = 1; 
     while k <= numObj
        if sum(sum(segments(k).image)) < 2500
            segments(k) = [];  
            numObj = numObj  - 1;
            k = k-1;
        end
        k = k+1;    
     end  
     for k = 1:numObj
        label = predictionGivenImage(model,segments(k).image);
        rectangle('Position', segments(k).bBox,'EdgeColor','r');
        text(segments(k).bBox(1),segments(k).bBox(2)... 
            + 2.2*segments(k).center(1),label,'Color','k','FontSize',10);
     end
end


function [label_str] = predictionGivenImage(model,imgTest)
    instance4test = getFeatures(imgTest);
    label = predict(model,instance4test);
    label_str = ntostr(label);
end
