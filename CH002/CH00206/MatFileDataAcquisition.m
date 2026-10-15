classdef MatFileDataAcquisition
    %MATFILEDATAACQUISITION Reads a named variable from a MAT-file.
    % This adapter is useful for replaying recorded sensor samples without
    % connecting to hardware. Data validation remains in DataAcquisitionModel.

    properties (SetAccess = private)
        filePath
        variableName
    end

    methods
        function obj = MatFileDataAcquisition(filePath, variableName)
            if nargin ~= 2 || ...
                    ~(ischar(filePath) || (isstring(filePath) && isscalar(filePath))) || ...
                    strlength(string(filePath)) == 0
                error('MatFileDataAcquisition:InvalidFilePath', ...
                    'filePath 必须是非空字符向量或字符串标量。');
            end
            if ~(ischar(variableName) || (isstring(variableName) && isscalar(variableName))) || ...
                    strlength(string(variableName)) == 0 || ...
                    ~isvarname(char(variableName))
                error('MatFileDataAcquisition:InvalidVariableName', ...
                    'variableName 必须是有效的 MATLAB 变量名。');
            end

            filePath = char(filePath);
            if exist(filePath, 'file') ~= 2
                error('MatFileDataAcquisition:FileNotFound', ...
                    '找不到 MAT 文件：%s', filePath);
            end

            obj.filePath = filePath;
            obj.variableName = char(variableName);
        end

        function values = read(obj)
            if exist(obj.filePath, 'file') ~= 2
                error('MatFileDataAcquisition:FileNotFound', ...
                    'MAT 文件已不存在：%s', obj.filePath);
            end

            loaded = load(obj.filePath, obj.variableName);
            if ~isfield(loaded, obj.variableName)
                error('MatFileDataAcquisition:VariableNotFound', ...
                    'MAT 文件中不存在变量：%s', obj.variableName);
            end
            values = loaded.(obj.variableName);
        end
    end
end
