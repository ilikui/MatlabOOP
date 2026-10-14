classdef DataAcquisitionModel < handle
    % Coordinates acquisition and stores the latest sample vector.
    % Source is injected; it must be an object implementing read().

    properties (SetAccess = private)
        lastData = []
        acquisitionCount = 0
    end

    properties (Access = private)
        source
    end

    methods
        function obj = DataAcquisitionModel(source)
            if nargin ~= 1 || ~isobject(source) || ...
                    ~isscalar(source) || ~ismethod(source, 'read')
                error('DataAcquisitionModel:InvalidSource', ...
                    'source 必须是实现 read() 的标量对象。');
            end
            obj.source = source;
        end

        function values = acquire(obj)
            values = obj.source.read();
            if ~(isnumeric(values) && isreal(values) && ...
                    isvector(values) && all(isfinite(values(:))))
                error('DataAcquisitionModel:InvalidSamples', ...
                    '数据源必须返回有限实数数值向量。');
            end
            values = double(values(:).');
            obj.lastData = values;
            obj.acquisitionCount = obj.acquisitionCount + 1;
        end

        function values = getLastData(obj)
            values = obj.lastData;
        end
    end
end
