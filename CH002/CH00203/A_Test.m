classdef A_Test < matlab.unittest.TestCase
    methods (Test)
        function constantHasExpectedValue(testCase)
            testCase.verifyEqual(A.R, pi / 180, 'AbsTol', eps);
        end

        function convertsDegreesToRadians(testCase)
            testCase.verifyEqual(A.degreesToRadians(180), pi, ...
                'AbsTol', 1e-12);
        end

        function convertsRadiansToDegrees(testCase)
            testCase.verifyEqual(A.radiansToDegrees(pi), 180, ...
                'AbsTol', 1e-12);
        end

        function rejectsComplexAngles(testCase)
            testCase.verifyError(@() A.degreesToRadians(1i), ...
                'A:InvalidAngle');
        end

        function rejectsNonfiniteAngles(testCase)
            testCase.verifyError(@() A.radiansToDegrees(Inf), ...
                'A:InvalidAngle');
        end
    end
end
