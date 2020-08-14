function output_txt = custom_cursor(~,event_obj,fig,img,px,px_color_id)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).

global colors_name

warning('on','MATLAB:callback:DeletedSource')
warning('on','MATLAB:callback:error')

if ~strcmp(class(event_obj.Target), 'matlab.graphics.primitive.Image')
    alldatacursors = findall(fig,'type','hggroup');
    for i=1:length(alldatacursors)
        if ~strcmp(class(alldatacursors(i).DataSource), 'matlab.graphics.chart.interaction.dataannotatable.ImageAdaptor')
            delete(alldatacursors(i))
            dcm_obj = datacursormode(fig);
            dt = dcm_obj.createDatatip(img);
            warning('off','MATLAB:callback:DeletedSource')
            warning('off','MATLAB:callback:error')
            return
        end
    end
end

pos = get(event_obj,'Position');
x = pos(1);
y = pos(2);
output_txt = {['XY : [ ',num2str(x),' ',num2str(y),' ]'],...
    ['RGB : [ ',num2str(px(y,x,1)),' ',num2str(px(y,x,2)),' ',num2str(px(y,x,3)),' ]'],...
    string(colors_name(px_color_id(y,x)))};
