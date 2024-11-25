function varargout = PED_Detection(varargin)
% Last Modified by GUIDE v2.5 11-Feb-2023 11:29:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PED_Detection_OpeningFcn, ...
                   'gui_OutputFcn',  @PED_Detection_OutputFcn, ...
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


% --- Executes just before PED_Detection is made visible.
function PED_Detection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PED_Detection (see VARARGIN)

% Choose default command line output for PED_Detection
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

    %My Code
    clc                                         %clear command window
    set(handles.lblFileName,'string','');
    % axis off;
    set(handles.axes1,'xtick',[],'ytick',[]);   %remove axes values
    set(handles.axes1,'box','on');        %set the border 
    set(handles.axes2,'xtick',[],'ytick',[]);  
    set(handles.axes2,'box','on');     
    set(handles.axes3,'xtick',[],'ytick',[]);  
    set(handles.axes3,'box','on');     
    set(handles.axes4,'xtick',[],'ytick',[]);  
    set(handles.axes4,'box','on');     
    set(handles.axes5,'xtick',[],'ytick',[]);  
    set(handles.axes5,'box','on');     
    set(handles.axes6,'xtick',[],'ytick',[]);  
    set(handles.axes6,'box','on');     
    set(handles.axes7,'xtick',[],'ytick',[]);  
    set(handles.axes7,'box','on');     
    set(handles.axes8,'xtick',[],'ytick',[]);  
    set(handles.axes8,'box','on');     
    set(handles.axes9,'xtick',[],'ytick',[]);  
    set(handles.axes9,'box','on');     

% --- Outputs from this function are returned to the command line.
function varargout = PED_Detection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function clearAxes(hObject, eventdata, handles)     %user defined function
    axes(handles.axes2);
    title('');
    cla
    axes(handles.axes3);
    title('');
    cla
     axes(handles.axes4);
     title('');
     cla
     axes(handles.axes5);
     title('');
     cla
     axes(handles.axes6);
     title('');
     cla
     axes(handles.axes7);
     title('');
     cla
    axes(handles.axes8);
    title('');
    cla
    axes(handles.axes9);
    title('');
    cla


% --- Executes on button press in btnOpenImage.
function btnOpenImage_Callback(hObject, eventdata, handles)
    clc
    global imgInput;
    [FileName,PathName] = uigetfile('*.jpg;*.jpeg;*.bmp','Select the Image File...');
    if(FileName==0)
        set(handles.lblFileName,'string','');
        cla(handles.axes1,'reset');
        set(handles.axes1,'xtick',[],'ytick',[]);   %remove axes values
        set(handles.axes1,'box','on');        %set the border 
    else
         FullPath=strcat(PathName,FileName);
%         set(handles.lblFilePath,'string',FullPath);
        set(handles.lblFileName,'string',FileName);
        
        imgInput=imread(FullPath);
        axes(handles.axes1);
        imshow(imgInput);
        title('Original Input Image');
        
    end


% --- Executes on button press in btnGrayScale.
function btnGrayScale_Callback(hObject, eventdata, handles)
    global imgInput
    global imgGray;
    
    clearAxes(hObject, eventdata, handles);
    
    imgGray=rgb2gray(imgInput);
    axes(handles.axes2);
    imshow(imgGray);
    title('Grayscale Image');


% --- Executes on button press in btnImgFiltering.
function btnImgFiltering_Callback(hObject, eventdata, handles)
    global imgGray;
    global imgMedFil;
    global imgInput
    
    clearAxes(hObject, eventdata, handles);
    
    imgGray=rgb2gray(imgInput);
    axes(handles.axes2);
    imshow(imgGray);
    title('Grayscale Image');

    imgMedFil=medfilt2(imgGray,[3 3]);      %plane is not available for grayscale img 
                                            % So use only two variable [height width]
    axes(handles.axes3);
    imshow(imgMedFil);
    title('Median Filter');


% --- Executes on button press in btnCloseAll.
function btnCloseAll_Callback(hObject, eventdata, handles)
    close all

% --- Executes on button press in btnClose.
function btnClose_Callback(hObject, eventdata, handles)
    close


% --- Executes on button press in btnRPELSegmentation.
function btnRPELSegmentation_Callback(hObject, eventdata, handles)
    global imgGray;
    global imgFil;
    global imgInput;
    global imgBlueRemoved;
    
    clearAxes(hObject, eventdata, handles);
    
    %To display RGB value of 5th row and 5th col pixel
    disp('Input image (RGB)');disp(imgInput(5,5,1));disp(imgInput(5,5,2));disp(imgInput(5,5,3));

    imgBlueRemoved=imgInput;
    imgBlueRemoved(:,:,3)=0;
    %imgBlueRemoved(:,:,2)=0;
    
    axes(handles.axes2);
    imshow(imgBlueRemoved);
    title('After Removing Blue color');
    imgGray=rgb2gray(imgBlueRemoved);
    
%     imgGreenRemoved=imgInput;
%     imgGreenRemoved(:,:,2)=0;
%     axes(handles.axes2);
%     imshow(imgGreenRemoved);
%     title('After Removing Green color');
%     imgGray=rgb2gray(imgGreenRemoved);

    %imgGray=rgb2gray(imgInput);
    
    axes(handles.axes3);
    imshow(imgGray);
    title('Grayscale Image');

    %To display Gray scale value of 5th row and 5th col
    disp('gray scale image');disp(imgGray(5,5));
    
    imgGray=double(imgGray)/255;
    %Igray=Igray/255; %only black and white image 0 and 1
    %Iorg=Igray;
    disp('After divided by 255');disp(imgGray(5,5));
    
    
    imgFil=medfilt2(imgGray,[3 3]);      %plane is not available for grayscale img 
                                            % So use only two variable [height width]
    axes(handles.axes4);
    imshow(imgFil);
    title('Median Filter');
    
    disp('After applying median filter');disp(imgFil(5,5));
    disp(imgFil(:,1));

%     BW = edge(imgFil,'canny');
%     figure,
%     imshow(BW);

    
    [Irpe,yrpe]=RPE_L_Segmentation(imgFil);
    
    disp('yrep values');
    disp(yrpe);
    
    axes(handles.axes5);
    imshow(Irpe);hold on;
    %imshow(imgInput);hold on;
    plot(yrpe,'r.-')
    hold off;
    title('RPE Layer with False Pixels');
    
    
%     yrpe=round(yrpe);
%     len=length(yrpe);
%     yrpecolor=1:1:len;
%     for i=1:1:length(yrpe)      %array startig index 1
%         yrpecolor(i)=Irpe(yrpe(i),i);
%     end
%     disp('yrepcolor values');
%     disp(yrpecolor);
%     
%     %If A is a vector, then mode(A) returns the most frequent value of A.
%     mfv=mode(yrpecolor);
%     disp('Most frequent value');
%     disp(mfv);
%     
%     for i=1:1:length(yrpe)      %array startig index 1
%         if ((Irpe(yrpe(i),i)>=mfv - 0.2)) %&& (Irpe(yrpe(i),i)<=mfv + 0.7))
%             Irpe(yrpe(i),i)=1;
%         end
%     end
    
 lineFilter=yrpe;
     %lineFilter=medfilt2(yrpe,[1 15]);
%     disp(lineFilter);


    lineFilter=round(lineFilter);
    len=length(lineFilter);
    yrpecolor=1:1:len;
    for i=1:1:length(lineFilter)      %array startig index 1
        yrpecolor(i)=Irpe(lineFilter(i),i);
    end
    disp('yrepcolor values');
    disp(yrpecolor);
    
    %If A is a vector, then mode(A) returns the most frequent value of A.
    mfv=mode(yrpecolor);
    disp('Most frequent value');
    disp(mfv);
    
    for i=1:1:length(lineFilter)      %array startig index 1
        if ((Irpe(lineFilter(i),i)>=mfv - 0.3)) % && (Irpe(lineFilter(i),i)<=mfv + 0.3))
            Irpe(lineFilter(i),i)=1;
        end
    end
    

    figure; 
    imshow(Irpe);hold on;
    plot(lineFilter,'r.-')
    hold off;
    

%     axes(handles.axes6);
%     imshow(Irpe);hold on;
%     %imshow(imgInput);hold on;
%     plot(lineFilter,'r.-')
%     hold off;
%     title('Image with RPE Layer');
    
%     len=length(yrpe);
%     %newyrpe=zeros(len);
%     newyrpe=1:1:len;
%     newyrpe(1)=yrpe(1);
%     preValue=yrpe(1);
%     
%     % disp(length(yrpe)); % to find length of 1D array
%     for i=2:1:length(lineFilter)      %array startig index 1
%         
%       if (abs(lineFilter(i)-preValue)<15)
%           newyrpe(i)=lineFilter(i);
%           %preValue=lineFilter(i-1);
%       end
%       preValue=lineFilter(i-1);
%     end
% 
%     %axes(handles.axes6);
%     figure,
%     imshow(Irpe);hold on;
%     %imshow(imgInput);hold on;
%     plot(newyrpe)
%     hold off;
%     title('Image with RPE Layer');


    len=length(lineFilter);
    %newyrpe=zeros(len);
    newyrpe=1:1:len;
    newyrpe(1)=lineFilter(1);
    preValue=lineFilter(1);
    
    % disp(length(yrpe)); % to find length of 1D array
    for i=2:1:length(lineFilter)      %array startig index 1
        
      if (abs(preValue-lineFilter(i))<30)
          newyrpe(i)=lineFilter(i);
          %preValue=lineFilter(i-1);
      else
          newyrpe(i)=newyrpe(i-1);
      end
      preValue=newyrpe(i);
    end

    axes(handles.axes6);
    imshow(Irpe);hold on;
    %imshow(imgInput);hold on;
    plot(newyrpe,'r.-')
    hold off;
    title('Removed False Pixels in RPE Layer ');
  
    %axes(handles.axes6);
    figure,
    imshow(Irpe);hold on;
    %imshow(imgInput);hold on;
    plot(newyrpe,'r.-')
    hold off;
    title('Removed False Pixels in RPE Layer');
    
    lineFilter=medfilt2(newyrpe,[1 15]);
    
    figure; 
    imshow(Irpe);hold on;
    plot(lineFilter,'r.-')
    hold off;
    
    axes(handles.axes7);
    imshow(Irpe);hold on;
    %imshow(imgInput);hold on;
    plot(lineFilter,'r.-')
    hold off;
    title('Smoothing the RPE Layer');
    
    axes(handles.axes8);
    %imshow(Irpe);hold on;
    imshow(imgGray);hold on;
    plot(lineFilter,'r.-')
    hold off;
    title('RPE Layer on Grayscale Image');
    
    axes(handles.axes9);
    %imshow(Irpe);hold on;
    imshow(imgInput);hold on;
    plot(lineFilter,'r.-')
    hold off;
    title('RPE Layer on Original Image');
    

% --- Executes on button press in RPE_Seg_2.
function RPE_Seg_2_Callback(hObject, eventdata, handles)
    global imgGray;
    global imgFil;
    global imgInput
    
    clearAxes(hObject, eventdata, handles);
    
    %To display RGB value of 5th row and 5th col pixel
    disp('Input image (RGB)');disp(imgInput(5,5,1));disp(imgInput(5,5,2));disp(imgInput(5,5,3));
    
    imgInput(:,:,3)=0;
    axes(handles.axes2);
    imshow(imgInput);
    title('After Removing Blue color');
    
    imgGray=rgb2gray(imgInput);
    axes(handles.axes3);
    imshow(imgGray);
    title('Grayscale Image');

    %To display Gray scale value of 5th row and 5th col
    disp('gray scale image');disp(imgGray(5,5));
    
    imgGray=double(imgGray)/255;
    %Igray=Igray/255; %only black and white image 0 and 1
    %Iorg=Igray;
    disp('After divided by 255');disp(imgGray(5,5));
    
    
    imgFil=medfilt2(imgGray,[3 3]);      %plane is not available for grayscale img 
                                            % So use only two variable [height width]
    axes(handles.axes4);
    imshow(imgFil);
    title('Median Filter');
    
    disp('After applying median filter');disp(imgFil(5,5));
    disp(imgFil(:,1));
    
%     imgMat2Gray=mat2gray(imgFil*0.5+imgFil);
%     figure,
%     imshow(imgMat2Gray);
%         % grayscal to binary image
%     imgFil=imgMat2Gray;
    
    imgFil=imadjust(imgFil);
    level=graythresh(imgFil);
    disp('level=');disp(level);
    %if (level<=0.38)
    %    level=0.2;
    %end
    level=0.80;
    imgBinary=im2bw(imgFil,level);
    
    figure,
    imhist(imgFil);
    
    axes(handles.axes5);
    imshow(imgBinary);
    title('Binary Image');
    


% --- Executes on button press in Btn_Rotate_RPE.
function Btn_Rotate_RPE_Callback(hObject, eventdata, handles)
    global imgGray;
    global imgFil;
    global imgInput;
    global imgBlueRemoved;
    
    clearAxes(hObject, eventdata, handles);
    
    %To display RGB value of 5th row and 5th col pixel
    disp('Input image (RGB)');disp(imgInput(5,5,1));disp(imgInput(5,5,2));disp(imgInput(5,5,3));

    imgBlueRemoved=imgInput;
    imgBlueRemoved(:,:,3)=0;
    %imgBlueRemoved(:,:,2)=0;
    
    axes(handles.axes2);
    imshow(imgBlueRemoved);
    title('After Removing Blue color');
    imgGray=rgb2gray(imgBlueRemoved);
    
%     imgGreenRemoved=imgInput;
%     imgGreenRemoved(:,:,2)=0;
%     axes(handles.axes2);
%     imshow(imgGreenRemoved);
%     title('After Removing Green color');
%     imgGray=rgb2gray(imgGreenRemoved);

    %imgGray=rgb2gray(imgInput);
    
    axes(handles.axes3);
    imshow(imgGray);
    title('Grayscale Image');

    %To display Gray scale value of 5th row and 5th col
    disp('gray scale image');disp(imgGray(5,5));
    
    imgGray=double(imgGray)/255;
    %Igray=Igray/255; %only black and white image 0 and 1
    %Iorg=Igray;
    disp('After divided by 255');disp(imgGray(5,5));
    
    
    imgFil=medfilt2(imgGray,[3 3]);      %plane is not available for grayscale img 
                                            % So use only two variable [height width]
    axes(handles.axes4);
    imshow(imgFil);
    title('Median Filter');
    
    disp('After applying median filter');disp(imgFil(5,5));
    disp(imgFil(:,1));

%     % Wiener filter to reduce speckle noise
%     imgFil = wiener2(imgGray,[3 3]); 
% 
%     axes(handles.axes4);
%     imshow(imgFil);
%     title('Wiener Filter');
%     
%     disp('After applying Wiener filter');disp(imgFil(5,5));
%     disp(imgFil(:,1));

%     BW = edge(imgFil,'canny');
%     figure,
%     imshow(BW);

    
    [Irpe,yrpe]=RPE_L_Segmentation(imgFil);
    
    disp('yrep values');
    disp(yrpe);
    
    axes(handles.axes5);
    imshow(Irpe);hold on;
    %imshow(imgInput);hold on;
    plot(yrpe,'r.-')
    hold off;
    title('RPE Layer with False Pixels');
    
    
%     yrpe=round(yrpe);
%     len=length(yrpe);
%     yrpecolor=1:1:len;
%     for i=1:1:length(yrpe)      %array startig index 1
%         yrpecolor(i)=Irpe(yrpe(i),i);
%     end
%     disp('yrepcolor values');
%     disp(yrpecolor);
%     
%     %If A is a vector, then mode(A) returns the most frequent value of A.
%     mfv=mode(yrpecolor);
%     disp('Most frequent value');
%     disp(mfv);
%     
%     for i=1:1:length(yrpe)      %array startig index 1
%         if ((Irpe(yrpe(i),i)>=mfv - 0.2)) %&& (Irpe(yrpe(i),i)<=mfv + 0.7))
%             Irpe(yrpe(i),i)=1;
%         end
%     end
    
 lineFilter=yrpe;
     %lineFilter=medfilt2(yrpe,[1 15]);
%     disp(lineFilter);


    lineFilter=round(lineFilter);
    len=length(lineFilter);
    yrpecolor=1:1:len;
    for i=1:1:length(lineFilter)      %array startig index 1
        yrpecolor(i)=Irpe(lineFilter(i),i);
    end
    disp('yrepcolor values');
    disp(yrpecolor);
    
    %If A is a vector, then mode(A) returns the most frequent value of A.
    mfv=mode(yrpecolor);
    disp('Most frequent value');
    disp(mfv);
    
    for i=1:1:length(lineFilter)      %array startig index 1
        if ((Irpe(lineFilter(i),i)>=mfv - 0.3)) % && (Irpe(lineFilter(i),i)<=mfv + 0.3))
            Irpe(lineFilter(i),i)=1;
        end
    end
    

    figure; 
    imshow(Irpe);hold on;
    plot(lineFilter,'r.-')
    hold off;
    

%     axes(handles.axes6);
%     imshow(Irpe);hold on;
%     %imshow(imgInput);hold on;
%     plot(lineFilter,'r.-')
%     hold off;
%     title('Image with RPE Layer');
    
%     len=length(yrpe);
%     %newyrpe=zeros(len);
%     newyrpe=1:1:len;
%     newyrpe(1)=yrpe(1);
%     preValue=yrpe(1);
%     
%     % disp(length(yrpe)); % to find length of 1D array
%     for i=2:1:length(lineFilter)      %array startig index 1
%         
%       if (abs(lineFilter(i)-preValue)<15)
%           newyrpe(i)=lineFilter(i);
%           %preValue=lineFilter(i-1);
%       end
%       preValue=lineFilter(i-1);
%     end
% 
%     %axes(handles.axes6);
%     figure,
%     imshow(Irpe);hold on;
%     %imshow(imgInput);hold on;
%     plot(newyrpe)
%     hold off;
%     title('Image with RPE Layer');


    len=length(lineFilter);
    %newyrpe=zeros(len);
    newyrpe=1:1:len;
    newyrpe(1)=lineFilter(1);
    preValue=lineFilter(1);
    
    % disp(length(yrpe)); % to find length of 1D array
    for i=2:1:length(lineFilter)      %array startig index 1
        
      if (abs(preValue-lineFilter(i))<30)
          newyrpe(i)=lineFilter(i);
          %preValue=lineFilter(i-1);
      else
          newyrpe(i)=newyrpe(i-1);  
      end
      preValue=newyrpe(i);
    end

    axes(handles.axes6);
    imshow(Irpe);hold on;
    %imshow(imgInput);hold on;
    plot(newyrpe,'r.-')
    hold off;
    title('Removed False Pixels in RPE Layer ');
  
    %axes(handles.axes6);
    figure,
    imshow(Irpe);hold on;
    %imshow(imgInput);hold on;
    plot(newyrpe,'r.-')
    hold off;
    title('Removed False Pixels in RPE Layer');
    
    lineFilter=medfilt2(newyrpe,[1 15]);
    
    figure; 
    imshow(Irpe);hold on;
    plot(lineFilter,'r.-')
    hold off;
    
    axes(handles.axes7);
    imshow(Irpe);hold on;
    %imshow(imgInput);hold on;
    plot(lineFilter,'r.-')
    hold off;
    title('Smoothing the RPE Layer');
    
    axes(handles.axes8);
    %imshow(Irpe);hold on;
    imshow(imgGray);hold on;
    plot(lineFilter,'r.-')
    hold off;
    title('RPE Layer on Grayscale Image');
    
    axes(handles.axes9);
    %imshow(Irpe);hold on;
    imshow(imgInput);hold on;
    plot(lineFilter,'r.-')
    hold off;
    title('RPE Layer on Original Image');


%%%--------------------------------------------------------
     % create RPE layer on empty/black image
    m=size(imgInput,1);
    n=size(imgInput,2);
    imgEmpty=zeros(m,n);
    %disp('m=');disp(m);
    %disp('n=');disp(n);
    disp(size(lineFilter));
    disp('size(lineFilter,1)');disp(size(lineFilter,1));
    disp('size(lineFilter,2)');disp(size(lineFilter,2));
    disp('lineFilter');
    %disp(lineFilter);
   
   %  minY=min(lineFilter(:,1));
    minY=min(lineFilter);
        
     for i=1:size(lineFilter,2)      % change pixel value to 1 only RPE boundary on empty image/matrix
         imgEmpty(lineFilter(i),i)=1;
     end
     
     figure;
     imshow(imgEmpty);
     %hold on;
     %plot(lineFilter,'y.-');
     %hold off;
     
     figure;
    %imgEmpty(lineFilter(:,1),lineFilter(:,2))=1;
    subplot(2,2,1),imshow(imgEmpty);hold on;  %imgBinary
    %plot(lineFilter,'r.-')
    %plot(lineFilter(:,2),lineFilter(:,1),'y','LineWidth',2);
    hold off;
    title('RPE Layer on Empty Image');

    
      % create RPE layer on white background for thesis
    m1=size(imgInput,1);
    n1=size(imgInput,2);
    imgWhiteEmpty=ones(m1,n1);
    %imgWhiteEmpty=imgWhiteEmpty*255;
    %disp('m=');disp(m);
    %disp('n=');disp(n);
    disp(size(lineFilter));
    disp('size(lineFilter,1)');disp(size(lineFilter,1));
    disp('size(lineFilter,2)');disp(size(lineFilter,2));
    disp('lineFilter');
    %disp(lineFilter);
   
   %  minY=min(lineFilter(:,1));
    minY1=min(lineFilter);
        
     for i=1:size(lineFilter,2)      % change pixel value to 1 only RPE boundary on empty image/matrix
         imgWhiteEmpty(lineFilter(i),i)=0;
     end
     
     figure;
     imshow(imgWhiteEmpty);
     hold on;
     plot(lineFilter,'r');
     hold off;
     title('White background');
     
     figure;
    %imgEmpty(lineFilter(:,1),lineFilter(:,2))=1;
    subplot(2,2,2),imshow(imgWhiteEmpty);hold on;  %imgBinary
    %plot(lineFilter,'r.-')
    %plot(lineFilter(:,2),lineFilter(:,1),'y','LineWidth',2);
    hold off;
    title('RPE Layer on White Image');
    
    
    
    
    
    %lineFilter(:,1)=lineFilter(:,1)-minY+1;
    %disp('lineFilter');disp(lineFilter);

    
%     for i=1:size(lineFilter,2)    % No need to move top so commented
%         lineFilter(i)=lineFilter(i)-minY+1;
%     end
    
%     imgEmpty=zeros(m,n);    % clear the existing RPE layer
%     
%     for i=1:size(lineFilter,2)      % change pixel value to 1 only RPE boundary on empty image/matrix
%          imgEmpty(lineFilter(i),i)=1;
%     end
     
    
%     subplot(2,2,2),imshow(imgEmpty);hold on;  %imgBinary
%     plot(lineFilter,'r.-')
% %     plot(lineFilter(:,2),lineFilter(:,1),'y','LineWidth',2);
%     hold off;
%     title('RPE Layer Moved Top');

% %     %vertical projection
% %     imgVerPro=sum(imgEmpty,1);
% %     %horizontal projection
% %     imgHorPro=sum(imgEmpty,2);
%     
%     
%     % Extract features to apply in Neural Network
%     % Mask size 35 X 35, total 8+1 rows and 16+1 columns
%     
%     disp('m=');disp(m);
%     disp('n=');disp(n);
%     
%     windowX=35;
%     windowY=10; %35 - Working fine for 10 also, for 10 29 rows 17 columns
% %     noCol=ceil(n/windowX);
% %     noRow=ceil(m/windowY);
% %     col=1:noRow*noCol;  %create a col vector
% %     colcount=1;
% %     fileexist=0;
% %     if (exist('MH_mat.mat','file')==2)
% %         load('MH_mat.mat','tr_set');
% %         fileexist=1;
% %     end
%     
%      fid=fopen('output.txt','wb');   %'wb' - delete and write, 'a' - append mode
%      fwrite(fid,'\n');
%     for i=1:windowY:m
%         for j=1:windowX:n
%             %disp('row=');disp(i);
%             %disp('col=');disp(j);
%             if ((i+windowY>m) && (j+windowX>n))
%                 windowMat=imgEmpty(i:m,j:n);
%             elseif (i+windowY>m)
%                 windowMat=imgEmpty(i:m,j:j+windowX);
%             elseif (j+windowX>n)
%                 windowMat=imgEmpty(i:i+windowY,j:n);
%             else
%                 windowMat=imgEmpty(i:i+windowY,j:j+windowX);
%             end
%             %disp(windowMat);
%             if(any(any(windowMat))) %any(A) treates the columns of A as vectors, returning a row vector of 1s and 0s
%                  fwrite(fid,'1 ');
%                 disp('1 '); %i,j=1;
% %                 col(colcount)=1;
% %                 colcount=colcount+1;
%             else
%                  fwrite(fid,'0 ');
%                 disp('0 '); %i,j=0;
% %                 col(colcount)=0;
% %                 colcount=colcount+1;
%             end
%            % x=input('test');
%         end
%         %disp('i=');disp(i);disp('j=');disp(j);
%         
%     end
% %     display(col);
% %     %whos
% %     col=col';
% %     if (fileexist==0)
% %         tr_set=col;
% %     else
% %         tr_set=[tr_set col];
% %     end
% %     save('MH_mat.mat','tr_set');
%     
%      fclose(fid);
% 
% %     disp('Vertical projection');disp(imgVerPro);
% %     disp('Horizontal projection');disp(imgHorPro);
% %     %hist(imgHorPro);
% %     figure, plot(imgHorPro,1:size(imgHorPro,1));
% %     figure, bar(imgHorPro);
% %     
% %     [rows,cols]=size(imgEmpty);
% %     figure, plot(1:cols,imgVerPro,'b-');
% %     figure, plot(imgHorPro,1:rows,'b-');
%     
%     figure, 
%     pause(0.00001);             %maximize the figure window
%     frame_h=get(handle(gcf),'JavaFrame');
%     set(frame_h,'Maximized',1);
% 
%     subplot(2,2,1), imshow(imgEmpty);title('NFL Layer Moved Top');
    
% % To find angle for rotation
% pos = [  lineFilter(1,2) lineFilter(end,2)    % X
%          lineFilter(1,1) lineFilter(end,1)];  % Y 
% % The angle equals the arctangent of dy/dx
% angle = atan2(diff(pos(2,:)), diff(pos(1,:)));
% disp('pos');disp(pos);
% disp('angle=');disp(angle);
% angle=angle*50; % for rotate stright angle/2
% angle=45;
% % Rotate in the opposite direction 
% %img = imrotate(img, -angle);


    disp(lineFilter(1));
    disp(lineFilter(end));
% 
% % To find angle for rotation
% x1=1;
% y1=lineFilter(1);
% x2=size(lineFilter,2);
% y2=lineFilter(end); 
% % The angle equals the arctangent of dy/dx
% angle = atan2d(x1*y2-y1*x2,x1*x2+y1*y2);
% disp('angle=');disp(angle);
% angle=-angle/8; % for rotate stright angle/2
% %angle=45;
% % Rotate in the opposite direction 
% %img = imrotate(img, -angle);

disp('size of lineFilter');disp(size(lineFilter));
% To find angle for rotation
%pos = [  lineFilter(1,2) lineFilter(end,2)    % X
%         lineFilter(1,1) lineFilter(end,1)];  % Y 
pos = [  size(lineFilter,1) size(lineFilter,2)    % X
         lineFilter(1) lineFilter(end)];          % Y 

% The angle equals the arctangent of dy/dx
angle = atan2(diff(pos(2,:)), diff(pos(1,:)));
disp('pos');disp(pos);
disp('angle=');disp(angle);
angle=angle*50; % for rotate stright angle/2

% Rotate in the opposite direction 
%img = imrotate(img, -angle);

    imgRotate = imrotate(imgEmpty,angle,'bilinear','crop');
%     imgRotate = imrotate(imgResizeBin,angle,'bilinear','crop');
     subplot(2,2,3), imshow(imgRotate); title('Rotated Image');
     
    % The rotated image is in grayscale so need to convert binary image
     
    imgRotatedBin=im2bw(imgRotate,0.02);     %0.05
    subplot(2,2,4), imshow(imgRotatedBin); title('Rotated Binary Image');
    
    
    % Remove top and bottom empty rows in the image 
    % OR draw line at the top and bottom 
    % and calculate the height from each pixel in a column to bottom line
    
    % Write Code here
    

% The rotated image is in grayscale so need to extract the RPE layer again

  [Irpe1,yrpe1]=RPE_L_Segmentation(imgRotate);
    
 %   disp('yrep values');
 %   disp(yrpe1);
    
%     figure,
%     imshow(Irpe1);hold on;
%     plot(yrpe1,'r.-')
%     hold off;
%     title('RPE Layer after Rotation');
    
    disp('size(yrpe1)');disp(size(yrpe1));
    
    %lineFilter1=yrpe1;
    lineFilter1=medfilt2(yrpe1,[1 15]); % To remove 0, if it in any col
    
    %if 0 in the starting columns, we need to remove
    for i=1:1:length(lineFilter1)
        if(lineFilter1(i)~=0)
          break;
        end
    end
    
    for j=i-1:-1:1
        lineFilter1(j)=lineFilter1(j+1);
    end
    
    % Remove 0 from the last columns
    for i=length(lineFilter1):-1:1
        if(lineFilter1(i)~=0)
          break;
        end
    end
    
    for j=i+1:1:length(lineFilter1)
        lineFilter1(j)=lineFilter1(j-1);
    end
    
    disp('lineFilter1');disp(lineFilter1);
    
    lineFilter1=round(lineFilter1);
    len1=length(lineFilter1);
    yrpecolor1=1:1:len1;
    for i=1:1:length(lineFilter1)      %array startig index 1
        yrpecolor1(i)=Irpe1(lineFilter1(i),i);
    end
    disp('yrepcolor1 values');
    disp(yrpecolor1);
    
    %If A is a vector, then mode(A) returns the most frequent value of A.
    mfv1=mode(yrpecolor1);
    disp('Most frequent value');
    disp(mfv1);
    
    for i=1:1:length(lineFilter1)      %array startig index 1
        if ((Irpe1(lineFilter1(i),i)>=mfv1 - 0.3)) % && (Irpe(lineFilter(i),i)<=mfv + 0.3))
            Irpe1(lineFilter1(i),i)=1;
        end
    end
    

%     figure; 
%     imshow(Irpe1);hold on;
%     plot(lineFilter1,'r.-')
%     hold off;
    
    len1=length(lineFilter1);
    newyrpe1=1:1:len1;
    newyrpe1(1)=lineFilter1(1);
    preValue1=lineFilter1(1);
    
    % disp(length(yrpe)); % to find length of 1D array
    for i=2:1:length(lineFilter1)      %array startig index 1
        
      if (abs(preValue1-lineFilter1(i))<30)
          newyrpe1(i)=lineFilter1(i);
          %preValue1=lineFilter1(i-1);
      else
          newyrpe1(i)=newyrpe1(i-1);  
      end
      preValue1=newyrpe1(i);
    end

%     figure,
%     imshow(Irpe1);hold on;
%     plot(newyrpe1,'r.-')
%     hold off;
%     title('Removed False Pixels in RPE Layer ');
  
    %axes(handles.axes6);
%     figure,
%     imshow(Irpe1);hold on;
%     plot(newyrpe1,'r.-')
%     hold off;
%     title('Removed False Pixels in RPE Layer');
    
    lineFilter1=medfilt2(newyrpe1,[1 15]);
    
%     figure; 
%     imshow(Irpe1);hold on;
%     plot(lineFilter1,'r.-')
%     hold off;
    
    top=min(lineFilter1);
    bottom=max(lineFilter1);
    disp('top line Y value');disp(top);
    disp('bottom line Y value');disp(bottom);
    
   
    figure; 
    imshow(Irpe1);hold on;
    plot(lineFilter1,'r.-')
    for i=1:1:length(lineFilter1)
        x1=i;
        x2=i;
        y1=lineFilter1(i);
        y2=bottom+3;
        x=[x1 x2];
        y=[y1 y2];
        line(x,y,'Color','green');
    end
    hold off;
    
    
    lineHeight=bottom-lineFilter1;
    disp('lineHeight');disp(lineHeight);
    
    global maxHeight;
    maxHeight=bottom-top;
    disp('maxHeight');disp(maxHeight);
    
    for i=1:1:length(lineHeight)
        if (lineHeight(i)==maxHeight)
            break;
        end
    end
    
    topLeftPoint = i;
    width=maxHeight; % *2; % width taken for checking PED. For width x, 2x width taken because length of PED hole is greater than PED height
                     % We can take width till the height<10 and find the
                     % width, but it should be < 2x
    
    noOfPoints=20;
    distanceBtwnPoints=width/noOfPoints;
    
    leftPoints=zeros(1,noOfPoints);
    leftPoints(1)=maxHeight;
    leftPointsPos=zeros(1,noOfPoints);
    leftPointsPos(1)=topLeftPoint;
    for j=1:1:noOfPoints-1
        if(int16(topLeftPoint-distanceBtwnPoints*j)>0)
            %disp(lineHeight(int16(topLeftPoint-distanceBtwnPoints*j)));
            pos=int16(topLeftPoint-distanceBtwnPoints*j);
            leftPointsPos(j+1)=pos;
            leftPoints(j+1)=lineHeight(pos);
        else
            %disp(maxHeight);
            leftPointsPos(j+1)=1;   % 0;     %No more left points
            leftPoints(j+1)=maxHeight;
        end
    end
    disp('Left points positions from top left point');
    disp(leftPointsPos);
    disp('Left points from top left point');
    disp(leftPoints);
    
    for j=i:1:length(lineHeight)
        if (lineHeight(j)~=maxHeight)
            break;
        end
    end
    
    topRightPoint=j;
    rightPoints=zeros(1,noOfPoints);
    rightPoints(1)=maxHeight;
    rightPointsPos=zeros(1,noOfPoints);
    rightPointsPos(1)=topRightPoint;
    for k=1:1:noOfPoints-1
        if(int16(topRightPoint+distanceBtwnPoints*k)<length(lineHeight))
            %disp(lineHeight(int16(topRightPoint+distanceBtwnPoints*k)));
            pos=int16(topRightPoint+distanceBtwnPoints*k);
            rightPointsPos(k+1)=pos;
            rightPoints(k+1)=lineHeight(pos);
        else
            %disp(maxHeight);
            rightPointsPos(k+1)=length(lineHeight); % 0;  %No more right points
            rightPoints(k+1)=maxHeight;
        end
    end
    disp('Right points positions from top right point');
    disp(rightPointsPos);
    disp('Right points from top right point');
    disp(rightPoints);
    
    leftPointsXY=zeros(2,noOfPoints);
    for i=1:1:noOfPoints
        leftPointsXY(1,i)=leftPointsPos(i);
        leftPointsXY(2,i)=lineFilter1(leftPointsPos(i));
    end
    rightPointsXY=zeros(2,noOfPoints);
    for i=1:1:noOfPoints
        rightPointsXY(1,i)=rightPointsPos(i);
        rightPointsXY(2,i)=lineFilter1(rightPointsPos(i));
    end
    
    figure; 
    imshow(Irpe1);hold on;
%     plot(lineFilter1,'r.-')
    for i=1:1:noOfPoints-1
        x1=leftPointsXY(1,i);
        x2=leftPointsXY(1,i+1);
        y1=leftPointsXY(2,i);
        y2=leftPointsXY(2,i+1);
        x=[x1 x2];
        y=[y1 y2];
        line(x,y,'Color','red');
    end
    x1=leftPointsXY(1,1);
    x2=rightPointsXY(1,1);
    y1=leftPointsXY(2,1);
    y2=rightPointsXY(2,1);
    x=[x1 x2];
    y=[y1 y2];
    line(x,y,'Color','red');
    for i=1:1:noOfPoints-1
        x1=rightPointsXY(1,i);
        x2=rightPointsXY(1,i+1);
        y1=rightPointsXY(2,i);
        y2=rightPointsXY(2,i+1);
        x=[x1 x2];
        y=[y1 y2];
        line(x,y,'Color','red');
    end
    hold off;
    
    figure; 
    imshow(Irpe1);hold on;
%     plot(lineFilter1,'r.-')
    for i=1:1:noOfPoints-1
        x1=leftPointsXY(1,i);
        x2=topLeftPoint; % leftPointsXY(1,i+1);
        y1=leftPointsXY(2,i);
        y2=leftPointsXY(2,1);
        x=[x1 x2];
        y=[y1 y2];
        line(x,y,'Color','red');
    end
    x1=leftPointsXY(1,1);
    x2=rightPointsXY(1,1);
    y1=leftPointsXY(2,1);
    y2=rightPointsXY(2,1);
    x=[x1 x2];
    y=[y1 y2];
    line(x,y,'Color','red');
    for i=1:1:noOfPoints-1
        x1=rightPointsXY(1,i);
        x2=topRightPoint;
        y1=rightPointsXY(2,i);
        y2=rightPointsXY(2,1);
        x=[x1 x2];
        y=[y1 y2];
        line(x,y,'Color','red');
    end
    hold off;
    
    
    % Features:
    %  1. Max Height feature (if maxHeight < 15 then no PED)
    %  2. Position of Max Height.  if Position of maxHeight < first 5
    %     positions or Position of max Height > last 5 positions, then no PED
    %     (for normal images)
    %  3. noOfPoints from top left point
    %  4. noOfPoints from top right point
    
    %Features
    %  1. Max Height feature (if maxHeight < 15 then no PED)
    disp('Feature 1: Max Height');disp(maxHeight);
    
    leftHeight=maxHeight-leftPoints;
    %disp('Left Heights');disp(leftHeight);
    global maxLeftHeight;
    maxLeftHeight=max(leftHeight);
    disp('Feature 2: Max Left Height');disp(maxLeftHeight);
    
    rightHeight=maxHeight-rightPoints;
    %disp('Right Heights');disp(rightHeight);
    global maxRightHeight;
    maxRightHeight=max(rightHeight);
    disp('Feature 3: Max Right Height');disp(maxRightHeight);
    
    % To check no. of Consecutive down points
    global noOfLeftDownPoints;
    global noOfRightDownPoints;
    noOfLeftDownPoints=0;
    noOfRightDownPoints=0;
    for i=2:1:noOfPoints
        if ((leftHeight(i)-leftHeight(i-1))>0)
            noOfLeftDownPoints=noOfLeftDownPoints+1;
        end
        if ((rightHeight(i)-rightHeight(i-1))>0)
            noOfRightDownPoints=noOfRightDownPoints+1;
        end
    end
    
    disp('Feature 4: No. of Consecutive left down points');disp(noOfLeftDownPoints);
    disp('Feature 5: No. of Consecutive right down points');disp(noOfRightDownPoints);
    
     % No need to resize the image now
%     imgResize=imresize(imgRotate,[32 NaN]);
%     subplot(2,2,4), imshow(imgResize); title('Resized RGB Image (32 Rows 65 Cols)');
%     
%     imgResizeBin=im2bw(imgResize,0.05);
%     subplot(2,2,4), imshow(imgResizeBin); title('Resized Binary Image');
    
        
    disp('End of Rotate RPE');

%   User defined function
function Extract_Features(hObject, eventdata, handles)
    global imgGray;
    global imgFil;
    global imgInput;
    global imgBlueRemoved;
    
    clearAxes(hObject, eventdata, handles);
    
    %To display RGB value of 5th row and 5th col pixel
    disp('Input image (RGB)');disp(imgInput(5,5,1));disp(imgInput(5,5,2));disp(imgInput(5,5,3));

    imgBlueRemoved=imgInput;
    imgBlueRemoved(:,:,3)=0;
    %imgBlueRemoved(:,:,2)=0;
    
    axes(handles.axes2);
    imshow(imgBlueRemoved);
    title('After Removing Blue color');
    imgGray=rgb2gray(imgBlueRemoved);
    
%     imgGreenRemoved=imgInput;
%     imgGreenRemoved(:,:,2)=0;
%     axes(handles.axes2);
%     imshow(imgGreenRemoved);
%     title('After Removing Green color');
%     imgGray=rgb2gray(imgGreenRemoved);

    %imgGray=rgb2gray(imgInput);
    
    axes(handles.axes3);
    imshow(imgGray);
    title('Grayscale Image');

    %To display Gray scale value of 5th row and 5th col
    disp('gray scale image');disp(imgGray(5,5));
    
    imgGray=double(imgGray)/255;
    %Igray=Igray/255; %only black and white image 0 and 1
    %Iorg=Igray;
    disp('After divided by 255');disp(imgGray(5,5));
    
    
    imgFil=medfilt2(imgGray,[3 3]);      %plane is not available for grayscale img 
                                            % So use only two variable [height width]
    axes(handles.axes4);
    imshow(imgFil);
    title('Median Filter');
    
    disp('After applying median filter');disp(imgFil(5,5));
    disp(imgFil(:,1));

%     % Wiener filter to reduce speckle noise
%     imgFil = wiener2(imgGray,[3 3]); 
% 
%     axes(handles.axes4);
%     imshow(imgFil);
%     title('Wiener Filter');
%     
%     disp('After applying Wiener filter');disp(imgFil(5,5));
%     disp(imgFil(:,1));

%     BW = edge(imgFil,'canny');
%     figure,
%     imshow(BW);

    
    [Irpe,yrpe]=RPE_L_Segmentation(imgFil);
    
    disp('yrep values');
    disp(yrpe);
    
    axes(handles.axes5);
    imshow(Irpe);hold on;
    %imshow(imgInput);hold on;
    plot(yrpe,'r.-')
    hold off;
    title('RPE Layer with False Pixels');
    
    
%     yrpe=round(yrpe);
%     len=length(yrpe);
%     yrpecolor=1:1:len;
%     for i=1:1:length(yrpe)      %array startig index 1
%         yrpecolor(i)=Irpe(yrpe(i),i);
%     end
%     disp('yrepcolor values');
%     disp(yrpecolor);
%     
%     %If A is a vector, then mode(A) returns the most frequent value of A.
%     mfv=mode(yrpecolor);
%     disp('Most frequent value');
%     disp(mfv);
%     
%     for i=1:1:length(yrpe)      %array startig index 1
%         if ((Irpe(yrpe(i),i)>=mfv - 0.2)) %&& (Irpe(yrpe(i),i)<=mfv + 0.7))
%             Irpe(yrpe(i),i)=1;
%         end
%     end
    
 lineFilter=yrpe;
     %lineFilter=medfilt2(yrpe,[1 15]);
%     disp(lineFilter);


    lineFilter=round(lineFilter);
    len=length(lineFilter);
    yrpecolor=1:1:len;
    for i=1:1:length(lineFilter)      %array startig index 1
        yrpecolor(i)=Irpe(lineFilter(i),i);
    end
    disp('yrepcolor values');
    disp(yrpecolor);
    
    %If A is a vector, then mode(A) returns the most frequent value of A.
    mfv=mode(yrpecolor);
    disp('Most frequent value');
    disp(mfv);
    
    for i=1:1:length(lineFilter)      %array startig index 1
        if ((Irpe(lineFilter(i),i)>=mfv - 0.3)) % && (Irpe(lineFilter(i),i)<=mfv + 0.3))
            Irpe(lineFilter(i),i)=1;
        end
    end
    

    figure; 
    imshow(Irpe);hold on;
    plot(lineFilter,'r.-')
    hold off;
    

%     axes(handles.axes6);
%     imshow(Irpe);hold on;
%     %imshow(imgInput);hold on;
%     plot(lineFilter,'r.-')
%     hold off;
%     title('Image with RPE Layer');
    
%     len=length(yrpe);
%     %newyrpe=zeros(len);
%     newyrpe=1:1:len;
%     newyrpe(1)=yrpe(1);
%     preValue=yrpe(1);
%     
%     % disp(length(yrpe)); % to find length of 1D array
%     for i=2:1:length(lineFilter)      %array startig index 1
%         
%       if (abs(lineFilter(i)-preValue)<15)
%           newyrpe(i)=lineFilter(i);
%           %preValue=lineFilter(i-1);
%       end
%       preValue=lineFilter(i-1);
%     end
% 
%     %axes(handles.axes6);
%     figure,
%     imshow(Irpe);hold on;
%     %imshow(imgInput);hold on;
%     plot(newyrpe)
%     hold off;
%     title('Image with RPE Layer');


    len=length(lineFilter);
    %newyrpe=zeros(len);
    newyrpe=1:1:len;
    newyrpe(1)=lineFilter(1);
    preValue=lineFilter(1);
    
    % disp(length(yrpe)); % to find length of 1D array
    for i=2:1:length(lineFilter)      %array startig index 1
        
      if (abs(preValue-lineFilter(i))<30)
          newyrpe(i)=lineFilter(i);
          %preValue=lineFilter(i-1);
      else
          newyrpe(i)=newyrpe(i-1);  
      end
      preValue=newyrpe(i);
    end

    axes(handles.axes6);
    imshow(Irpe);hold on;
    %imshow(imgInput);hold on;
    plot(newyrpe,'r.-')
    hold off;
    title('Removed False Pixels in RPE Layer ');
  
    %axes(handles.axes6);
    figure,
    imshow(Irpe);hold on;
    %imshow(imgInput);hold on;
    plot(newyrpe,'r.-')
    hold off;
    title('Removed False Pixels in RPE Layer');
    
    lineFilter=medfilt2(newyrpe,[1 15]);
    
    figure; 
    imshow(Irpe);hold on;
    plot(lineFilter,'r.-')
    hold off;
    
    axes(handles.axes7);
    imshow(Irpe);hold on;
    %imshow(imgInput);hold on;
    plot(lineFilter,'r.-')
    hold off;
    title('Smoothing the RPE Layer');
    
    axes(handles.axes8);
    %imshow(Irpe);hold on;
    imshow(imgGray);hold on;
    plot(lineFilter,'r.-')
    hold off;
    title('RPE Layer on Grayscale Image');
    
    axes(handles.axes9);
    %imshow(Irpe);hold on;
    imshow(imgInput);hold on;
    plot(lineFilter,'r.-')
    hold off;
    title('RPE Layer on Original Image');


%%%--------------------------------------------------------
     % create RPE layer on empty/black image
    m=size(imgInput,1);
    n=size(imgInput,2);
    imgEmpty=zeros(m,n);
    %disp('m=');disp(m);
    %disp('n=');disp(n);
    disp(size(lineFilter));
    disp('size(lineFilter,1)');disp(size(lineFilter,1));
    disp('size(lineFilter,2)');disp(size(lineFilter,2));
    disp('lineFilter');
    %disp(lineFilter);
   
   %  minY=min(lineFilter(:,1));
    minY=min(lineFilter);
        
     for i=1:size(lineFilter,2)      % change pixel value to 1 only RPE boundary on empty image/matrix
         imgEmpty(lineFilter(i),i)=1;
     end
     
     figure;
     imshow(imgEmpty);
     %hold on;
     %plot(lineFilter,'y.-');
     %hold off;
     
     figure;
    %imgEmpty(lineFilter(:,1),lineFilter(:,2))=1;
    subplot(2,2,1),imshow(imgEmpty);hold on;  %imgBinary
    %plot(lineFilter,'r.-')
    %plot(lineFilter(:,2),lineFilter(:,1),'y','LineWidth',2);
    hold off;
    title('RPE Layer on Empty Image');

    
  
    
    %lineFilter(:,1)=lineFilter(:,1)-minY+1;
    %disp('lineFilter');disp(lineFilter);

    
%     for i=1:size(lineFilter,2)    % No need to move top so commented
%         lineFilter(i)=lineFilter(i)-minY+1;
%     end
    
%     imgEmpty=zeros(m,n);    % clear the existing RPE layer
%     
%     for i=1:size(lineFilter,2)      % change pixel value to 1 only RPE boundary on empty image/matrix
%          imgEmpty(lineFilter(i),i)=1;
%     end
     
    
%     subplot(2,2,2),imshow(imgEmpty);hold on;  %imgBinary
%     plot(lineFilter,'r.-')
% %     plot(lineFilter(:,2),lineFilter(:,1),'y','LineWidth',2);
%     hold off;
%     title('RPE Layer Moved Top');

% %     %vertical projection
% %     imgVerPro=sum(imgEmpty,1);
% %     %horizontal projection
% %     imgHorPro=sum(imgEmpty,2);
%     
%     
%     % Extract features to apply in Neural Network
%     % Mask size 35 X 35, total 8+1 rows and 16+1 columns
%     
%     disp('m=');disp(m);
%     disp('n=');disp(n);
%     
%     windowX=35;
%     windowY=10; %35 - Working fine for 10 also, for 10 29 rows 17 columns
% %     noCol=ceil(n/windowX);
% %     noRow=ceil(m/windowY);
% %     col=1:noRow*noCol;  %create a col vector
% %     colcount=1;
% %     fileexist=0;
% %     if (exist('MH_mat.mat','file')==2)
% %         load('MH_mat.mat','tr_set');
% %         fileexist=1;
% %     end
%     
%      fid=fopen('output.txt','wb');   %'wb' - delete and write, 'a' - append mode
%      fwrite(fid,'\n');
%     for i=1:windowY:m
%         for j=1:windowX:n
%             %disp('row=');disp(i);
%             %disp('col=');disp(j);
%             if ((i+windowY>m) && (j+windowX>n))
%                 windowMat=imgEmpty(i:m,j:n);
%             elseif (i+windowY>m)
%                 windowMat=imgEmpty(i:m,j:j+windowX);
%             elseif (j+windowX>n)
%                 windowMat=imgEmpty(i:i+windowY,j:n);
%             else
%                 windowMat=imgEmpty(i:i+windowY,j:j+windowX);
%             end
%             %disp(windowMat);
%             if(any(any(windowMat))) %any(A) treates the columns of A as vectors, returning a row vector of 1s and 0s
%                  fwrite(fid,'1 ');
%                 disp('1 '); %i,j=1;
% %                 col(colcount)=1;
% %                 colcount=colcount+1;
%             else
%                  fwrite(fid,'0 ');
%                 disp('0 '); %i,j=0;
% %                 col(colcount)=0;
% %                 colcount=colcount+1;
%             end
%            % x=input('test');
%         end
%         %disp('i=');disp(i);disp('j=');disp(j);
%         
%     end
% %     display(col);
% %     %whos
% %     col=col';
% %     if (fileexist==0)
% %         tr_set=col;
% %     else
% %         tr_set=[tr_set col];
% %     end
% %     save('MH_mat.mat','tr_set');
%     
%      fclose(fid);
% 
% %     disp('Vertical projection');disp(imgVerPro);
% %     disp('Horizontal projection');disp(imgHorPro);
% %     %hist(imgHorPro);
% %     figure, plot(imgHorPro,1:size(imgHorPro,1));
% %     figure, bar(imgHorPro);
% %     
% %     [rows,cols]=size(imgEmpty);
% %     figure, plot(1:cols,imgVerPro,'b-');
% %     figure, plot(imgHorPro,1:rows,'b-');
%     
%     figure, 
%     pause(0.00001);             %maximize the figure window
%     frame_h=get(handle(gcf),'JavaFrame');
%     set(frame_h,'Maximized',1);
% 
%     subplot(2,2,1), imshow(imgEmpty);title('NFL Layer Moved Top');
    
% % To find angle for rotation
% pos = [  lineFilter(1,2) lineFilter(end,2)    % X
%          lineFilter(1,1) lineFilter(end,1)];  % Y 
% % The angle equals the arctangent of dy/dx
% angle = atan2(diff(pos(2,:)), diff(pos(1,:)));
% disp('pos');disp(pos);
% disp('angle=');disp(angle);
% angle=angle*50; % for rotate stright angle/2
% angle=45;
% % Rotate in the opposite direction 
% %img = imrotate(img, -angle);


    disp(lineFilter(1));
    disp(lineFilter(end));
% 
% % To find angle for rotation
% x1=1;
% y1=lineFilter(1);
% x2=size(lineFilter,2);
% y2=lineFilter(end); 
% % The angle equals the arctangent of dy/dx
% angle = atan2d(x1*y2-y1*x2,x1*x2+y1*y2);
% disp('angle=');disp(angle);
% angle=-angle/8; % for rotate stright angle/2
% %angle=45;
% % Rotate in the opposite direction 
% %img = imrotate(img, -angle);

disp('size of lineFilter');disp(size(lineFilter));
% To find angle for rotation
%pos = [  lineFilter(1,2) lineFilter(end,2)    % X
%         lineFilter(1,1) lineFilter(end,1)];  % Y 
pos = [  size(lineFilter,1) size(lineFilter,2)    % X
         lineFilter(1) lineFilter(end)];          % Y 

% The angle equals the arctangent of dy/dx
angle = atan2(diff(pos(2,:)), diff(pos(1,:)));
disp('pos');disp(pos);
disp('angle=');disp(angle);
angle=angle*50; % for rotate stright angle/2

% Rotate in the opposite direction 
%img = imrotate(img, -angle);

    imgRotate = imrotate(imgEmpty,angle,'bilinear','crop');
%     imgRotate = imrotate(imgResizeBin,angle,'bilinear','crop');
     subplot(2,2,3), imshow(imgRotate); title('Rotated Image');
     
    % The rotated image is in grayscale so need to convert binary image
     
    imgRotatedBin=im2bw(imgRotate,0.02);     %0.05
    subplot(2,2,4), imshow(imgRotatedBin); title('Rotated Binary Image');
    
    
    % Remove top and bottom empty rows in the image 
    % OR draw line at the top and bottom 
    % and calculate the height from each pixel in a column to bottom line
    
    % Write Code here
    

% The rotated image is in grayscale so need to extract the RPE layer again

  [Irpe1,yrpe1]=RPE_L_Segmentation(imgRotate);
    
 %   disp('yrep values');
 %   disp(yrpe1);
    
%     figure,
%     imshow(Irpe1);hold on;
%     plot(yrpe1,'r.-')
%     hold off;
%     title('RPE Layer after Rotation');
    
    disp('size(yrpe1)');disp(size(yrpe1));
    
    %lineFilter1=yrpe1;
    lineFilter1=medfilt2(yrpe1,[1 15]); % To remove 0, if it in any col
    
    %if 0 in the starting columns, we need to remove
    for i=1:1:length(lineFilter1)
        if(lineFilter1(i)~=0)
          break;
        end
    end
    
    for j=i-1:-1:1
        lineFilter1(j)=lineFilter1(j+1);
    end
    
    % Remove 0 from the last columns
    for i=length(lineFilter1):-1:1
        if(lineFilter1(i)~=0)
          break;
        end
    end
    
    for j=i+1:1:length(lineFilter1)
        lineFilter1(j)=lineFilter1(j-1);
    end
    
    disp('lineFilter1');disp(lineFilter1);
    
    lineFilter1=round(lineFilter1);
    len1=length(lineFilter1);
    yrpecolor1=1:1:len1;
    for i=1:1:length(lineFilter1)      %array startig index 1
        yrpecolor1(i)=Irpe1(lineFilter1(i),i);
    end
    disp('yrepcolor1 values');
    disp(yrpecolor1);
    
    %If A is a vector, then mode(A) returns the most frequent value of A.
    mfv1=mode(yrpecolor1);
    disp('Most frequent value');
    disp(mfv1);
    
    for i=1:1:length(lineFilter1)      %array startig index 1
        if ((Irpe1(lineFilter1(i),i)>=mfv1 - 0.3)) % && (Irpe(lineFilter(i),i)<=mfv + 0.3))
            Irpe1(lineFilter1(i),i)=1;
        end
    end
    

%     figure; 
%     imshow(Irpe1);hold on;
%     plot(lineFilter1,'r.-')
%     hold off;
    
    len1=length(lineFilter1);
    newyrpe1=1:1:len1;
    newyrpe1(1)=lineFilter1(1);
    preValue1=lineFilter1(1);
    
    % disp(length(yrpe)); % to find length of 1D array
    for i=2:1:length(lineFilter1)      %array startig index 1
        
      if (abs(preValue1-lineFilter1(i))<30)
          newyrpe1(i)=lineFilter1(i);
          %preValue1=lineFilter1(i-1);
      else
          newyrpe1(i)=newyrpe1(i-1);  
      end
      preValue1=newyrpe1(i);
    end

%     figure,
%     imshow(Irpe1);hold on;
%     plot(newyrpe1,'r.-')
%     hold off;
%     title('Removed False Pixels in RPE Layer ');
  
    %axes(handles.axes6);
%     figure,
%     imshow(Irpe1);hold on;
%     plot(newyrpe1,'r.-')
%     hold off;
%     title('Removed False Pixels in RPE Layer');
    
    lineFilter1=medfilt2(newyrpe1,[1 15]);
    
%     figure; 
%     imshow(Irpe1);hold on;
%     plot(lineFilter1,'r.-')
%     hold off;
    
    top=min(lineFilter1);
    bottom=max(lineFilter1);
    disp('top line Y value');disp(top);
    disp('bottom line Y value');disp(bottom);
    
   
    figure; 
    imshow(Irpe1);hold on;
    plot(lineFilter1,'r.-')
    for i=1:1:length(lineFilter1)
        x1=i;
        x2=i;
        y1=lineFilter1(i);
        y2=bottom+3;
        x=[x1 x2];
        y=[y1 y2];
        line(x,y,'Color','green');
    end
    hold off;
    
    
    lineHeight=bottom-lineFilter1;
    disp('lineHeight');disp(lineHeight);
    
    global maxHeight;
    maxHeight=bottom-top;
    disp('maxHeight');disp(maxHeight);
    
    for i=1:1:length(lineHeight)
        if (lineHeight(i)==maxHeight)
            break;
        end
    end
    
    topLeftPoint = i;
    width=maxHeight; % *2; % width taken for checking PED. For width x, 2x width taken because length of PED hole is greater than PED height
                     % We can take width till the height<10 and find the
                     % width, but it should be < 2x
    
    noOfPoints=20;
    distanceBtwnPoints=width/noOfPoints;
    
    leftPoints=zeros(1,noOfPoints);
    leftPoints(1)=maxHeight;
    leftPointsPos=zeros(1,noOfPoints);
    leftPointsPos(1)=topLeftPoint;
    for j=1:1:noOfPoints-1
        if(int16(topLeftPoint-distanceBtwnPoints*j)>0)
            %disp(lineHeight(int16(topLeftPoint-distanceBtwnPoints*j)));
            pos=int16(topLeftPoint-distanceBtwnPoints*j);
            leftPointsPos(j+1)=pos;
            leftPoints(j+1)=lineHeight(pos);
        else
            %disp(maxHeight);
            leftPointsPos(j+1)=1;   % 0;     %No more left points
            leftPoints(j+1)=maxHeight;
        end
    end
    disp('Left points positions from top left point');
    disp(leftPointsPos);
    disp('Left points from top left point');
    disp(leftPoints);
    
    for j=i:1:length(lineHeight)
        if (lineHeight(j)~=maxHeight)
            break;
        end
    end
    
    topRightPoint=j;
    rightPoints=zeros(1,noOfPoints);
    rightPoints(1)=maxHeight;
    rightPointsPos=zeros(1,noOfPoints);
    rightPointsPos(1)=topRightPoint;
    for k=1:1:noOfPoints-1
        if(int16(topRightPoint+distanceBtwnPoints*k)<length(lineHeight))
            %disp(lineHeight(int16(topRightPoint+distanceBtwnPoints*k)));
            pos=int16(topRightPoint+distanceBtwnPoints*k);
            rightPointsPos(k+1)=pos;
            rightPoints(k+1)=lineHeight(pos);
        else
            %disp(maxHeight);
            rightPointsPos(k+1)=length(lineHeight); % 0;  %No more right points
            rightPoints(k+1)=maxHeight;
        end
    end
    disp('Right points positions from top right point');
    disp(rightPointsPos);
    disp('Right points from top right point');
    disp(rightPoints);
    
    leftPointsXY=zeros(2,noOfPoints);
    for i=1:1:noOfPoints
        leftPointsXY(1,i)=leftPointsPos(i);
        leftPointsXY(2,i)=lineFilter1(leftPointsPos(i));
    end
    rightPointsXY=zeros(2,noOfPoints);
    for i=1:1:noOfPoints
        rightPointsXY(1,i)=rightPointsPos(i);
        rightPointsXY(2,i)=lineFilter1(rightPointsPos(i));
    end
    
    figure; 
    imshow(Irpe1);hold on;
%     plot(lineFilter1,'r.-')
    for i=1:1:noOfPoints-1
        x1=leftPointsXY(1,i);
        x2=leftPointsXY(1,i+1);
        y1=leftPointsXY(2,i);
        y2=leftPointsXY(2,i+1);
        x=[x1 x2];
        y=[y1 y2];
        line(x,y,'Color','red');
    end
    x1=leftPointsXY(1,1);
    x2=rightPointsXY(1,1);
    y1=leftPointsXY(2,1);
    y2=rightPointsXY(2,1);
    x=[x1 x2];
    y=[y1 y2];
    line(x,y,'Color','red');
    for i=1:1:noOfPoints-1
        x1=rightPointsXY(1,i);
        x2=rightPointsXY(1,i+1);
        y1=rightPointsXY(2,i);
        y2=rightPointsXY(2,i+1);
        x=[x1 x2];
        y=[y1 y2];
        line(x,y,'Color','red');
    end
    hold off;
    
    figure; 
    imshow(Irpe1);hold on;
%     plot(lineFilter1,'r.-')
    for i=1:1:noOfPoints-1
        x1=leftPointsXY(1,i);
        x2=topLeftPoint; % leftPointsXY(1,i+1);
        y1=leftPointsXY(2,i);
        y2=leftPointsXY(2,1);
        x=[x1 x2];
        y=[y1 y2];
        line(x,y,'Color','red');
    end
    x1=leftPointsXY(1,1);
    x2=rightPointsXY(1,1);
    y1=leftPointsXY(2,1);
    y2=rightPointsXY(2,1);
    x=[x1 x2];
    y=[y1 y2];
    line(x,y,'Color','red');
    for i=1:1:noOfPoints-1
        x1=rightPointsXY(1,i);
        x2=topRightPoint;
        y1=rightPointsXY(2,i);
        y2=rightPointsXY(2,1);
        x=[x1 x2];
        y=[y1 y2];
        line(x,y,'Color','red');
    end
    hold off;
    
    
    % Features:
    %  1. Max Height feature (if maxHeight < 15 then no PED)
    %  2. Position of Max Height.  if Position of maxHeight < first 5
    %     positions or Position of max Height > last 5 positions, then no PED
    %     (for normal images)
    %  3. noOfPoints from top left point
    %  4. noOfPoints from top right point
    
    %Features
    %  1. Max Height feature (if maxHeight < 15 then no PED)
    disp('Feature 1: Max Height');disp(maxHeight);
    
    leftHeight=maxHeight-leftPoints;
    %disp('Left Heights');disp(leftHeight);
    global maxLeftHeight;
    maxLeftHeight=max(leftHeight);
    disp('Feature 2: Max Left Height');disp(maxLeftHeight);
    
    rightHeight=maxHeight-rightPoints;
    %disp('Right Heights');disp(rightHeight);
    global maxRightHeight;
    maxRightHeight=max(rightHeight);
    disp('Feature 3: Max Right Height');disp(maxRightHeight);
    
    % To check no. of Consecutive down points
    global noOfLeftDownPoints;
    global noOfRightDownPoints;
    noOfLeftDownPoints=0;
    noOfRightDownPoints=0;
    for i=2:1:noOfPoints
        if ((leftHeight(i)-leftHeight(i-1))>0)
            noOfLeftDownPoints=noOfLeftDownPoints+1;
        end
        if ((rightHeight(i)-rightHeight(i-1))>0)
            noOfRightDownPoints=noOfRightDownPoints+1;
        end
    end
    
    disp('Feature 4: No. of Consecutive left down points');disp(noOfLeftDownPoints);
    disp('Feature 5: No. of Consecutive right down points');disp(noOfRightDownPoints);
    
     % No need to resize the image now
%     imgResize=imresize(imgRotate,[32 NaN]);
%     subplot(2,2,4), imshow(imgResize); title('Resized RGB Image (32 Rows 65 Cols)');
%     
%     imgResizeBin=im2bw(imgResize,0.05);
%     subplot(2,2,4), imshow(imgResizeBin); title('Resized Binary Image');
    
        
    disp('End of Extract Features function');
        
% --- Executes on button press in Btn_Extract_Features_Excel.
function Btn_Extract_Features_Excel_Callback(hObject, eventdata, handles)
    %global imgGray;
    %global imgFil;
    global imgInput;
    %global imgBlueRemoved;
    
    global maxHeight;
    global maxLeftHeight;
    global maxRightHeight;
    global noOfLeftDownPoints;
    global noOfRightDownPoints;
    filePath='E:\Anand\Sheeba\Code\Images\PED\';  %PED images
    %filePath='E:\Anand\Sheeba\Code\Images\NORMAL\';  %Normal images

    srcFiles=dir(strcat(filePath,'*.jpg'));

    for i=31:40 %length(srcFiles)
        fileName=strcat(filePath,srcFiles(i).name);
        disp(fileName);
        imgInput=imread(fileName);
        %     imshow(fileName);
        
        %Btn_Rotate_RPE_Callback(hObject, eventdata, handles)
        Extract_Features(hObject,eventdata,handles);
        
        tempRow=[maxHeight maxLeftHeight maxRightHeight noOfLeftDownPoints noOfRightDownPoints 1];
        % tar=[ 1 ; 0 ];      %   PED - [1;0]
        % tar=[ 0 ; 1 ];      %   NOR - [0;1]
        fileexist=0;
        if (exist('PED_Features.mat','file')==2)
            load('PED_Features.mat','Features');
            fileexist=1;
        end
        if (fileexist==0)
            Features=tempRow;
        else
            Features=[Features; tempRow];
        end
        save('PED_Features.mat','Features');
        %break;
    end        

    for i=31:40 %length(srcFiles)
        fileName=strcat(filePath,srcFiles(i).name);
        disp(fileName);
    end
    disp('End of Feature Extraction (Excel)');
