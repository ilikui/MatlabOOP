function demoDecoupledViewer()
%DEMODECOUPLEDVIEWER Demonstrate UI/model/source separation.
% Run from CH002/CH00204. Requires a MATLAB graphics environment.

    source = MockDataAcquisition([10 20 30 40]);
    model = DataAcquisitionModel(source);
    viewer = Viewer(model);

    cleanup = onCleanup(@() deleteIfValid(viewer)); %#ok<NASGU>
    viewer.refresh();

    fprintf('Last samples: %s\n', mat2str(model.getLastData()));
    fprintf('Acquisitions: %d\n', model.acquisitionCount);
end

function deleteIfValid(viewer)
    if isvalid(viewer)
        delete(viewer);
    end
end
