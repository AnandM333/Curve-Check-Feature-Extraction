function [ImedRPENew,yrpe]=RPE_L_Segmentation(Imed)
    y=(1:size(Imed,1))';     % size(Imed,1) => No. of y axis (pixels)  297 x 170 ==> 170
    x=(1:size(Imed,2))';     % size(Imed,2) => No. of x rows (pixels)  297 x 170 ==> 297
    %disp(x); 
    %disp(y);
    disp('size(Imed)');
    disp(size(Imed));        % 170 297
    
    yrpe= [] ;
    Ik=zeros(size(Imed));
    %disp(Ik);
    
    % Test Code Starts
    %disp(max(Imed(:,1)));
    %disp(max(Imed(:,1))*0.9);
    %disp(Imed(:,1)>(max(Imed(:,1))*0.9));
    %disp('bwlabel');
    %disp(bwlabel(Imed(:,1)>(max(Imed(:,1))*0.9)));
    Ila=bwlabel(Imed(:,1)>(max(Imed(:,1))*0.9));
    x_best=[];
    xl=y(Ila==1);
    x_best=[x_best;mean(xl)] ;
    disp('xl');disp(xl);disp('mean(xl)');disp(mean(xl));disp('x_best');disp(x_best);
    xl=y(Ila==2);
    x_best=[x_best;mean(xl)] ;
    disp('xl');disp(xl);disp('mean(xl)');disp(mean(xl));disp('x_best');disp(x_best);
    xl=y(Ila==3);
    x_best=[x_best;mean(xl)] ;
    disp('xl');disp(xl);disp('mean(xl)');disp(mean(xl));disp('x_best');disp(x_best);
    yr=[];
    yr(1)=max(x_best);
    yr(2)=2;
    disp('yr');disp(yr);
    disp(mat2gray(Ila*0.5)+Imed(:,1));
    % Test Code Ends
    
    
    for ik=1:size(Imed,2)
        xx_best=[];
        Ilabp=bwlabel(Imed(:,ik)>(max(Imed(:,ik))*0.9));
        %disp();
        Ik(:,ik)=Ilabp;
        %disp(Ik);
        for tt=1:max(Ilabp)
            xxl=y(Ilabp==tt);
            xx_best=[xx_best;mean(xxl)] ;
        end
        if ~isempty(xx_best)
            yrpe(ik)=max(xx_best);
        else
            yrpe(ik)=0;
        end
    end

      
%     figure; 
%     pause(0.00001);             %maximize the figure window
%     frame_h=get(handle(gcf),'JavaFrame');
%     set(frame_h,'Maximized',1);
% %     subplot(2,2,1),imshow(mat2gray(Ik*0.5+Imed));hold on;
%     imshow(mat2gray(Ik*0.5+Imed));hold on;
%     plot(yrpe,'r.-')
%     hold off;
    
    ImedRPENew=mat2gray(Ik*0.5+Imed);