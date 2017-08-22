classdef Sbk1dFFT   
    
   
    properties
        spatialSignal
    end
    
    methods
        function obj = Sbk1dFFT(s)
            obj.spatialSignal = s;
        end
        function r = doFFT(obj)
            l = length(obj.spatialSignal);
            r = zeros(1, l);
            for k=1:l               
                for j=1:l   
                    koef = (-i)^((k-1)*(j-1));
                    r(k) = r(k) + obj.spatialSignal(j)*koef;
                end
            end;
        end 
    end
    
end

