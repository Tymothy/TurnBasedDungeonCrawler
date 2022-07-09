/// @description Fullscreen Toggle

if(window_get_fullscreen())
{
	//We are in full screen, change to windowed
	show_debug_message("Changing to windowed mode");
	co_camera.set_window(3);	
	
	
} 
else {
	show_debug_message("Changing to fullscreen mode");
	co_camera.set_fullscreen();
}
