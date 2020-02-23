clc; close all; clear all;
object= imaqfind;
delete(object);
Mega = arduino();                            %initialize mega
configurePin(Mega,'D13','DigitalOutput');     % Motor Setup
configurePin(Mega,'D3','DigitalOutput');      % Motor 3 Direction
configurePin(Mega,'D4','DigitalOutput');
configurePin(Mega,'D9','DigitalOutput');      % M3 enabled
configurePin(Mega,'D12','DigitalOutput');     % M5 enabled.
configurePin(Mega,'D6','DigitalOutput');      % M5 Direction
configurePin(Mega,'D7','DigitalOutput');

vid=videoinput('winvideo',3,'YUY2_640x480');
% vid=videoinput('winvideo',2,'YUY2_1280x720');
set(vid,'FramesPerTrigger',Inf);
vid.ReturnedColorSpace='rgb';
vid.FrameGrabInterval=2;
%  writeDigitalPin(Mega,'D12',0);             %to set initial values of motors
%  writeDigitalPin(Mega,'D9',0);
%  writeDigitalPin(Mega,'D6',0);
%  writeDigitalPin(Mega,'D7',0);
%  writeDigitalPin(Mega,'D3',0);
%  writeDigitalPin(Mega,'D4',0);


 start(vid);
 
 while(vid.FramesAcquired<=Inf)                 %increase frames to Inf if you want the loop to be never ending
     data=getsnapshot(vid);                     
     diff_im=imsubtract(data(:,:,1),rgb2gray(data));   %if you want the color to be anything other than red then change the loop
     diff_im=medfilt2(diff_im,[3,3]);                  %median filtering
     diff_im=im2bw(diff_im,0.18);
     diff_im=bwareaopen(diff_im,300);                  
     bw=bwlabel(diff_im,8);
     stats=regionprops(bw,'BoundingBox','Centroid');
     imshow(data);
     hold on;
     for object=1:length(stats)
         bb=stats(object).BoundingBox;
         bc=stats(object).Centroid;
         rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
         plot(bc(1),bc(2),'-m+')      
         disp(bc);      %to see values changing dynamically
%      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %          while bc(2)>240   
% %                % Modify values with our Arduino %change values according to maximum values
% %             writeDigitalPin(Mega,'D12',1);
% %             %writeDigitalPin(Mega,'D12',0);
% %             writeDigitalPin(Mega,'D6',0);
% %             writeDigitalPin(Mega,'D7',1);
% %             disp('down');
% %              data=getsnapshot(vid);                     
% %      diff_im=imsubtract(data(:,:,1),rgb2gray(data));   %if you want the color to be anything other than red then change the loop
% %      diff_im=medfilt2(diff_im,[3,3]);                  %median filtering
% %      diff_im=im2bw(diff_im,0.18);
% %      diff_im=bwareaopen(diff_im,300);                  
% %      bw=bwlabel(diff_im,8);
% %      stats=regionprops(bw,'BoundingBox','Centroid');
% %      imshow(data);
% %      hold on;
% %      for object=1:length(stats)
% %          bb=stats(object).BoundingBox;
% %          bc=stats(object).Centroid;
% %          rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
% %          plot(bc(1),bc(2),'-m+')      
% %          disp(bc);
% %      end
% %             
% %           end
% %         writeDigitalPin(Mega,'D12',0);
% %         writeDigitalPin(Mega,'D6',0);
% %                                                % Loop ends
% %         while bc(2)<210
% % 
% %                                                 %Modify values with our Audruino
% %             writeDigitalPin(Mega,'D12',1);
% %             %writeDigitialPin(Mega,'D12',0);
% %             writeDigitalPin(Mega,'D6',1);
% %             writeDigitalPin(Mega,'D7',0);
% %             disp('up');
% %             bb=stats(object).BoundingBox;
% %          data=getsnapshot(vid);                     
% %      diff_im=imsubtract(data(:,:,1),rgb2gray(data));   %if you want the color to be anything other than red then change the loop
% %      diff_im=medfilt2(diff_im,[3,3]);                  %median filtering
% %      diff_im=im2bw(diff_im,0.18);
% %      diff_im=bwareaopen(diff_im,300);                  
% %      bw=bwlabel(diff_im,8);
% %      stats=regionprops(bw,'BoundingBox','Centroid');
% %      imshow(data);
% %      hold on;
% %      for object=1:length(stats)
% %          bb=stats(object).BoundingBox;
% %          bc=stats(object).Centroid;
% %          rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
% %          plot(bc(1),bc(2),'-m+')      
% %          disp(bc);    
% %      end
% %         end
% %         writeDigitalPin(Mega,'D12',0);
% %         writeDigitalPin(Mega,'D7',0);

                                                   % Change Postition
        while bc(1)>320
         
                                                       % Modify values with our Audruino
            writeDigitalPin(Mega,'D9',1);
           % writeDigitialPin(Mega,'D9',0);
            writeDigitalPin(Mega,'D3',1);
            writeDigitalPin(Mega,'D4',0);
            disp('right');
             data=getsnapshot(vid);                     
     diff_im=imsubtract(data(:,:,1),rgb2gray(data));   %if you want the color to be anything other than red then change the loop
     diff_im=medfilt2(diff_im,[3,3]);                  %median filtering
     diff_im=im2bw(diff_im,0.18);
     diff_im=bwareaopen(diff_im,300);                  
     bw=bwlabel(diff_im,8);
     stats=regionprops(bw,'BoundingBox','Centroid');
     imshow(data);
     hold on;
     for object=1:length(stats)
         bb=stats(object).BoundingBox;
         bc=stats(object).Centroid;
         rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
         plot(bc(1),bc(2),'-m+')      
         disp(bc); 
     end
        end
        writeDigitalPin(Mega,'D9',0);
        writeDigitalPin(Mega,'D3',0);
                                                  % New
        while bc(1)<300
            
                                                   % Modify values with our Audruino
            writeDigitalPin(Mega,'D9',1);
           % writeDigitialPin(Mega,'D9',0);
            writeDigitalPin(Mega,'D3',0);
            writeDigitalPin(Mega,'D4',1);
            disp('left');
             data=getsnapshot(vid);                     
     diff_im=imsubtract(data(:,:,1),rgb2gray(data));   %if you want the color to be anything other than red then change the loop
     diff_im=medfilt2(diff_im,[3,3]);                  %median filtering
     diff_im=im2bw(diff_im,0.18);
     diff_im=bwareaopen(diff_im,300);                  
     bw=bwlabel(diff_im,8);
     stats=regionprops(bw,'BoundingBox','Centroid');
     imshow(data);
     hold on;
     for object=1:length(stats)
         bb=stats(object).BoundingBox;
         bc=stats(object).Centroid;
         rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
         plot(bc(1),bc(2),'-m+')      
         disp(bc);    
     end
        end
        writeDigitalPin(Mega,'D9',0);
        writeDigitalPin(Mega,'D4',0);

     end   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         hold off
 
     
 end
 stop(vid)
 flushdata(vid)

