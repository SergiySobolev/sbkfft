classdef Sbk1dFFTTest < matlab.unittest.TestCase
    
    properties
        absTol=1.0000e-9
    end;
        
    methods (Test)
                
        function test1(testCase)
            import matlab.unittest.constraints.*;
              
            input = [2 4 -1 6];
            sbkFFT = Sbk1dFFT(input);
            actSolution = sbkFFT.doFFT();
            expSolution = fft(input);
            testCase.assertThat(actSolution, IsEqualTo(expSolution, 'Within', AbsoluteTolerance(testCase.absTol)));
                
        end
         
        function test2(testCase)
            import matlab.unittest.constraints.*;
            
            input = [7,2,11,3,3,11,2,7];
            sbkFFT = Sbk1dFFT(input);
            actSolution = sbkFFT.doFFT();
            expSolution = fft(input);
            
            testCase.assertThat(actSolution, IsEqualTo(expSolution, 'Within', AbsoluteTolerance(testCase.absTol)));
        end 
        
         function test3(testCase)
            import matlab.unittest.constraints.*;
            
            input = rand(1,1000);
            sbkFFT = Sbk1dFFT(input);
            actSolution = sbkFFT.doFFT();
            expSolution = fft(input);
            
            testCase.assertThat(actSolution, IsEqualTo(expSolution, 'Within', AbsoluteTolerance(testCase.absTol)));
        end 
        
    end   
    
end

