function varargout = sbkfft1dview(varargin)
% SBKFFT1DVIEW MATLAB code for sbkfft1dview.fig
%      SBKFFT1DVIEW, by itself, creates a new SBKFFT1DVIEW or raises the existing
%      singleton*.
%
%      H = SBKFFT1DVIEW returns the handle to a new SBKFFT1DVIEW or the handle to
%      the existing singleton*.
%
%      SBKFFT1DVIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SBKFFT1DVIEW.M with the given input arguments.
%
%      SBKFFT1DVIEW('Property','Value',...) creates a new SBKFFT1DVIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sbkfft1dview_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sbkfft1dview_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sbkfft1dview

% Last Modified by GUIDE v2.5 29-Aug-2017 23:56:03

% Begin initialization code - DO NOT EDIT
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
% End initialization code - DO NOT EDIT


% --- Executes just before sbkfft1dview is made visible.
function sbkfft1dview_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sbkfft1dview (see VARARGIN)

% Choose default command line output for sbkfft1dview
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sbkfft1dview wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sbkfft1dview_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in inputFunction.
function inputFunction_Callback(hObject, eventdata, handles)
    selectedIndex = get(handles.inputFunction, 'value');
    f = str2num(get(handles.textFrequency, 'String'));
    Fs = str2num(get(handles.textSamplingFrequency, 'String'));
    Ts = 1/Fs;
    N = str2num(get(handles.samplesCount, 'String')); 
    x = 1:Ts:5-Ts;
    switch selectedIndex
        case 1            
             y = sin(2*pi*f*x);
        case 2             
             y = cos(2*pi*f*x);            
        case 3             
             y = cos(2*pi*f*(x+1));
    end
    showOnAxis(handles.spatialAxis,x,y);
    set(handles.inputFunction,'UserData', struct('x',x,'y',y)); 
    guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function inputFunction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputFunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in doFourierTransform.
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
% hObject    handle to textFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textFrequency as text
%        str2double(get(hObject,'String')) returns contents of textFrequency as a double


% --- Executes during object creation, after setting all properties.
function textFrequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textSamplingFrequency_Callback(hObject, eventdata, handles)
% hObject    handle to textSamplingFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textSamplingFrequency as text
%        str2double(get(hObject,'String')) returns contents of textSamplingFrequency as a double


% --- Executes during object creation, after setting all properties.
function textSamplingFrequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textSamplingFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function samplesCount_Callback(hObject, eventdata, handles)
% hObject    handle to samplesCount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of samplesCount as text
%        str2double(get(hObject,'String')) returns contents of samplesCount as a double


% --- Executes during object creation, after setting all properties.
function samplesCount_CreateFcn(hObject, eventdata, handles)
% hObject    handle to samplesCount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
