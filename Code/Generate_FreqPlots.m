% Function to plot the radial and tangential profile of the reconstructed
% Shepp Logan Phantom

% Objective of this function is to animate the roi of the image and show
% its radial and tangential plots with delay of with a pause
% Function expects the files to be present in the current working
% directory

%N V Kartheek, 200531003, March 19th 2009
% Written for the purpose of R & D show case 2009


function images=Generate_FreqPlots()

%Names of Input Files
choice =2;

files = {{'U_0.txt', 'H1_0.txt' , 'H12_0.txt';}  % Files arranged in different
    {'U_2.txt', 'H1_2.txt' , 'H12_2.txt';}  % According to their upsampling factors
    {'U_4.txt', 'H1_4.txt' , 'H12_4.txt';}
    {'U_6.txt', 'H1_6.txt' , 'H12_6.txt';}}

images ={};

roi =  {};
freq={}

default_size  = 10;  % Default size of ROI
factor = [1 2 4 6];  % Upsampling factors of the images in various sets given above

for i = 1:4
    figure(1),hold on;
   % figure(2),hold on;

    rad_profiles = []; % Radial Profiles
    tan_profiles = []; % Tangential Profiles

    for j=1:3

        X=39*factor(i); % Shift in the image roi center's X coordinate with respect to image center

        images{(i-1)*4+j} = dlmread(files{i}{j}); % Reading the image matrix
        temp = images{(i-1)*4+j};
        roi{(i-1)*4+j} = temp((end/2+X)-default_size*factor(i):(end/2+X)+default_size*factor(i),(end/2)-default_size*factor(i):(end/2)+default_size*factor(i));
        clear temp;
    end

    for k=default_size*factor(i)-5:default_size*factor(i)+5
        for j=1:3
            temp = roi{(i-1)*4+j};
            color_temp =[];            % Preparing Image for Showing it on Animation
            color_temp(:,:,1) = temp;
            color_temp(:,:,2) = temp;
            color_temp(:,:,3) = temp;
            color_temp1 = color_temp;



            color_temp(:,k,4-j)=max(temp(:));
            color_temp1(k,:,4-j)=max(temp(:));
            profiles(j,:) = temp(:,k)';
            profiles1(j,:) = temp(k,:);

          if(choice==1)
            figure(1),subplot(3,3,j),imshow(color_temp),title(files{i}{j}(1:end-4));
          else
            figure(1),subplot(3,3,j),imshow(color_temp1);
          end



        end
        if(choice==1)
        figure(1),subplot(3,3,j+3:j+6),plot(profiles'),axis([1 default_size*factor(i)*2+1 0 max(temp(:))*1.2]),legend(files{i});
        pause(1);
        else
        figure(1),subplot(3,3,j+3:j+6),plot(profiles1'),axis([1 default_size*factor(i)*2+1 0 max(temp(:))*1.2]),legend(files{i});
        pause(0.5);
        end
        clear profiles;
        clear profiles1;
    end

    close all;
end