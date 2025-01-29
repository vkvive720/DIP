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

histogram = zeros(1, 256);
for i = 1:rows
    for j = 1:cols
        intensity = grayImage(i, j) + 1;
        histogram(intensity) = histogram(intensity) + 1;
    end
end

cdf = zeros(1, 256);
cdf(1) = histogram(1);
for i = 2:256
    cdf(i) = cdf(i - 1) + histogram(i);
end

cdf_min = min(cdf);
total_pixels = rows * cols;

equalizedImage = zeros(rows, cols, 'uint8');
for i = 1:rows
    for j = 1:cols
        intensity = grayImage(i, j) + 1;
        equalizedValue = round(((cdf(intensity) - cdf_min) / (total_pixels - cdf_min)) * 255);
        equalizedImage(i, j) = uint8(equalizedValue);
    end
end

figure;
subplot(1, 3, 1);
imshow(image);
title('Original RGB Image');

subplot(1, 3, 2);
imshow(grayImage);
title('Grayscale Image');

subplot(1, 3, 3);
imshow(equalizedImage);
title('Histogram Equalized Image');
