classdef Sbk1dFFTTest < matlab.unittest.TestCase
    methods (Test)
        function test1(testCase)
            input = [2 4 -1 6];
            sbkFFT = Sbk1dFFT(input);
            actSolution = sbkFFT.doFFT();
            expSolution = fft(input);
            testCase.verifyEqual(actSolution,expSolution)
        end 
    end   
    
end

