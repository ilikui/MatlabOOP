classdef MockDataAcquisition < handle
    % MockDataAcquisition returns predefined numeric samples for demos/tests.

    properties (Access = private)
        samples
        readCount = 0
    end

    methods
        function obj = MockDataAcquisition(samples)
            if nargin < 1
                samples = [1 2 3];
            end
            validateattributes(samples, {'numeric'}, ...
                {'real', 'finite', 'vector', 'nonempty'});
            obj.samples = double(samples(:).');
        end

        function values = read(obj)
            obj.readCount = obj.readCount + 1;
            values = obj.samples;
        end

        function count = getReadCount(obj)
            count = obj.readCount;
        end
    end
end
