function memoria()
    %%Se obtiene la lista de clases
    list_dir = dir('trainingSet/rep');
    cont = 1; 
    attr = []; 
    clases = [];
    for ndir=1:length(list_dir)
        if ~(strcmp(list_dir(ndir).name, '.') || strcmp(list_dir(ndir).name, '..'))
            if list_dir(ndir).isdir == 1,
                % se obtiene la lista de las imagenes de cada clase
                img_list = dir(['trainingSet/rep/' list_dir(ndir).name '/*.png']);
                disp(['Procesando clase: ' list_dir(ndir).name]);                
                for nImage=1:length(img_list)
                    img_act = imread(['trainingSet/rep/' list_dir(ndir).name '/' img_list(nImage).name]);
                    % nombre de la clase
                    clases(cont,1) = str2num(list_dir(ndir).name);                
                    % se obtienen los atributos de la imagen actual
                    attr = cat(1, attr, atributos(img_act));
                    cont = cont + 1;                    
                end                
            end
        end
    end     
    % guarda memoria
    save('atributos.mat','attr');
    save('clases.mat','clases');
end