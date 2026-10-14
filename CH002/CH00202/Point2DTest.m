classdef Point2DTest < matlab.unittest.TestCase
    % CH00202 Point2D 的回归测试。
    % 在本目录执行：runtests('Point2DTest.m')

    methods (Test)
        function constructorAndMagnitude(testCase)
            p = Point2D(3, 4);
            testCase.verifyEqual(p.x, 3);
            testCase.verifyEqual(p.y, 4);
            testCase.verifyEqual(p.magnitude(), 5, 'AbsTol', 1e-12);
        end

        function distanceBetweenPoints(testCase)
            p = Point2D(0, 0);
            q = Point2D(3, 4);
            testCase.verifyEqual(p.distanceTo(q), 5, 'AbsTol', 1e-12);
        end

        function moveByChangesCoordinates(testCase)
            p = Point2D(1, 2);
            p.moveBy(3, -1);
            testCase.verifyEqual([p.x, p.y], [4, 1]);
        end

        function normalizeProducesUnitLength(testCase)
            p = Point2D(3, 4);
            p.normalize();
            testCase.verifyEqual(p.magnitude(), 1, 'AbsTol', 1e-12);
            testCase.verifyEqual([p.x, p.y], [0.6, 0.8], 'AbsTol', 1e-12);
        end

        function normalizeRejectsZeroVector(testCase)
            p = Point2D(0, 0);
            testCase.verifyError(@() p.normalize(), 'Point2D:ZeroVector');
        end

        function constructorRejectsInvalidCoordinate(testCase)
            testCase.verifyError(@() Point2D(NaN, 1), ...
                'Point2D:InvalidCoordinate');
            testCase.verifyError(@() Point2D([1, 2], 1), ...
                'Point2D:InvalidCoordinate');
        end

        function coordinatesCannotBeSetExternally(testCase)
            p = Point2D(1, 2);
            testCase.verifyError(@() assignCoordinate(p), ...
                'MATLAB:class:SetProhibited');
        end
    end
end

function assignCoordinate(p)
p.x = 99;
end
