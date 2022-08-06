/// @description Draw to GUI
update();
draw_set_color(drawColor);
draw_rectangle(x1, y1, x2, y2, false);

draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_color(c_black);
draw_text_gui((x1 + x2) / 2, (y1 + y2) / 2, property.text);

