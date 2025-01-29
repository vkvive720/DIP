image = imread('input_image.jpg');
[rows, cols, channels] = size(image);

if channels ~= 3
    error('Input image is not an RGB image.');
end

grayImage = zeros(rows, cols, 'uint8');

for i = 1:rows
    for j = 1:cols
        red = double(image(i, j, 1));
        green = double(image(i, j, 2));
        blue = double(image(i, j, 3));
        grayValue = 0.2989 * red + 0.5870 * green + 0.1140 * blue;
        grayImage(i, j) = uint8(grayValue);
    end
end

figure;
subplot(1, 2, 1);
imshow(image);
title('Original RGB Image');

subplot(1, 2, 2);
imshow(grayImage);
title('Grayscale Image');
