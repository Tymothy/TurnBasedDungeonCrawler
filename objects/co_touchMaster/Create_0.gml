/// @description Init
//Create a ds grid that will hold locations of all touches on screen

//When an indicator is created, store it's ID, my_touchVar, x, and y
touchGrid = ds_grid_create(11, 8);
ds_grid_clear(touchGrid,-1);

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