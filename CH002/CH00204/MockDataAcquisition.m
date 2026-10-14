classdef MockDataAcquisition < handle
    % Deterministic sample source for demos and unit tests.

    properties (Access = private)
        samples
        readCount = 0
    end

    methods
        function obj = MockDataAcquisition(samples)
            if nargin < 1
                samples = [1 2 3];
            end
            if ~(isnumeric(samples) && isreal(samples) && ...
                    isvector(samples) && ~isempty(samples) && ...
                    all(isfinite(samples(:))))
                error('MockDataAcquisition:InvalidSamples', ...
                    'samples 必须是非空有限实数向量。');
            end
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
