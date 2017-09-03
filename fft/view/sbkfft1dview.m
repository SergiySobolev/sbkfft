function varargout = sbkfft1dview(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sbkfft1dview_OpeningFcn, ...
                   'gui_OutputFcn',  @sbkfft1dview_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function sbkfft1dview_OpeningFcn(hObject, ~, handles, varargin)
    handles.output = hObject;
    guidata(hObject, handles);
    drawSpatial(hObject, handles); 
    drawFrequency(hObject, handles);

function varargout = sbkfft1dview_OutputFcn(~, ~, handles) 
    varargout{1} = handles.output;

function inputFunction_Callback(hObject, eventdata, handles)   
    drawSpatial(hObject, handles); 
    drawFrequency(hObject, handles);

function drawSpatial(hObject, handles)   
    funcType = get(handles.inputFunction, 'value');
    freq = round(str2double(get(handles.textFrequency, 'String')));
    sampFreq = 32*freq;  
    Ts = 1/sampFreq;  
    x = -2:Ts:2;
    switch funcType
        case 1            
             y = sin(2*pi*freq*x);
        case 2             
             y = cos(2*pi*freq*x);            
        case 3             
             y = cos(2*pi*freq*(x+1));
    end
    showOnAxis(handles.spatialAxis,x,y);
    set(handles.inputFunction,'UserData', struct('x',x,'y',y)); 
    guidata(hObject, handles);
    
function drawFrequency(~, handles)   
    drawMagnitude(handles) 
    drawPhase(handles);
    
function drawMagnitude(handles) 
    fs = 32*str2double(get(handles.textFrequency, 'String'));
    data = get(handles.inputFunction, 'UserData'); 
    y = data.y;
    samplesCount = length(y);
    nfft2 = 2^(nextpow2(samplesCount)-1);
    ff = fft(y, nfft2);
    fff = ff(1:nfft2/2);
    xfft = fs * (0 : nfft2/2 - 1) / nfft2;
    showOnAxis(handles.frequencyMagnitudeAxis, xfft, abs(fff));
    axes(handles.frequencyMagnitudeAxis);
    plot(xfft,abs(fff));  
    axis([0,530,min(abs(fff)),1.1*max(abs(fff))]);  

    
function drawPhase(handles)
    fs = 32*str2double(get(handles.textFrequency, 'String'));
    data = get(handles.inputFunction, 'UserData'); 
    y = data.y;
    N = 2^(nextpow2(length(y))-1);
    df=fs/N; %frequency resolution
    sampleIndex = -N/2:N/2-1; %ordered index for FFT plot
    f=sampleIndex*df;
    X = 1/N*fftshift(fft(y,N));
    X2 = X; 
    threshold = max(abs(X))/10000; %tolerance threshold
    X2(abs(X)<threshold) = 0;
    %phase=atan2(imag(X2),real(X2))*180/pi;
    phase=angle(X2);
    axes(handles.frequencyPhaseAxis);
    plot(f,phase);   

function inputFunction_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function doFourierTransform_Callback(hObject, eventdata, handles)
    drawFrequency(hObject, handles);  
   
function showOnAxis(axesId,x,y)
    axes(axesId);
    plot(x,y);
   % axis(bounds);  
   
function textFrequency_Callback(hObject, eventdata, handles)

function textFrequency_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
function textSamplingFrequency_Callback(hObject, eventdata, handles)

function textSamplingFrequency_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function samplesCount_Callback(hObject, eventdata, handles)

function samplesCount_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function frequencySlider_Callback(hObject, ~, handles)
    freq = round(get(hObject, 'Value'));
    set(handles.textFrequency, 'string', freq);
    drawSpatial(hObject, handles);
    drawFrequency(hObject, handles);


function frequencySlider_CreateFcn(hObject, ~, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end

function frequencySlider_ButtonDownFcn(hObject, ~, handles)
    freq = round(get(hObject, 'Value'));
    set(handles.textFrequency, 'string', freq);
    drawSpatial(hObject, handles);
    drawFrequency(hObject, handles);
