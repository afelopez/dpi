function test()
    clc
    delete('className.mat')
    delete('trainset.mat')
    segmentTrainingSet
    createDataSet
    simpleOCR
end