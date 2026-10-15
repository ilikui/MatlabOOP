classdef SensorPipelineTest < matlab.unittest.TestCase
    methods (Test)
        function runProducesSummaryAndTimestamps(testCase)
            model = DataAcquisitionModel(MockDataAcquisition([2 4 6]));
            pipeline = SensorPipeline(model);
            result = pipeline.run();
            testCase.verifyEqual(result.samples, [2 4 6]);
            testCase.verifyEqual(result.summary.mean, 4);
            testCase.verifyEqual(pipeline.status, 'completed');
            testCase.verifyEqual(pipeline.runCount, 1);
            testCase.verifyNotEmpty(pipeline.lastStartedAt);
            testCase.verifyNotEmpty(pipeline.lastCompletedAt);
        end

        function failureSetsStatusAndKeepsLastGoodResult(testCase)
            model = DataAcquisitionModel(InvalidDataAcquisition([1 NaN]));
            pipeline = SensorPipeline(model);
            testCase.verifyError(@() pipeline.run(), ...
                'DataAcquisitionModel:InvalidSamples');
            testCase.verifyEqual(pipeline.status, 'error');
            testCase.verifyNotEmpty(pipeline.lastError);
            testCase.verifyEqual(pipeline.runCount, 0);
            testCase.verifyEmpty(fieldnames(pipeline.lastResult));
        end

        function rejectsInvalidModel(testCase)
            testCase.verifyError(@() SensorPipeline(17), ...
                'SensorPipeline:InvalidModel');
        end
    end
end
