classdef ValueCounter
    % ValueCounter demonstrates MATLAB value semantics.
    properties
        Count = 0
    end

    methods
        function obj = ValueCounter(initialValue)
            if nargin > 0
                validateattributes(initialValue, {'numeric'}, ...
                    {'scalar', 'real', 'finite'});
                obj.Count = double(initialValue);
            end
        end

        function obj = increment(obj, amount)
            if nargin < 2
                amount = 1;
            end
            validateattributes(amount, {'numeric'}, ...
                {'scalar', 'real', 'finite'});
            obj.Count = obj.Count + double(amount);
        end
    end
end
