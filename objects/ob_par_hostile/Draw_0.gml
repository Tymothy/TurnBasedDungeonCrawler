/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
draw_self();

//Draw instance IDs for debugging
draw_set_font(fo_debugSmall);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_alpha(.4);
draw_set_color(c_black);
draw_rectangle(x - 13, y - 10, x + 13, y, false);
draw_set_alpha(1);
draw_set_color(c_orange);
draw_text(x, y - 5, string(id));