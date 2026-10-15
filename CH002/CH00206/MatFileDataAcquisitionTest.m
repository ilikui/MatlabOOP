classdef MatFileDataAcquisitionTest < matlab.unittest.TestCase
    methods (Test)
        function readsNamedVariable(testCase)
            filePath = [tempname '.mat'];
            cleanup = onCleanup(@() deleteIfPresent(filePath)); %#ok<NASGU>
            samples = [10 20 30]; %#ok<NASGU>
            other = 99; %#ok<NASGU>
            save(filePath, 'samples', 'other');

            source = MatFileDataAcquisition(filePath, 'samples');
            testCase.verifyEqual(source.read(), [10 20 30]);
        end

        function missingVariableRaisesClearError(testCase)
            filePath = [tempname '.mat'];
            cleanup = onCleanup(@() deleteIfPresent(filePath)); %#ok<NASGU>
            samples = [1 2 3]; %#ok<NASGU>
            save(filePath, 'samples');

            source = MatFileDataAcquisition(filePath, 'missingSamples');
            testCase.verifyError(@() source.read(), ...
                'MatFileDataAcquisition:VariableNotFound');
        end

        function missingFileIsRejected(testCase)
            testCase.verifyError(@() MatFileDataAcquisition( ...
                [tempname '.mat'], 'samples'), ...
                'MatFileDataAcquisition:FileNotFound');
        end

        function invalidVariableNameIsRejected(testCase)
            filePath = [tempname '.mat'];
            cleanup = onCleanup(@() deleteIfPresent(filePath)); %#ok<NASGU>
            samples = 1; %#ok<NASGU>
            save(filePath, 'samples');

            testCase.verifyError(@() MatFileDataAcquisition(filePath, 'not a name'), ...
                'MatFileDataAcquisition:InvalidVariableName');
        end
    end
end

function deleteIfPresent(filePath)
if exist(filePath, 'file') == 2
    delete(filePath);
end
end
