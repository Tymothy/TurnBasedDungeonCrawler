/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function draw_text_gui(_guiX, _guiY, _string){
	draw_text_transformed(_guiX, _guiY, _string, global.gui_width / NATIVE_WIDTH, global.gui_height / NATIVE_HEIGHT, 0);
}