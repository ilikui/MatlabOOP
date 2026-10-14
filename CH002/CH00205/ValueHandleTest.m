classdef ValueHandleTest < matlab.unittest.TestCase
    methods (Test)
        function valueClassAssignmentCreatesIndependentValue(testCase)
            a = ValueCounter(0);
            b = a;
            b = b.increment(1);

            testCase.verifyEqual(a.Count, 0);
            testCase.verifyEqual(b.Count, 1);
        end

        function handleAssignmentSharesObject(testCase)
            a = HandleCounter(0);
            b = a;
            b.increment(1);

            testCase.verifyEqual(a.Count, 1);
            testCase.verifyEqual(b.Count, 1);
            testCase.verifyTrue(a == b);
        end
    end
end
