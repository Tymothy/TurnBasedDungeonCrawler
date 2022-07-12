/// @description Show instance exists
//draw_rectangle(global.gui_width * .6, global.gui_height * .01, global.gui_width * .99, global.gui_height * .2, false);
//set_debug_font();

//draw_set_color(c_lime);
//draw_set_halign(fa_right);
//draw_text(global.gui_width * .97, global.gui_height * .03, "Debugger active");
//if(wait == false) {
//	if(instance_exists(co_gameManager)) {
//		draw_text(global.gui_width * .97, global.gui_height * .06, "Current Floor: " + string(co_gameManager.game.currentFloor));		
//		draw_text(global.gui_width * .97, global.gui_height * .09, "Current Room Type: " + string(co_gameManager.currentRoomType));		

//	}
//}

//if(instance_exists(co_grid)) {
//draw_text(global.gui_width * .97, global.gui_height * .09, "grid exists");		
//}


//if(instance_exists(co_roomGen)) {
//draw_text(global.gui_width * .97, global.gui_height * .12, "roomGen exists");		
//}

//if(instance_exists(co_spawnManager)) {
//draw_text(global.gui_width * .97, global.gui_height * .15, "spawnManager exists");		
//}

//Draw a grid on GUI
if(false) {
	draw_set_alpha(.2);
	draw_set_color(c_gray);
	draw_rectangle(global.gui_width/2 - 1, 0, global.gui_width/2 + 1, global.gui_height, false);
	draw_rectangle(0, global.gui_height/2 - 1, global.gui_width, global.gui_height/2 + 1, false);

	draw_rectangle(global.gui_width/2 - 1, 0, global.gui_width/2 + 1, global.gui_height, false);
	draw_set_alpha(1);
}

if(false) {
	//Draw around the playable area
	draw_set_alpha(.5);
	draw_set_color(c_lime);
	var _x1 = global.guiPlayableX1;
	var _y1 = global.guiPlayableY1;
	var _x2 = global.guiPlayableX2;
	var _y2 = global.guiPlayableY2;
	
	draw_rectangle(_x1, _y1, _x2, _y2, true);
	draw_set_alpha(1);
}