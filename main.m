clear; close all

global colors_name

load('colors_rgb.mat')
load('colors_name.mat')

pic_filename = uigetfile({'*.jpg;*.jpeg;*.png','Image Files (*.jpg,*.jpeg,*.png)';...
    '*.*','All Files (*.*)'},'Select a picture');

pic = imread(pic_filename);
px = double(imresize(pic, [128 128]));
px_color_id = uint8([]);

for i=1:size(px,1)
    for j=1:size(px,2)
        [matched_color_rgb, matched_color_id] = color_match(reshape(px(i,j,:),[1 3]), colors_rgb);
        px(i,j,:) = reshape(matched_color_rgb, [1 1 3]);
        px_color_id(i,j) = matched_color_id;
    end
end

px = uint8(px);

fig = figure;
dcm = datacursormode(fig);
hold on
axis image
axis ij

img = imagesc(px);

set(dcm,'UpdateFcn',{@custom_cursor,fig,img,px,px_color_id})
set(dcm,'Enable','on')
dt = dcm.createDatatip(img);
set(dt,'Position',[1,1,0])

for i=0.5:128.5
    plot([i i],[0.5 128.5],'Color',[0.9 0.9 0.9])
    plot([0.5 128.5],[i i],'Color',[0.9 0.9 0.9])
end

for i=0.5:16:128.5
    plot([i i],[0.5 128.5],'Color',[0.5 0.5 0.5])
    plot([0.5 128.5],[i i],'Color',[0.5 0.5 0.5])
end

hold off