classdef A < handle
    % A demonstrates class-level constants and angle conversion.
    %
    % R converts degrees to radians: radians = degrees .* A.R.
    % Example: angleRad = A.degreesToRadians(90);

    properties (Constant)
        R = pi / 180
    end

    methods (Static)
        function radians = degreesToRadians(degrees)
            A.validateAngle(degrees, 'degrees');
            radians = degrees .* A.R;
        end

        function degrees = radiansToDegrees(radians)
            A.validateAngle(radians, 'radians');
            degrees = radians ./ A.R;
        end
    end

    methods (Static, Access = private)
        function validateAngle(value, name)
            if ~(isnumeric(value) && isreal(value) && ...
                    all(isfinite(value(:))))
                error('A:InvalidAngle', ...
                    '%s 必须只包含有限实数。', name);
            end
        end
    end
end
