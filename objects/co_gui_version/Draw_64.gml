/// @description Draw Version
draw_set_font(fo_debugNormal);
draw_set_halign(fa_left);
draw_set_valign(fa_bottom)
draw_set_color(c_ltgray);
draw_text_gui(gw * .03, gh * .97, global.gameVersion);
