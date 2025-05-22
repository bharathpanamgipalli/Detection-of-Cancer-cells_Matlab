pkg load image;
image = imread('Cancer_cells.png');
grayImage = rgb2gray(image);
filteredImage = medfilt2(grayImage, [3 3]);
enhancedImage = imadjust(filteredImage);
threshold = graythresh(enhancedImage);
binaryImage = enhancedImage > threshold * 255;
binaryImage = bwareaopen(binaryImage, 100);
binaryImage = imfill(binaryImage, 'holes');
[L, num] = bwlabel(binaryImage);
stats = regionprops(L, 'BoundingBox', 'Centroid');
figure, imshow(image);
hold on;
for i = 1:num
    bbox = stats(i).BoundingBox;
    rectangle('Position', bbox, 'EdgeColor', 'r', 'LineWidth', 2);
    plot(stats(i).Centroid(1), stats(i).Centroid(2), 'bo', 'MarkerSize', 5, 'LineWidth', 2);
end
hold off;
title('Detected Cancer Cells with Bounding Boxes');
