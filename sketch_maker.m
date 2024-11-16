clc
clear
%% THIS CODE DOES NOT HAVE AN INTERACTIVE COMPONENT. TO HAVE AN INTERACTIVE COMPONENT, THE MATLAB APP MUST BE USED.
%% IN THIS CODE, THERE ARE FIXED SIZES FOR EACH FILTER, UNLIKE THE MATLAB DESIGNED APP
%% READING IMAGE FROM DEVICE OR USING WEBCAM TO CAPTURE LIVE IMAGE
cam = webcam;
cam.Resolution = '1280x720';
img1 = snapshot(cam);
clear cam;

%% DISPLAYING IMAGE
imshow(img1)

%% CONVERTING TO GRAYSCALE IMAGE FOR EDGE DETECTION AND IMAGE MORPHOLOGY
img1 = im2gray(img1);
imwrite(img1,"C:\Users\Veer Mukadam\OneDrive\Pictures\img_gray.jpg");

%% AVERAGE FILTER (LOW PASS FILTER) TO BLUR OUT ANY UNNECESSARY NOISE IN THE IMAGE
f1 = fspecial("average",5);
img1 = imfilter(img1,f1);
imwrite(img1,"C:\Users\Veer Mukadam\OneDrive\Pictures\img_denoise.jpg");

%% FILTERED IMAGE WITH REDUCED NOISE
imshow(img1)

%% USING LOG TRANSFORM TO ENHANCE DARKER REGIONS AND POWER TRANSFORM TO IMPROVE CONTRAST
%% THE VALUE OF GAMMA IS PREFIXED, BUT CAN BE TAKEN AS INPUT FROM USER
img1 = double(img1);
img1 = 255*0.79*log(1 + img1)/log(256);
img1 = 2.5*((img1).^4.5)*255/((256)^4.5);
img1 = uint8(img1);
imwrite(img1,"C:\Users\Veer Mukadam\OneDrive\Pictures\img_trans.jpg");


%% INVERTING THE IMAGE
img2 = 255 - img1;
imshow(img2)
imwrite(img2,"C:\Users\Veer Mukadam\OneDrive\Pictures\img_inv.jpg");

%% WE PASS THE INVERTED IMAGE THROUGH AN AVERAGE FILTER TO SMOOTHEN THE EDGES
%% THIS PRESERVES THE BULK OF THE IMAGE, BUT SMOOTHENS OUT SHARP EDGES, WHICH WERE PRESENT IN ORIGINAL IMAGE
%% THE FILTER SIZE CAN VARY ACCORDING TO IMAGE.

fil = fspecial("average",15);
img2 = imfilter(img2,fil);
imwrite(img2,"C:\Users\Veer Mukadam\OneDrive\Pictures\img_inv_blur.jpg");

%% SINCE THE INVERTED IMAGE IS BLURRED AT THE EDGES, THE ADDITION OF OF BOTH IMAGES WILL RESULT IN 255 PIXEL VALUE IN THE BLUK
%% AND A VALUE BETWEEN 0 AND 255 AT THE EDGES. 
%% THIS WAY, WE CAN EXTRACT THE EDGES FROM THE IMAGE. THE INTENSITY OF THE EDGES IS STILL PROPORTIONATE LIKE THE IMAGE
%% WHICH GIVES THE RESULT A CARICATURE LIKE LOOK

filtered_img = img2 + img1;
imwrite(filtered_img,"C:\Users\Veer Mukadam\OneDrive\Pictures\img_sketch.jpg");

%% WE INCREASE THE CONTRAST OF THE RESULT TO OBTAIN A VISUALISTICALLY BETTER IMAGE
filtered_img = imadjust(filtered_img);
imwrite(filtered_img,"C:\Users\Veer Mukadam\OneDrive\Pictures\img_sketch_cont.jpg");

imshow(filtered_img)

