% reader.m
% 
% This script reads all 400 of the 112x92 face images 
% from the Cambridge University Database of Faces
% (http://www.cl.cam.ac.uk/research/dtg/attarchive/facedatabase.html)
% into a single matrix of size 10304x400.  
%
% Inputs:  None (the script must be executed from the `att_faces'
%                root directory)
% Outputs: Training data matrix 'training.mat'
%          Test data matrix 'test.mat'
%


clear all
close all

% The images in the database are each 112x92.
% Thus, the vectorized version of each image is 10304x1.
Z = zeros(10304,360);
T = zeros(10304,40);
inx1 = 1;
inx2 = 1;

for i=1:40
    foldername = ['s',num2str(i)];
    cd(['./',foldername]);
    for j = 1:10
        filename = [num2str(j),'.pgm'];
        tempimage = double(imread(filename));
        
        % tempimage is a 112x92 image...the command
        % tempimage(:) vectorizes the image by stacking
        % its columns to form a 10304x1 vector
        vectorizedimage = tempimage(:);
        
        if (j==10)
            T(:,inx2) = vectorizedimage;
            inx2 = inx2 + 1;
        else
            Z(:,inx1) = vectorizedimage;
            inx1 = inx1 + 1;
        end
        
        % Uncomment the four lines below the blank comment if you 
        % want to see each of the images as they get cycled through...
        %
        %reshapedimage = reshape(vectorizedimage, 112,92);
        %imagesc(reshapedimage); colormap gray; axis equal;
        %drawnow;
        %pause(0.01);
        
    end
    cd('..');
end
    
save 'training.mat' 'Z'
save 'test.mat' 'T'
clear all