function representacion()
    %% 1. carga memoria
    load('atributos.mat');load('clases.mat');    
    %% 2. clasificación KNN
    model = fitcknn(attr,clases);
    model.NumNeighbors = 5;
    %% 3. predicción de imagen completa   
    % se obtienen los segmentos de la imagen
    [baseFileName, folder] = uigetfile('*.*', 'Elija una imagen');
    fullImageFileName = fullfile(folder, baseFileName);
    img_act = imread(fullImageFileName);
    segmentos = segmentacion(img_act);    
    num_seg = length(segmentos);
    %muestra la imagen
    imagen = imread(fullImageFileName);
    figure; imshow(imagen); hold on; title('Imagen Original');     
    %señalamiento de número y reconocimiento
     for k = 1:num_seg
        instance4test = atributos(segmentos(k).image);
        label = predict(model,instance4test);
        label_str = ntostr(label);
        rectangle('Position', segmentos(k).bBox,'EdgeColor','r');
        text(segmentos(k).bBox(1),segmentos(k).bBox(2)... 
            + 2.2*segmentos(k).center(1),label_str,'Color','k','FontSize',8);
     end
end
