classdef A
    % A demonstrates class-level constants.
    %
    % R is the conversion factor from degrees to radians:
    % radians = degrees .* A.R
    %
    % Example:
    %   angleRad = 90 * A.R;

    properties (Constant)
        R = pi / 180
    end

    methods (Static)
        function radians = degreesToRadians(degrees)
            validateattributes(degrees, {'numeric'}, ...
                {'real', 'finite'});
            radians = degrees .* A.R;
        end

        function degrees = radiansToDegrees(radians)
            validateattributes(radians, {'numeric'}, ...
                {'real', 'finite'});
            degrees = radians ./ A.R;
        end
    end
end
