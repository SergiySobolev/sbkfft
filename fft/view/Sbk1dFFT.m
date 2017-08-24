function varargout = Sbk1dFFT(varargin)
% SBK1DFFT MATLAB code for Sbk1dFFT.fig
%      SBK1DFFT, by itself, creates a new SBK1DFFT or raises the existing
%      singleton*.
%
%      H = SBK1DFFT returns the handle to a new SBK1DFFT or the handle to
%      the existing singleton*.
%
%      SBK1DFFT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SBK1DFFT.M with the given input arguments.
%
%      SBK1DFFT('Property','Value',...) creates a new SBK1DFFT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Sbk1dFFT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Sbk1dFFT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Sbk1dFFT

% Last Modified by GUIDE v2.5 22-Aug-2017 19:38:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Sbk1dFFT_OpeningFcn, ...
                   'gui_OutputFcn',  @Sbk1dFFT_OutputFcn, ...
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


% --- Executes just before Sbk1dFFT is made visible.
function Sbk1dFFT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Sbk1dFFT (see VARARGIN)

% Choose default command line output for Sbk1dFFT
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Sbk1dFFT wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Sbk1dFFT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in inputfunctiontype.
function inputfunctiontype_Callback(hObject, eventdata, handles)
    selectedIndex = get(handles.inputfunctiontype, 'value');
    switch selectedIndex
        case 1
             x = 0:pi/30:20*pi
             y = sin(x);
             showOnAxis(handles.spatial_axes,x,y,[0,20*pi,-1.3,1.3]);
        case 2
            x = 0:pi/30:20*pi;
            y = cos(x);
            showOnAxis(handles.spatial_axes,x,y,[0,20*pi,-1.3,1.3]);
    end
       

% --- Executes during object creation, after setting all properties.
function inputfunctiontype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputfunctiontype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
function showOnAxis(axesId,x,y,bounds)
    axes(axesId);
    stem(x,y,'LineStyle','none');
    axis(bounds);


if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

