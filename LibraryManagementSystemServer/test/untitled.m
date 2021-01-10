function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 09-Jun-2020 12:40:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

set(handles.a0_entered, 'visible','off')
set(handles.a1_entered, 'visible','off')
set(handles.a2_entered, 'visible','off')
set(handles.a3_entered, 'visible','off')
set(handles.a4_entered, 'visible','off')
set(handles.b0_entered, 'visible','off')
set(handles.b1_entered, 'visible','off')
set(handles.b2_entered, 'visible','off')
set(handles.b3_entered, 'visible','off')
set(handles.b4_entered, 'visible','off')
set(handles.text7, 'visible','off')
set(handles.text8, 'visible','off')
set(handles.text9, 'visible','off')
set(handles.text10, 'visible','off')
set(handles.text11, 'visible','off')
set(handles.text12, 'visible','off')
set(handles.text13, 'visible','off')
set(handles.text14, 'visible','off')
set(handles.text15, 'visible','off')
set(handles.text16, 'visible','off')

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.main);




% --- Executes during object creation, after setting all properties.
function inputtype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_entered_Callback(hObject, eventdata, handles)
% hObject    handle to n_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_entered as text
%        str2double(get(hObject,'String')) returns contents of n_entered as a double
n = str2double ( get(handles.n_entered, 'string') );
if n==1
    set(handles.a0_entered, 'visible','on')
    set(handles.a1_entered, 'visible','on')
    set(handles.text7, 'visible','on')
    set(handles.text8, 'visible','on')

elseif n==2
    set(handles.a0_entered, 'visible','on')
    set(handles.a1_entered, 'visible','on')
    set(handles.a2_entered, 'visible','on')
    set(handles.text7, 'visible','on')
    set(handles.text8, 'visible','on')
    set(handles.text9, 'visible','on')
    
elseif n==3
    set(handles.a0_entered, 'visible','on')
    set(handles.a1_entered, 'visible','on')
    set(handles.a2_entered, 'visible','on')
    set(handles.a3_entered, 'visible','on')
    set(handles.text7, 'visible','on')
    set(handles.text8, 'visible','on')
    set(handles.text9, 'visible','on')
    set(handles.text10, 'visible','on')

elseif n==4
    set(handles.a0_entered, 'visible','on')
    set(handles.a1_entered, 'visible','on')
    set(handles.a2_entered, 'visible','on')
    set(handles.a3_entered, 'visible','on')
    set(handles.a4_entered, 'visible','on')
    set(handles.text7, 'visible','on')
    set(handles.text8, 'visible','on')
    set(handles.text9, 'visible','on')
    set(handles.text10, 'visible','on')
    set(handles.text15, 'visible','on')
end

% --- Executes during object creation, after setting all properties.
function n_entered_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m_entered_Callback(hObject, eventdata, handles)
% hObject    handle to m_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m_entered as text
%        str2double(get(hObject,'String')) returns contents of m_entered as a double
m = str2double ( get(handles.m_entered, 'string') );
if m==1
    set(handles.b0_entered, 'visible','on')
    set(handles.b1_entered, 'visible','on')
    set(handles.text11, 'visible','on')
    set(handles.text12, 'visible','on')

elseif m==2
    set(handles.b0_entered, 'visible','on')
    set(handles.b1_entered, 'visible','on')
    set(handles.b2_entered, 'visible','on')
    set(handles.text11, 'visible','on')
    set(handles.text12, 'visible','on')
    set(handles.text13, 'visible','on')
    
elseif m==3
    set(handles.b0_entered, 'visible','on')
    set(handles.b1_entered, 'visible','on')
    set(handles.b2_entered, 'visible','on')
    set(handles.b3_entered, 'visible','on')
    set(handles.text11, 'visible','on')
    set(handles.text12, 'visible','on')
    set(handles.text13, 'visible','on')
    set(handles.text14, 'visible','on')
    
elseif m==4
    set(handles.b0_entered, 'visible','on')
    set(handles.b1_entered, 'visible','on')
    set(handles.b2_entered, 'visible','on')
    set(handles.b3_entered, 'visible','on')
    set(handles.b4_entered, 'visible','on')
    set(handles.text11, 'visible','on')
    set(handles.text12, 'visible','on')
    set(handles.text13, 'visible','on')
    set(handles.text14, 'visible','on')
    set(handles.text16, 'visible','on')
end

% --- Executes during object creation, after setting all properties.
function m_entered_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a0_entered_Callback(hObject, eventdata, handles)
% hObject    handle to a0_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a0_entered as text
%        str2double(get(hObject,'String')) returns contents of a0_entered as a double


% --- Executes during object creation, after setting all properties.
function a0_entered_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a0_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a1_entered_Callback(hObject, eventdata, handles)
% hObject    handle to a1_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a1_entered as text
%        str2double(get(hObject,'String')) returns contents of a1_entered as a double


% --- Executes during object creation, after setting all properties.
function a1_entered_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a1_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a2_entered_Callback(hObject, eventdata, handles)
% hObject    handle to a2_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a2_entered as text
%        str2double(get(hObject,'String')) returns contents of a2_entered as a double


% --- Executes during object creation, after setting all properties.
function a2_entered_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a2_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a3_entered_Callback(hObject, eventdata, handles)
% hObject    handle to a3_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a3_entered as text
%        str2double(get(hObject,'String')) returns contents of a3_entered as a double


% --- Executes during object creation, after setting all properties.
function a3_entered_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a3_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a4_entered_Callback(hObject, eventdata, handles)
% hObject    handle to a4_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a4_entered as text
%        str2double(get(hObject,'String')) returns contents of a4_entered as a double


% --- Executes during object creation, after setting all properties.
function a4_entered_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a4_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b0_entered_Callback(hObject, eventdata, handles)
% hObject    handle to b0_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b0_entered as text
%        str2double(get(hObject,'String')) returns contents of b0_entered as a double


% --- Executes during object creation, after setting all properties.
function b0_entered_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b0_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b1_entered_Callback(hObject, eventdata, handles)
% hObject    handle to b1_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b1_entered as text
%        str2double(get(hObject,'String')) returns contents of b1_entered as a double


% --- Executes during object creation, after setting all properties.
function b1_entered_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b1_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b2_entered_Callback(hObject, eventdata, handles)
% hObject    handle to b2_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b2_entered as text
%        str2double(get(hObject,'String')) returns contents of b2_entered as a double


% --- Executes during object creation, after setting all properties.
function b2_entered_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b2_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b3_entered_Callback(hObject, eventdata, handles)
% hObject    handle to b3_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b3_entered as text
%        str2double(get(hObject,'String')) returns contents of b3_entered as a double


% --- Executes during object creation, after setting all properties.
function b3_entered_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b3_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b4_entered_Callback(hObject, eventdata, handles)
% hObject    handle to b4_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b4_entered as text
%        str2double(get(hObject,'String')) returns contents of b4_entered as a double


% --- Executes during object creation, after setting all properties.
function b4_entered_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b4_entered (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [X,Y]= solve(B,y,k,a0,a1,a2,a3,a4,b0,b1,b2,b3,b4)



a=0;
b=B;
h=10^-3;
x = a:h:b;


u(1,:) = input(b);

for m=2:1:k+1
    u(m,:)=input_diff(u(m-1,:),b);            
end
u = u';
i=0;

for j = a : h : b
     i = i + 1  ;
     k1 = fun(x(i),(y(i,:)),k,a0,a1,a2,a3,a4,b0,b1,b2,b3,b4,u(i,:));
     k2 = fun(x(i)+0.5*h,(y(i,:)+0.5*h*k1),k,a0,a1,a2,a3,a4,b0,b1,b2,b3,b4,u(i,:));
     k3 = fun((x(i)+0.5*h),(y(i,:)+0.5*h*k2),k,a0,a1,a2,a3,a4,b0,b1,b2,b3,b4,u(i,:));
     k4 = fun((x(i)+h),(y(i,:)+h*k3),k,a0,a1,a2,a3,a4,b0,b1,b2,b3,b4,u(i,:));
     y(i+1,:) = y(i,:) + (1/6)*h*(k1+2*k2+2*k3+k4);  % main equation
end

Y = y;
X = x;

function [f]=fun(~,y,n,a0,a1,a2,a3,a4,b0,b1,b2,b3,b4,u)



if n==1
    
    z1 = y(1);
    f_dot1 =(-a0/a1)*z1+(b0/a1)*u(1)+(b2/a1)*u(2);
    out = f_dot1 ;    
    
elseif n==2
    
    z1 = y(1)  ;
    z2 = y(2)  ;
    f_dot1 =z2;
    f_dot2 =(-a0/a2)*z1+(-a1/a2)*z2+(b0/a2)*u(1)+(b1/a2)*u(2)+(b2/a2)*u(3);
    out = [f_dot1 f_dot2  ] ;
    
elseif n==3 
    
    z1 = y(1)  ;
    z2 = y(2)  ;
    z3 = y(3)  ;
    f_dot1 = z2;
    f_dot2 = z3;
    f_dot3 = (-a0/a3)*z1+(-a1/a3)*z2+(-a2/a3)*z3+(b0/a3)*u(1)+(b1/a3)*u(2)+(b2/a3)*u(3)+(b3/a3)*u(4);
    out = [f_dot1 f_dot2 f_dot3 ] ;
    
elseif n==4
    
    z1 = y(1)  ;
    z2 = y(2)  ;
    z3 = y(3)  ;
    z4 = y(4)  ;
    f_dot1 = z2;
    f_dot2 = z3;
    f_dot3 = z4;
    f_dot4 =(-a0/a4)*z1+(-a1/a4)*z2+(-a2/a4)*z3+(-a3/a4)*z4+(b0/a4)*u(1)+(b1/a4)*u(2)+(b2/a4)*u(3)+(b3/a4)*u(4)+(b4/a4)*u(5);
    out = [f_dot1 f_dot2 f_dot3 f_dot4 ] ;
    
end



f = out ;




function[u]= input(b)

    h = +10^-3     ;
    
    u = zeros(1,(b/h)+1) ;
      
    i = 0  ;
    

    for j = 0 : h : b
        i = i + 1 ;
        if j < 0
            u(i) = 0 ;
        else 
            u(i) = 1 ;
        end     
    end    

function[I]=input_diff(x,b)
    
    i=0;
    h = +10^-3       ;
    I = zeros(1,(b)/h+1) ;
    
    for j = 0 : h : b-h
        i = i + 1 ;
        if i==1
            I(i)=x(i)/h;
        else
            I(i) = (x(i)-x(i-1))/h;
        end
        
    end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in inputtype.
function inputtype_Callback(hObject, eventdata, handles)
% hObject    handle to inputtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns inputtype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from inputtype


h = get(hObject, 'value');%get input type (unit step-unit impulse)
%to start excuting the program

m = str2double ( get(handles.m_entered, 'string') );
n = str2double ( get(handles.n_entered, 'string') );
%change m and n from string into numbers

%get values of a0,a1,a2,a3,a4,b0,b1,b2,b3,b4
%change them from string into number
a0 = str2double ( get(handles.a0_entered, 'string') );
if n>0
   a1 = str2double ( get(handles.a1_entered, 'string') );
   if n>1
      a2 = str2double ( get(handles.a2_entered, 'string') );
      if n>2
         a3 = str2double ( get(handles.a3_entered, 'string') );
         if n>3
            a4 = str2double ( get(handles.a4_entered, 'string') );
         else
            a4=0;    
         end
      else
         a3=0;
         a4=0;
      end
   else
       a2=0;
       a3=0;
       a4=0;
   end
else
    a1=0;
    a2=0;
    a3=0;
    a4=0;
end

b0 = str2double ( get(handles.b0_entered, 'string') );
if m>0
   b1 = str2double ( get(handles.b1_entered, 'string') );
   if m>1
      b2 = str2double ( get(handles.b2_entered, 'string') );
      if m>2
         b3 = str2double ( get(handles.b3_entered, 'string') );
         if m>3
            b4 = str2double ( get(handles.b4_entered, 'string') );
         else
            b4=0;    
         end
      else
         b3=0;
         b4=0;
      end
   else
       b2=0;
       b3=0;
       b4=0;
   end
else
    b1=0;
    b2=0;
    b3=0;
    b4=0;
end


 
    b = 10;                 
    k  = n ;
 
    y(1,:)=zeros(1,k) ;
%switch to calculate y
switch h
    
    case 1
        hold on;
        
    case 2 %case unit step
[x,y] = solve(b,y,k,a0,a1,a2,a3,a4,b0,b1,b2,b3,b4);
p=1;
    case 3 %case unit impulse
[x,y] = solve(b,y,k,a0,a1,a2,a3,a4,b0,b1,b2,b3,b4);
p=2;
end

%plot y in a separate figure (pop up window)
figure(1)
    plot(x,y(1:length(x),p),'linewidth',0.75);
    
    
%put a0,a1,a2,a3,a4,b0,b1,b2,b3,b4 in a vector
a=[a0,a1,a2,a3,a4];
b=[b0,b1,b2,b3,b4];

if a(n+1)~=0
    b=b/a(n+1);
    a=a/a(n+1);
end %to make coefficient of biggest y derivative =1


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%put A matrix in the form [0   1   0   0;
%                          0   0   1   0;
%                          0   0   0   1;
%                         -a4 -a3 -a2 -a1]
A = zeros(n:n);
i=1;
j=1;

for i=1:1:n
    for j=i:1:n
        if i~=n
           if i==j
              A(i,j+1)=1;
           end
        elseif i==n
            e=n;
            q=2;
            w=1;
            for w=1:n
                A(i,e)=[-a(q)];
                w=w-1;
                e=e-1;
                q=q+1;
            end
        end   
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%put B matrix in the form [ B1=b(n-1)-a(n-1)b(n)
%                           B2=b(n-2)-a(n-2)b(n) -a(n-1)B1
%                           B3=b(n-3)-a(n-3)b(n) -a(n-1)B2 -a(n-2)B1
%                           B4=b(n-4)-a(n-4)b(n) -a(n-1)B3 -a(n-2)B2 -a(n-3)B3 ]
B = zeros(1,n);
B =B(:);
i=1;
j=1;
r=n;
f=n+1;

for i=1:1:n
    
    k=b(r)-(a(r)*b(f));
    B(i)=[k];
    
    if n>1
        if i==2
        B(2)=B(2)-(a(n-1)*B(1));
        end
        if n>2
            if i==3
            B(3)=B(3)-(a(n-1)*B(2))-(a(n-2)*B(1));
            end
            if n>3
                if i==4
                B(4)=B(4)-(a(n-1)*B(3))-(a(n-2)*B(2))-(a(n-3)*B(1));
                end
            end
        end
    end
    
    r=r-1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%put C matrix in the form [1 0 0 0]
C = zeros(1,n);
C(1)=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%put D matrix in the form [bm]
if m==0
    D=[0];
else
    D=[a(m+1)];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%generate u as (unit step-unit impulse)

tt = (0:1:n-1)';

switch h
    case 3 %unit impulse
u =1* (tt==0);
p=2;
    case 2 %unit step
u = tt>=0;
p=1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%generate states
[WWW]= StatVariables(n,y(1:length(x),p),u,A,B,D);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(2) %plot states
plot(WWW);

%plot u
%figure(3)
%plot(tt,u)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [svs]= StatVariables(n,y,u,A,B,D)
%n==>order of de
%y==>output
%u==>input 
svs(:,n)=y(1:length(u))-D.*u';

for j = n:-1:2
    svs(:,j-1) = fun_different(svs(:, j))-A(j,n).*svs(:,n)-B(j).*u';
end


function t_fin = fun_different(t)
%t ==> The input function 
t_temp = zeros(length(t),1);
for j = 1:1:length(t)-1
t_temp(j)=(t(j+1)-t(j))/(10^-3);
end
t_fin=t_temp;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%