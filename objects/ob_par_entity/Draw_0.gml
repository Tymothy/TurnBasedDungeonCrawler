/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
image_yscale = PIXEL_ART_SCALE;
image_xscale = PIXEL_ART_SCALE;

draw_set_font(fo_debugNormal);
draw_set_color(c_black);
draw_set_halign(fa_center);
draw_text(x, y - 20, string(property.name) + ":" + string(id));
