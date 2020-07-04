%********info********************************************************************************
 % file: false_edge_detection_remover.m
 % brief: This code filters the unwanted co_ordinates of false edge
 % detection
 
 % This code contains the following steps    
 % step_1:_file_location_on_images
 % step_2:_reading_image_and_editing
 % step_3:_edge_detection_and_finding_co-ordinates
 % step_4:_operating_and_filtering_the_co-ordinate_vectors
 % step_5:_plots_and_images
 % step_6:_function_definition

 
 % author            : Nitish Wadhavkar
 
 % date of creation  : 1st ‎July ‎2020  
 % date of completion: 4th July 2020
 
%********__CODE__*****************************************************************************

%-------step_1:_file_location_on_images--------------------------------------------------------

filename='';            %enter the file loacation where the image is stored 

%----------------------------------------------------------------------------------------------

%-------step_2:_reading_image_and_editing------------------------------------------------------

img = imread(filename); %read the image in the matrix
img = rgb2gray(img);    %convert to grayscale

%----------------------------------------------------------------------------------------------

%-------step_3:_edge_detection_and_finding_co-ordinates-----------------------------------------

ed_img = edge(img,'prewitt');  %edge detection of image
[y, x]   = find(ed_img);       %store the co-ordinates of edges in y & x
co_ord_1=[y ,x];                 %store it in a variable

%-----------------------------------------------------------------------------------------------

%-------step_4:_operating_and_filtering_the_co-ordinate_vectors---------------------------------

Y = co_ord_1(:,1);               %separate the y co-ordinates in Y vector
Y=remove_false_edges(Y);         %remove the unwanted y co-ordinates of false edges

X = co_ord_1(:,2);               %separate the x co-ordinates in X vector
X=remove_false_edges(X);         %remove the unwanted x co-ordinates of false edges

%------------------------------------------------------------------------------------------------

%--------step_5:_plots_and_images-----------------------------------------------------------------

figure(1),imshow(img);
figure(2),imshow(ed_img);
figure (3),scatter(X,Y);

%-------------------------------------------------------------------------------------------------

%--------step_6:_function_definition--------------------------------------------------------------

function co_ord_vector = remove_false_edges(co_ord_vector)    %define function

mode_co_ord_vector=mode(co_ord_vector);             %store the mode of co-ordinate vectors in variable
mode_up_co_ord_vector=mode_co_ord_vector;           %enter mode value in up variable
mode_down_co_ord_vector=mode_co_ord_vector;         %enter mode value in down variable
co_ord_vector_new=[mode_co_ord_vector;mode_co_ord_vector];   %define new vector 
for index=1:1:size(co_ord_vector)                             %for loop running for co-ordinate vector size times
    res_up = ismember(mode_up_co_ord_vector,co_ord_vector);   %checking if element is a part of that vector while tranversing up
    res_down = ismember(mode_down_co_ord_vector,co_ord_vector); %checking if element is a part of that vector while tranversing down
    if res_up==1                               %if present in the vector
        co_ord_vector_new = [co_ord_vector_new; mode_up_co_ord_vector];%add useful element to new vector
        mode_up_co_ord_vector=mode_up_co_ord_vector+1;%increment up variable
    end
    if res_down==1                             %if present in the vector
        co_ord_vector_new = [co_ord_vector_new; mode_down_co_ord_vector];%add useful element to new vector
        mode_down_co_ord_vector=mode_down_co_ord_vector-1;%decrement down variable
    end
    if res_up==0                               %if not present in the vector
        mode_up_co_ord_vector=mode_co_ord_vector; %reload up vector
    end
    if res_down==0                             %if not present in the vector
        mode_down_co_ord_vector=mode_co_ord_vector; %reload down vector
    end
end    

indices = (abs(co_ord_vector)<min(co_ord_vector_new))|(abs(co_ord_vector)>max(co_ord_vector_new)); %find range of useful co-ordinates
co_ord_vector(indices) = []; %delete unwanted elements from co-ordinate vector

end
