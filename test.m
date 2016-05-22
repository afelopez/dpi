function test()
    clc
    delete('className.mat')
    delete('trainset.mat')
    init
    createDataSet
    simpleOCR
end