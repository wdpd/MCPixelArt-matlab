function [matched_color_rgb, matched_color_idx] = color_match(color, colors_rgb)

colors_d = sqrt((colors_rgb(:,1)-color(1,1)).^2 + ...
                (colors_rgb(:,2)-color(1,2)).^2 + ...
                (colors_rgb(:,3)-color(1,3)).^2);

[~,matched_color_idx] = min(colors_d);
matched_color_rgb = colors_rgb(matched_color_idx,:);

end