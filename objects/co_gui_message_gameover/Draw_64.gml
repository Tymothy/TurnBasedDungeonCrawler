/// @description Show the players current health

draw_set_font(fo_alert);
draw_set_color(c_red);
draw_set_halign(fa_middle);
draw_set_valign(fa_center);

if(instance_exists(ob_player)) {
	draw_text_gui(gw * .5, gh * .5, "Game Over");
	
}
