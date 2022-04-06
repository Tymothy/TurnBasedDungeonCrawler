/// @description Draw Red Box
draw_set_font(fo_debugNormal);
draw_set_color(c_red);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_text(x, y, string(value));
//draw_rectangle(x - irandom(6), y - irandom(6), x + irandom(6), y + irandom(6), false);
