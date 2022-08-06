/// @description Watch for button touches
touchState = get_touch_state_on_change();
touchX = get_touch_gui_x();
touchY = get_touch_gui_y();
releaseX = get_touch_release_gui_x();
releaseY = get_touch_release_gui_y();
//OLD CODE BELOW, WE WANT TO HAVE TOUCHMASTER CHECK THE COLLISION FIRST
update();
switch(touchState) {
	case STATES.IDLE:
	case STATES.SAME_TOUCH:
		//Do nothing on idle
		break;
		
	case STATES.NEW_TOUCH:
	case STATES.DIFFERENT_TOUCH:
		//See if we are touching current button
		if(point_in_rectangle(touchX, touchY, x1, y1, x2, y2)) {
			on_click_button();	
		}
		break;
		
	case STATES.RELEASE:
		if(point_in_rectangle(releaseX, releaseY, x1, y1, x2, y2)) {
			interact();
			show_debug_message("Interact with button");
		}
		break;	
}

if(clicked == true && !point_in_rectangle(touchX, touchY, x1, y1, x2, y2)) {
	unclick_button();	
}