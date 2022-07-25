/// @description Init
//Create a ds grid that will hold locations of all touches on screen

//When an indicator is created, store it's ID, my_touchVar, x, and y
touchGrid = ds_grid_create(11, 8);
ds_grid_clear(touchGrid,-1);

/*
TOUCH_STATE can be any of hte following:
IDLE
NEW_TOUCH
SAME_TOUCH
DIFFERENT_TOUCH
RELEASE
*/

TOUCH_STATE = STATES.IDLE;
touchChange = false;
oldTouchState = STATES.IDLE;

	
currentTouch = -1; //used to track the current touch to work with later on
gridX = -1;
gridY = -1;
			
oldTouch = currentTouch;
oldGridX = gridX;
oldGridY = gridY;
			
hasTouch = false; //True when we are tracking a touch
dragging = false;

//Track the touch values we want to run logic on
touchX = -1;
touchY = -1;
touchGuiX = -1;
touchGuiY = -1;
#region Methods
touch_reset = function() {
	touchX = -1;
	touchY = -1;
	touchGuiX = -1;
	touchGuiY = -1;
}

touch_set = function() {
	touchX = ds_grid_get(co_touchMaster.touchGrid, currentTouch, 2);	
	touchY = ds_grid_get(co_touchMaster.touchGrid, currentTouch, 3);
	touchGuiX = ds_grid_get(co_touchMaster.touchGrid, currentTouch, 4);
	touchGuiY = ds_grid_get(co_touchMaster.touchGrid, currentTouch, 5);
	
}

touch_button_check = function() {
	
	
}
#endregion