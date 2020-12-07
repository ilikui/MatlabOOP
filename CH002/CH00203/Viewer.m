classdef Viewer<handle
    
    properties
        hFig
        hEdit
    end
    
    methods
        function obj =Viewer()
            % both all is objective
            obj.hFig=figure();
            obj.hEdit =uicontrol('style','edit','parent',obj.hFig)
        end
        
    end
    
    
end
