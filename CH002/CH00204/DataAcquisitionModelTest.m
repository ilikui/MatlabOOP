classdef DataAcquisitionModelTest < matlab.unittest.TestCase
    methods (Test)
        function acquiresAndStoresData(testCase)
            source = MockDataAcquisition([1 2 3]);
            model = DataAcquisitionModel(source);
            actual = model.acquire();
            testCase.verifyEqual(actual, [1 2 3]);
            testCase.verifyEqual(model.getLastData(), [1 2 3]);
            testCase.verifyEqual(model.acquisitionCount, 1);
            testCase.verifyEqual(source.getReadCount(), 1);
        end
        function repeatedAcquireUpdatesCount(testCase)
            source = MockDataAcquisition([4 5]);
            model = DataAcquisitionModel(source);
            model.acquire(); model.acquire();
            testCase.verifyEqual(model.acquisitionCount, 2);
            testCase.verifyEqual(source.getReadCount(), 2);
        end
        function rejectsInvalidSource(testCase)
            testCase.verifyError(@() DataAcquisitionModel(42), 'DataAcquisitionModel:InvalidSource');
        end
        function mockRejectsInvalidSamples(testCase)
            testCase.verifyError(@() MockDataAcquisition([1 NaN]), 'MockDataAcquisition:InvalidSamples');
        end
        function rejectsNaNFromSource(testCase)
            model = DataAcquisitionModel(InvalidDataAcquisition([1 NaN]));
            testCase.verifyError(@() model.acquire(), 'DataAcquisitionModel:InvalidSamples');
            testCase.verifyEqual(model.acquisitionCount, 0);
            testCase.verifyEmpty(model.getLastData());
        end
        function rejectsComplexSamplesFromSource(testCase)
            model = DataAcquisitionModel(InvalidDataAcquisition([1 2i]));
            testCase.verifyError(@() model.acquire(), 'DataAcquisitionModel:InvalidSamples');
        end
        function rejectsMatrixFromSource(testCase)
            model = DataAcquisitionModel(InvalidDataAcquisition([1 2; 3 4]));
            testCase.verifyError(@() model.acquire(), 'DataAcquisitionModel:InvalidSamples');
        end
    end
end
