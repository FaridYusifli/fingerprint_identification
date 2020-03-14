%compute image coherence 
function [imgCoherence] = compImgCoh(imgOrientation)
    [height,width]   =   size(imgOrientation);
    imgCoherence    =   zeros(height,width);
    N=2;
    imgOrientation    =   [flipud(imgOrientation(1:N,:));imgOrientation;flipud(imgOrientation(height-N+1:height,:))]; 
    % -we flip array in up down direction
    imgOrientation    =   [fliplr(imgOrientation(:,1:N)),imgOrientation,fliplr(imgOrientation(:,width-N+1:width))]; 
    % -we flip array in left right direction
    
    
    % - computing coherence
          for i=N+1:height+N
        for j = N+1:width+N
            th  = imgOrientation(i,j);
            blk = imgOrientation(i-N:i+N,j-N:j+N);
            imgCoherence(i-N,j-N)=sum(sum(abs(cos(blk-th))))/((2*N+1).^2);
              % -(low coherence=0,1-high)
        end;
    end;