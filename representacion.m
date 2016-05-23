function representacion()
    % carga memoria
    load('atributos.mat');load('clases.mat');    
    % clasificación KNN
    model = fitcknn(attr,clases);
    model.NumNeighbors = 5;
    [baseFileName, folder] = uigetfile('*.*', 'Elija una imagen');
    fullImageFileName = fullfile(folder, baseFileName);
    % se obtienen los segmentos de la imagen
    img_act = imread(fullImageFileName);
    segmentos = segmentacion(img_act);    
    num_seg = length(segmentos);
    % muestra la imagen
    figure; imshow(img_act); hold on; title('Imagen Original');     
    % señalamiento de número y reconocimiento    
     for k = 1:num_seg
        attr_act = atributos(segmentos(k).image);
        % predicción de imagen
        label = predict(model,attr_act);
        label_str = ntostr(label);
        rectangle('Position', segmentos(k).c_del,'EdgeColor','r','LineWidth',1.5);
        text(segmentos(k).c_del(1),segmentos(k).c_del(2)... 
            + 2.2*segmentos(k).center(1),label_str,'Color','b','FontSize',8);
     end
end
