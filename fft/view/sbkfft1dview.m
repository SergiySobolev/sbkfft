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
    freq = str2num(get(handles.textFrequency, 'String'));
    sampFreq = str2num(get(handles.textSamplingFrequency, 'String'));  
    Ts = 1/sampFreq;  
    x = 1:Ts:3;
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
    f = str2num(get(handles.textFrequency, 'String'));
    fs = str2num(get(handles.textSamplingFrequency, 'String'));
    data = get(handles.inputFunction, 'UserData');
    x = data.x;
    y = data.y;
    samplesCount = length(y);
    nfft2 = 2^nextpow2(samplesCount);
    ff = fft(y, nfft2);
    fff = ff(1:nfft2/2);
    xfft = fs * (0 : nfft2/2 - 1) / nfft2;
    showOnAxis(handles.frequencyMagnitudeAxis, xfft, abs(fff));

function inputFunction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function doFourierTransform_Callback(hObject, eventdata, handles)
    f = str2num(get(handles.textFrequency, 'String'));
    fs = str2num(get(handles.textSamplingFrequency, 'String'));
    data = get(handles.inputFunction, 'UserData');
    x = data.x;
    y = data.y;
%     nfft2 = 2^nextpow2(length(x));
%     fft_y = fft(y, nfft2);
%     fff = fft_y(1:nfft2/2);
%     xfft = f * (0 : nfft2/2 - 1) / nfft2;
% 
%     %SbkFFT = Sbk1dFFT(y);
%     %fft_y = doFFT(SbkFFT);
%     abs_fft_y = abs(fft_y);
%     % phase_fft_y = 
%    showOnAxis(handles.frequencyMagnitudeAxis, x, fft(y));
    
    samplesCount = length(y);
    nfft2 = 2^nextpow2(samplesCount);
    ff = fft(y, nfft2);
    fff = ff(1:nfft2/2);
    xfft = fs * (0 : nfft2/2 - 1) / nfft2;
    showOnAxis(handles.frequencyMagnitudeAxis, xfft, abs(fff));   
   
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
