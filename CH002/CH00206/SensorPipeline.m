classdef SensorPipeline < handle
    %SENSORPIPELINE Coordinates acquisition and pure-data processing.
    % The source is injected through DataAcquisitionModel. No GUI or
    % hardware-specific APIs are used in this orchestration layer.

    properties (SetAccess = private)
        status = 'idle'
        lastResult = struct()
        lastError = ''
        lastStartedAt = []
        lastCompletedAt = []
        runCount = 0
    end

    properties (Access = private)
        model
    end

    methods
        function obj = SensorPipeline(model)
            if nargin ~= 1 || ~isa(model, 'DataAcquisitionModel') || ~isscalar(model)
                error('SensorPipeline:InvalidModel', ...
                    'model 必须是 DataAcquisitionModel 标量对象。');
            end
            obj.model = model;
        end

        function result = run(obj)
            obj.status = 'running';
            obj.lastError = '';
            obj.lastStartedAt = datetime('now');
            try
                samples = obj.model.acquire();
                summary = SensorDataProcessor.summarize(samples);
                result = struct('samples', samples, 'summary', summary, ...
                    'startedAt', obj.lastStartedAt, 'completedAt', datetime('now'));
                obj.lastResult = result;
                obj.lastCompletedAt = result.completedAt;
                obj.runCount = obj.runCount + 1;
                obj.status = 'completed';
            catch exception
                obj.status = 'error';
                obj.lastError = sprintf('%s: %s', exception.identifier, exception.message);
                rethrow(exception);
            end
        end
    end
end
