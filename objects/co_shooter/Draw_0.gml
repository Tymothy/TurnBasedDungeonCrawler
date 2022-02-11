/// @description Insert description here
// You can write your code in this editor

//draw_line_width(startX, startY, currentX, currentY, 7);
var _dist = point_distance(startX, startY, currentX, currentY);
if(_dist < minDist) {
	draw_set_color(c_maroon);
}
else {
	draw_set_color(c_lime);	
}


draw_line_width(x, y, x + startX - currentX, y + startY - currentY, 3);