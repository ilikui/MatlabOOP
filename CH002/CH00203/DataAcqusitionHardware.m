classdef DataAcqusitionHardware < handle
    % DataAcqusitionHardware is a placeholder for hardware-specific code.
    %
    % This class currently exposes legacy buffer-size constants only. It
    % does not connect to a device and does not perform real acquisition.
    % Keep the historical class name to avoid breaking existing examples.

    properties (Constant)
        % Legacy configured input buffer size (unit depends on device API).
        Input_BufSize = int32(6533)

        % Legacy configured onboard buffer size (unit depends on device API).
        Input_OnboardBufsize = int32(8970)
    end

    methods
        function obj = DataAcqusitionHardware() %#ok<MANU>
            % No hardware is opened by this placeholder constructor.
        end
    end
end
