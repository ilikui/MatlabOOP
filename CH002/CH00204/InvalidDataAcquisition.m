classdef InvalidDataAcquisition < handle
    %INVALIDDATAACQUISITION Test fixture that returns intentionally bad data.

    properties (Access = private)
        samples
    end

    methods
        function obj = InvalidDataAcquisition(samples)
            obj.samples = samples;
        end

        function values = read(obj)
            values = obj.samples;
        end
    end
end
