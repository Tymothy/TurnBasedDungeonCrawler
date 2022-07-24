/// @description Watch for button touches
var _touchState = get_current_touch();

switch(_touchState) {
	case STATES.IDLE:
	case STATES.SAME_TOUCH:
		//Do nothing on idle
		break;
		
	case STATES.NEW_TOUCH:
		//See if we are touching current button
		place_meeting(get_touch_gui_x(), get_touch_gui_y(), self) {
				
		}
	

	
}