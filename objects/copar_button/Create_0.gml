/// @description Create parent button
property = {
	text : "NaN",
	anchor : ANCHOR.TOP_RIGHT,
	x : 0, //Tiles offset from anchor
	y : 0, //Tiles offset from anchor
	width : 2, //In tiles
	height : 1, //In tiles
	defaultColor : c_gray,
	onClickColor : c_white,
	//Possibly could be improved by adding a list element here to create like a dropdown?
}

//Init variables
drawColor = c_aqua;
active = true;
clicked = false;
touchState = get_touch_state_on_change();
gh = global.gui_height;
gw = global.gui_width;
tile = global.gui_tile_size;
anchorX = 0;
anchorY = 0;
realWidth = 0;
realHeight = 0;
//Offsets set by anchoring to anchor correctly
anchorOffsetX = 0; 
anchorOffsetY= 0;

create_update = function() {
	drawColor = property.defaultColor;	
}

update = function() {
	
	realWidth = property.width * tile;
	realHeight = property.height * tile;
	get_anchor();
	//BUG: Button is showing off screen with the anchor
	x1 = anchorX + (property.x * tile) + anchorOffsetX;
	y1 = anchorY + (property.y * tile) + anchorOffsetY;
	x2 = x1 + realWidth;
	y2 = y1 + realHeight;
}

activate_button = function() {
	show_debug_message("Default activate_button message.");
}

interact_button = function() {
	show_debug_message("Default interact_button message.");
}

on_click_button = function() {
	show_debug_message("Default on_click_button message.");
}

get_anchor = function() {
	var _hw = realWidth / 2; //half the width of the button
	var _hh = realHeight / 2; //Half the height of the button
	
	switch(property.anchor) {
		case ANCHOR.TOP_LEFT:
			anchorX = 0;
			anchorY = 0;
			break;
	
		case ANCHOR.TOP_CENTER:
			anchorX = (gw / 2) - _hw;
			anchorY = 0;
			break;
		
		case ANCHOR.TOP_RIGHT:
			anchorX = gw - _hw * 2;
			anchorY = 0;
			break;
			
		case ANCHOR.MIDDLE_LEFT:
			anchorX = 0;
			anchorY = gh / 2 - _hh;
			break;	
		
		case ANCHOR.MIDDLE_CENTER:
			anchorX = gw / 2 - _hw;
			anchorY = gh / 2 - _hh;
			break;
		
		case ANCHOR.MIDDLE_RIGHT:
			anchorX = gw - _hw * 2;
			anchorY = gh / 2 - _hh;
			break;
			
		case ANCHOR.BOTTOM_LEFT:
			anchorX = 0;
			anchorY = gh - _hh *2;
			break;
			
		case ANCHOR.BOTTOM_CENTER:
			anchorX = (gw / 2) - _hw;
			anchorY = gh - _hh *2;
			break;
			
		case ANCHOR.BOTTOM_RIGHT:
			anchorX = gw - _hw * 2;
			anchorY = gh - _hh *2;
			break;
			
	}
	
}