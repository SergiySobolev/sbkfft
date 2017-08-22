classdef Sbk1dFFT   
    
   
    properties
        spatialSignal
    end
    
    methods
        function obj = Sbk1dFFT(s)
            obj.spatialSignal = s;
        end
        function r = doFFT(obj)
            N = length(obj.spatialSignal);
            r = zeros(1, N);
            for k=1:N               
                for i=1:N   
                    W = exp(-1j*2*pi/N);
                    koef = W^((i-1)*(k-1));
                    r(k) = r(k) + obj.spatialSignal(i)*koef;
                end
            end;
        end 
    end
    
end

