/// @description Show the players current health

draw_set_font(fo_debugNormal);
draw_set_color(c_red);
draw_set_halign(fa_right);
draw_set_valign(fa_top)

if(instance_exists(ob_player)) {
	draw_text_gui(gw * .97, gh * .03, "Player Health: " + string(ob_player.property.hp));
}
