%% Point2D - 入门版二维点（句柄类）
% 本例用于学习 classdef、properties、methods 和构造函数。
% 注意：这是 handle 类，多个变量可以引用同一个对象。

classdef Point2D < handle
    properties
        x = 0
        y = 0
    end

    methods
        function obj = Point2D(x0, y0)
            % Point2D() 创建原点；Point2D(x, y) 创建指定坐标的点。
            if nargin >= 1
                obj.x = x0;
            end
            if nargin >= 2
                obj.y = y0;
            end
        end

        function r = magnitude(obj)
            % 返回点到原点的距离。
            r = hypot(obj.x, obj.y);
        end

        function d = distanceTo(obj, other)
            % 返回当前点到另一个 Point2D 对象的距离。
            if ~isa(other, 'Point2D')
                error('Point2D:InvalidInput', ...
                    'other 必须是 Point2D 对象。');
            end
            d = hypot(obj.x - other.x, obj.y - other.y);
        end

        function translate(obj, dx, dy)
            % 原地平移；由于 Point2D 是 handle 类，调用后对象自身改变。
            obj.x = obj.x + dx;
            obj.y = obj.y + dy;
        end
    end
end
