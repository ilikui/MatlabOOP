%% Point2D - 封装版二维点（句柄类）
% 在入门版基础上加入输入检查、受控属性和边界条件处理。

classdef Point2D < handle
    properties (SetAccess = private)
        x
        y
    end

    methods
        function obj = Point2D(x0, y0)
            % 必须提供两个有限实数标量。
            if nargin ~= 2
                error('Point2D:InvalidArgumentCount', ...
                    '构造函数需要 x 和 y 两个参数。');
            end
            obj.validateCoordinate(x0, 'x');
            obj.validateCoordinate(y0, 'y');
            obj.x = double(x0);
            obj.y = double(y0);
        end

        function r = magnitude(obj)
            r = hypot(obj.x, obj.y);
        end

        function d = distanceTo(obj, other)
            if ~isa(other, 'Point2D') || ~isscalar(other)
                error('Point2D:InvalidInput', ...
                    'other 必须是标量 Point2D 对象。');
            end
            d = hypot(obj.x - other.x, obj.y - other.y);
        end

        function moveBy(obj, dx, dy)
            % 通过方法修改坐标，避免外部直接写入属性。
            obj.validateCoordinate(dx, 'dx');
            obj.validateCoordinate(dy, 'dy');
            obj.x = obj.x + double(dx);
            obj.y = obj.y + double(dy);
        end

        function normalize(obj)
            % 将向量归一化为单位长度；原点没有定义方向，明确报错。
            r = obj.magnitude();
            if r == 0
                error('Point2D:ZeroVector', ...
                    '原点向量不能归一化。');
            end
            obj.x = obj.x / r;
            obj.y = obj.y / r;
        end
    end

    methods (Static, Access = private)
        function validateCoordinate(value, name)
            if ~(isnumeric(value) && isreal(value) && isscalar(value) ...
                    && isfinite(value))
                error('Point2D:InvalidCoordinate', ...
                    '%s 必须是有限实数标量。', name);
            end
        end
    end
end
