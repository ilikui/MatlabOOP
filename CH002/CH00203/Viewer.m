classdef Viewer < handle
    % Viewer is a small legacy figure/uicontrol demonstration.
    % It owns the GUI handles and exposes text through methods.
    %
    % Example:
    %   v = Viewer();
    %   v.setText('Hello MATLAB OOP');
    %   disp(v.getText());
    %   delete(v);

    properties (Access = private)
        hFig
        hEdit
    end

    methods
        function obj = Viewer()
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

        function setText(obj, value)
            obj.assertAlive();
            if isstring(value)
                value = char(join(value, newline));
            end
            if ~(ischar(value) && (isrow(value) || isempty(value)))
                error('Viewer:InvalidText', ...
                    '文本必须是字符向量或 string 标量。');
            end
            set(obj.hEdit, 'String', value);
        end

        function value = getText(obj)
            obj.assertAlive();
            value = get(obj.hEdit, 'String');
            if iscell(value)
                value = strjoin(value, newline);
            end
        end

        function delete(obj)
            if ~isempty(obj.hFig) && isgraphics(obj.hFig)
                set(obj.hFig, 'CloseRequestFcn', '');
                delete(obj.hFig);
            end
            obj.hFig = [];
            obj.hEdit = [];
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
