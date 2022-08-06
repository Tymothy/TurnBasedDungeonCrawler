/// @description Create hurt player button



// Inherit the parent event
event_inherited();
property.text = "Hurt Player";
property.anchor = ANCHOR.BOTTOM_LEFT;
property.x = 0;
property.y = -1;
property.width = 3;
property.height = 1;
property.defaultColor = c_orange;
property.onClickColor = c_red;


create_update();

activate_button = function() {
	ob_player.takeDamage(1);
	
}