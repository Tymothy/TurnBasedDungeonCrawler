/// @description Create load button



// Inherit the parent event
event_inherited();
property.text = "Hurt Hostiles";
property.anchor = ANCHOR.BOTTOM_LEFT;
property.x = 0;
property.y = -2;
property.width = 3;
property.height = 1;
property.defaultColor = c_orange;
property.onClickColor = c_red;


create_update();

activate_button = function() {
	co_gameManager.hurtHostiles();
}