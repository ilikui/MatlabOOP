function demoDecoupledViewer()
%DEMODECOUPLEDVIEWER Demonstrate source/model/processing/view separation.
% Run from CH002/CH00204. Requires a MATLAB graphics environment.
    source = MockDataAcquisition([10 20 30 40]);
    model = DataAcquisitionModel(source);
    viewer = Viewer(model);
    cleanup = onCleanup(@() deleteIfValid(viewer)); %#ok<NASGU>
    viewer.refresh();
    samples = model.getLastData();
    summary = SensorDataProcessor.summarize(samples);
    viewer.setText(sprintf(['Samples: %s\nCount: %d\nMean: %.3f\nMin: %.3f\n' ...
        'Max: %.3f\nRMS: %.3f'], mat2str(samples), summary.count, ...
        summary.mean, summary.min, summary.max, summary.rms));
    fprintf('Last samples: %s\n', mat2str(samples));
    fprintf('Acquisitions: %d\n', model.acquisitionCount);
    fprintf('Mean: %.3f | Min: %.3f | Max: %.3f | RMS: %.3f\n', ...
        summary.mean, summary.min, summary.max, summary.rms);
end
function deleteIfValid(viewer)
    if isvalid(viewer)
        delete(viewer);
    end
end
