/// @description Watch for button touches
var _touchState = get_current_touch();


//OLD CODE BELOW, WE WANT TO HAVE TOUCHMASTER CHECK THE COLLISION FIRST
//switch(_touchState) {
//	case STATES.IDLE:
//	case STATES.SAME_TOUCH:
//		//Do nothing on idle
//		break;
		
//	case STATES.NEW_TOUCH:
//	case STATES.DIFFERENT_TOUCH:
//		//See if we are touching current button
//		if(place_meeting(get_touch_gui_x(), get_touch_gui_y(), self)) {
//			on_click_button();	
//		}
//		break;
		
//	case STATES.RELEASE:
//		if(place_meeting(get_touch_gui_x(), get_touch_gui_y(), self)) {
//			activate_button();	
//		}

	
//}