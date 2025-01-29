% Read the input image
image = imread('input_image.jpg');

% Ensure the image is grayscale
[rows, cols, channels] = size(image);
if channels == 3
    image = 0.2989 * double(image(:, :, 1)) + ...
            0.5870 * double(image(:, :, 2)) + ...
            0.1140 * double(image(:, :, 3));
    image = uint8(image);
end

% Initialize an array to hold bit-sliced images
bitSlicedImages = zeros(rows, cols, 8, 'uint8');

% Perform bit slicing
for bit = 0:7
    bitSlicedImages(:, :, bit + 1) = bitget(image, bit + 1) * 2^bit;
end

% Compute the size of the original image
originalSize = numel(image);

% Compute the size of each bit-sliced image
slicedSize = numel(bitSlicedImages(:, :, 1));

% Display the original image
figure;
subplot(3, 3, 1);
imshow(image);
title('Original Image');

% Display the bit-sliced images
for bit = 0:7
    subplot(3, 3, bit + 2);
    imshow(bitSlicedImages(:, :, bit + 1));
    title(['Bit ' num2str(bit)]);
end

% Print the sizes
fprintf('Original Image Size: %d bytes\n', originalSize);
fprintf('Each Bit-Sliced Image Size: %d bytes\n', slicedSize);
