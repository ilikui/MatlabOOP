function result = demoSensorPipeline()
%DEMOSENSORPIPELINE Run an end-to-end non-GUI acquisition example.
% Run from CH002/CH00206, with CH002/CH00204 on the MATLAB path.

    source = MockDataAcquisition([12.1 12.4 12.3 12.8 12.5]);
    model = DataAcquisitionModel(source);
    pipeline = SensorPipeline(model);
    result = pipeline.run();

    fprintf('Pipeline status: %s\n', pipeline.status);
    fprintf('Samples: %s\n', mat2str(result.samples));
    fprintf('Count: %d, mean: %.3f, min: %.3f, max: %.3f, RMS: %.3f\n', ...
        result.summary.count, result.summary.mean, result.summary.min, ...
        result.summary.max, result.summary.rms);
    fprintf('Started: %s\nCompleted: %s\n', ...
        char(result.startedAt), char(result.completedAt));
end
