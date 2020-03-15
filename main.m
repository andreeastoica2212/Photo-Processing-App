function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 04-Jan-2019 21:01:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

imhello=imread('hello.png');
axes(handles.axes1);
imshow(imhello);

axes(handles.axes2);
imshow(imhello);

axes(handles.axes3);
imshow(imhello);

axes(handles.axes4);
imshow(imhello);

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_imgi.
function pushbutton_imgi_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_imgi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imgi 
[path,user]=imgetfile();
if user
    msgbox(sprintf('Error'));
    return
end

imgi=rgb2gray(imread(path));
axes(handles.axes1);
imshow(imgi);
imgi=imresize(imgi,[256 256]);
imgi=double(imgi);


% --- Executes on button press in pushbutton_wat.
function pushbutton_wat_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_wat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global imgw
[path,user]=imgetfile();
if user
    msgbox(sprintf('Error'));
    return
end

imgw=rgb2gray(imread(path));   
axes(handles.axes2);
imshow(imgw);
imgw=imresize(imgw,[256 256]);
imgw=double(imgw);


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
global str val imgi imgw Simg Wimg Wimg1 Wimg2 Wimg3

str = get(hObject,'String');
val = get(hObject,'Value');

[Simg,Wimg]=makewatermark(imgi,imgw);  

switch str{val}
    case 'Normal'
        axes(handles.axes3);
        imshow(uint8(Wimg));
    case 'Gaussian noise'  
        Wimg1=imnoise(uint8(Wimg),'gaussian');
        Wimg1=double(Wimg1);
        axes(handles.axes3);
        imshow(uint8(Wimg1));
    case 'Cropata'
        [x,y]=size(imgw);
        [Wimg2]=cropare(Wimg);
        Wimg2=imresize(Wimg2,[x,y]);
        Wimg2=double(Wimg2);
        axes(handles.axes3);
        imshow(uint8(Wimg2));
    case 'Compresie'
        [Wimg3]=compresie(Wimg);
        Wimg3=double(Wimg3);
        axes(handles.axes3);
        imshow(Wimg3);
end


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global str val imgi imgw Simg Wimg Wimg1 Wimg2 Wimg3

switch str{val}
    case 'Normal'
        [Watermark]=extragere(imgi,imgw,Simg,Wimg);  
        axes(handles.axes4);
        imshow(uint8(Watermark));
    case 'Gaussian noise'
        [Watermark]=extragere(imgi,imgw,Simg,Wimg1);  
        axes(handles.axes4);
        imshow(uint8(Watermark));
    case 'Cropata'
        [Watermark]=extragere(imgi,imgw,Simg,Wimg2);  
        axes(handles.axes4);
        imshow(uint8(Watermark));
    case 'Compresie'
        [Watermark]=extragere(imgi,imgw,Simg,Wimg3);  
        axes(handles.axes4);
        imshow(uint8(Watermark));
end
