classdef Viewer < handle
    % Viewer presents text from a model and keeps GUI details private.
    %
    % Backward compatible:
    %   v = Viewer();
    %
    % Decoupled usage:
    %   source = MockDataAcquisition([1 2 3]);
    %   model = DataAcquisitionModel(source);
    %   v = Viewer(model);
    %   v.refresh();
    %   delete(v);

    properties (Access = private)
        hFig
        hEdit
        model
    end

    properties (Dependent)
        text
    end

    methods
        function obj = Viewer(model)
            if nargin < 1
                model = [];
            elseif ~(isempty(model) || isa(model, 'DataAcquisitionModel'))
                error('Viewer:InvalidModel', ...
                    'model 必须是 DataAcquisitionModel 对象或空值。');
            end
            obj.model = model;

            obj.hFig = figure( ...
                'Name', 'MATLAB OOP Viewer', ...
                'NumberTitle', 'off', ...
                'MenuBar', 'none', ...
                'HandleVisibility', 'callback', ...
                'Tag', 'MatlabOOPViewer');

            obj.hEdit = uicontrol( ...
                'Style', 'edit', ...
                'Parent', obj.hFig, ...
                'Units', 'normalized', ...
                'Position', [0.05 0.1 0.9 0.8], ...
                'HorizontalAlignment', 'left', ...
                'Max', 2, ...
                'Min', 0, ...
                'String', '');

            set(obj.hFig, 'CloseRequestFcn', @(~, ~) delete(obj));
        end

        function value = get.text(obj)
            obj.assertAlive();
            value = get(obj.hEdit, 'String');
            if iscell(value)
                value = strjoin(value, newline);
            end
        end

        function set.text(obj, value)
            obj.setText(value);
        end

        function setText(obj, value)
            obj.assertAlive();
            if isstring(value) && isscalar(value)
                value = char(value);
            end
            if ~(ischar(value) && (isrow(value) || isempty(value)))
                error('Viewer:InvalidText', ...
                    '文本必须是字符向量或 string 标量。');
            end
            set(obj.hEdit, 'String', value);
        end

        function refresh(obj)
            % UI only renders the model's output; it does not read hardware.
            obj.assertAlive();
            if isempty(obj.model)
                error('Viewer:MissingModel', ...
                    '未注入数据模型，无法刷新采集结果。');
            end
            values = obj.model.acquire();
            obj.setText(mat2str(values));
        end

        function delete(obj)
            if ~isempty(obj.hFig) && isgraphics(obj.hFig)
                set(obj.hFig, 'CloseRequestFcn', '');
                delete(obj.hFig);
            end
            obj.hFig = [];
            obj.hEdit = [];
            obj.model = [];
        end
    end

    methods (Access = private)
        function assertAlive(obj)
            if isempty(obj.hFig) || ~isgraphics(obj.hFig) || ...
                    isempty(obj.hEdit) || ~isgraphics(obj.hEdit)
                error('Viewer:Closed', 'Viewer 窗口已关闭。');
            end
        end
    end
end
