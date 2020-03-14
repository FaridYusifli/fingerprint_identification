function varargout = fingerprintGUI(varargin)
% FINGERPRINTGUI MATLAB code for fingerprintGUI.fig
%      FINGERPRINTGUI, by itself, creates a new FINGERPRINTGUI or raises the existing
%      singleton*.
%
%      H = FINGERPRINTGUI returns the handle to a new FINGERPRINTGUI or the handle to
%      the existing singleton*.
%
%      FINGERPRINTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINGERPRINTGUI.M with the given input arguments.
%
%      FINGERPRINTGUI('Property','Value',...) creates a new FINGERPRINTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fingerprintGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fingerprintGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fingerprintGUI

% Last Modified by GUIDE v2.5 07-Jul-2017 18:04:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fingerprintGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @fingerprintGUI_OutputFcn, ...
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


% --- Executes just before fingerprintGUI is made visible.
function fingerprintGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fingerprintGUI (see VARARGIN)

% Choose default command line output for fingerprintGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fingerprintGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fingerprintGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName, PathName] = uigetfile({'*.tif';'*png';'*jpg'},'File Selector');
set(handles.edit1,'String',FileName);
%% BUILD FINGERPRINT TEMPLATE DATABASE
% build_db(9,8);        %THIS WILL TAKE ABOUT 30 MINUTES
load('db.mat');

%% EXTRACT FEATURES FROM AN ARBITRARY FINGERPRINT
filename=FileName;
img = imread(filename);
if ndims(img) == 3; img = rgb2gray(img); end  % Color Images
disp(['Extracting features from ' filename ' ...']);
ffnew=ext_finger(img,1);

%% FOR EACH FINGERPRINT TEMPLATE, CALCULATE MATCHING SCORE IN COMPARISION WITH FIRST ONE
S=zeros(72,1);
for i=1:72
    second=['10' num2str(fix((i-1)/8)+1) '' num2str(mod(i-1,8)+1)];
    fprintf(['Comparing ' filename ' and ' second '...  Similarity = ']);
    S(i)=match(ffnew,ff{i});
    fprintf([num2str(S(i)) '\n']);
    drawnow
end
%% OFFER MATCHED FINGERPRINTS
MFP=find(S>0.51);
sz=size(MFP);


for n=1:sz
    if mod(MFP(n),8)>0
        result(n)= 1000+mod(MFP(n),8)+(floor(MFP(n)/8)+1)*10;
    else
        result(n)= 1000+ (fix(MFP(n)/8)+1)*10-2;
    end
        
    
    
end

set(handles.edit3,'String',result);






% --- Executes on key press with focus on pushbutton1 and none of its controls.
function pushbutton1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)




function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileNameSingle1, PathNameSingle1] = uigetfile({'*.tif';'*png';'*jpg'},'File Selector');
set(handles.edit4,'String',FileNameSingle1);
hObject.UserData = FileNameSingle1;


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileNameSingle2, PathNameSingle2]= uigetfile({'*.tif';'*png';'*jpg'},'File Selector');
set(handles.edit5,'String',FileNameSingle2);
%strValue=get(handles.edit6,'String');
%numValue=str2num(strValue);
h = findobj('Tag','pushbutton3');
FileNameSingle1=h.UserData;


%% EXTRACT FEATURES FROM AN ARBITRARY FINGERPRINT
filename=FileNameSingle1;
img = imread(filename);
if ndims(img) == 3; img = rgb2gray(img); end  % Color Images
disp(['Extracting features from ' filename ' ...']);
ffnew=ext_finger(img,1);

%% GET FEATURES OF AN ARBITRARY FINGERPRINT FROM THE TEMPLATE AND MATCH IT WITH FIRST ONE
load('db.mat'); 
second=FileNameSingle2;

numValue=str2num(second(1:4));
part1=(fix(mod(numValue,1000)/10)-1)*8;
part2=mod(mod(numValue,1000),10);
i=part1+part2;
disp(['Computing similarity between ' filename ' and ' second ' from FVC2002']);
S=match(ffnew,ff{i},1);



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTP_Callback(hObject, eventdata, handles)
% hObject    handle to editTP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTP as text
%        str2double(get(hObject,'String')) returns contents of editTP as a double


% --- Executes during object creation, after setting all properties.
function editTP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = findobj('Tag','pushbutton1');
selected=get(handles.edit1,'String');
original=str2num(selected(1:4));
sres=get(handles.edit3,'String');
result=str2num(sres);
sz=size(result);
t1=0;
f1=0;
for n=1:sz
   
    if fix(mod(result(n),1000)/10)==fix(mod(original,1000)/10)
        t1=t1+1;
        
    else %fix(mod(result(n),1000)/10)~=fix(mod(original,1000)/10)
        f1=f1+1;
    end
end

TP=t1/8;
TN=(64-f1)/64;
FP=(f1)/64;
FN=(8-t1)/8;
set(handles.editTP,'String',TP);
set(handles.editTN,'String',TN);
set(handles.editFP,'String',FP);
set(handles.editFN,'String',FN);
%-----------------------------------------
% firstFile=get(handles.edit1,'String');
% numValue=str2num(firstFile(1:4));
% part1=(fix(mod(numValue,1000)/10)-1)*8;
% part2=mod(mod(numValue,1000),10);
% i=part1+part2;
% if mod(i,8)==0
%     x=i/8-1;
%     y=x-1;
% else
%     x=fix(i/8);
%     y=x+1;
% end
% 
% max=t1+(x*8);
% max=(max-1)/72;
% fidMax=fopen('cmc.txt','a');
% fprintf(fidMax,'%f\n',max);
% fclose(fidMax);

    



function editFP_Callback(hObject, eventdata, handles)
% hObject    handle to editFP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFP as text
%        str2double(get(hObject,'String')) returns contents of editFP as a double


% --- Executes during object creation, after setting all properties.
function editFP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFN_Callback(hObject, eventdata, handles)
% hObject    handle to editFN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFN as text
%        str2double(get(hObject,'String')) returns contents of editFN as a double


% --- Executes during object creation, after setting all properties.
function editFN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTN_Callback(hObject, eventdata, handles)
% hObject    handle to editTN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTN as text
%        str2double(get(hObject,'String')) returns contents of editTN as a double


% --- Executes during object creation, after setting all properties.
function editTN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rank=1:72;
formatspec='%f';
fidCMC=fopen('cmc.txt','r');
CMC=fscanf(fidCMC,formatspec);
cmc=sort(CMC);
figure,plot(rank,cmc);
title('CMC graph');
xlabel('Rank');
ylabel('Identification Accuracy');
fclose(fidCMC);
