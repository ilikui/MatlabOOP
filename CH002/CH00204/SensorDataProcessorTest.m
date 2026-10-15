classdef SensorDataProcessorTest < matlab.unittest.TestCase
    methods (Test)
        function summarizesVector(testCase)
            summary = SensorDataProcessor.summarize([3 4 5]);

            testCase.verifyEqual(summary.count, 3);
            testCase.verifyEqual(summary.mean, 4);
            testCase.verifyEqual(summary.min, 3);
            testCase.verifyEqual(summary.max, 5);
            testCase.verifyEqual(summary.rms, sqrt(50/3), ...
                'AbsTol', 1e-12);
        end

        function acceptsColumnVector(testCase)
            summary = SensorDataProcessor.summarize([2; 6]);

            testCase.verifyEqual(summary.mean, 4);
            testCase.verifyEqual(summary.count, 2);
        end

        function rejectsInvalidInputs(testCase)
            badInputs = {[], [1 NaN], [1 Inf], [1 2i], [1 2; 3 4], 'abc'};
            for k = 1:numel(badInputs)
                testCase.verifyError( ...
                    @() SensorDataProcessor.summarize(badInputs{k}), ...
                    'SensorDataProcessor:InvalidSamples');
            end
        end
    end
end
