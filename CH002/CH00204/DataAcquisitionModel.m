classdef DataAcquisitionModel < handle
    % DataAcquisitionModel coordinates acquisition and stores the last data.
    % The source is injected, so the model can use mock or real hardware.
    % The source must implement read() and return finite numeric samples.

    properties (SetAccess = private)
        lastData = []
        acquisitionCount = 0
    end

    properties (Access = private)
        source
    end

    methods
        function obj = DataAcquisitionModel(source)
            if nargin ~= 1 || ~ismethod(source, 'read')
                error('DataAcquisitionModel:InvalidSource', ...
                    'source 必须提供 read() 方法。');
            end
            obj.source = source;
        end

        function values = acquire(obj)
            values = obj.source.read();
            validateattributes(values, {'numeric'}, ...
                {'real', 'finite', 'vector'});
            values = double(values(:).');
            obj.lastData = values;
            obj.acquisitionCount = obj.acquisitionCount + 1;
        end

        function values = getLastData(obj)
            values = obj.lastData;
        end
    end
end
