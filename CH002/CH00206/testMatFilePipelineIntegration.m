function result = testMatFilePipelineIntegration()
%TESTMATFILEPIPELINEINTEGRATION Run the MAT-file source through the pipeline.
% Add CH002/CH00204 and CH002/CH00206 to the MATLAB path before calling.

filePath = [tempname '.mat'];
cleanup = onCleanup(@() deleteIfPresent(filePath)); %#ok<NASGU>
samples = [21.5 22.0 22.5 23.0]; %#ok<NASGU>
save(filePath, 'samples');

source = MatFileDataAcquisition(filePath, 'samples');
model = DataAcquisitionModel(source);
pipeline = SensorPipeline(model);
result = pipeline.run();

assert(isequal(result.samples, [21.5 22.0 22.5 23.0]), ...
    '采集结果与 MAT 文件中的数据不一致。');
assert(result.summary.count == 4, '样本数统计不正确。');
assert(result.summary.mean == 22.25, '均值统计不正确。');
assert(strcmp(pipeline.status, 'completed'), '流水线未正常完成。');
end

function deleteIfPresent(filePath)
if exist(filePath, 'file') == 2
    delete(filePath);
end
end
