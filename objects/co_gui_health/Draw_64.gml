/// @description Show the players current health

draw_set_font(fo_debugNormal);
draw_set_color(c_red);
draw_set_halign(fa_right);

if(instance_exists(ob_player)) {
	draw_text(global.gui_width - 5, 5, "Player Health: " + string(ob_player.property.hp));
}
