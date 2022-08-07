/// @description Create speed modifier button



// Inherit the parent event
event_inherited();
property.text = "Move Spell";
property.anchor = ANCHOR.MIDDLE_LEFT;
property.x = 0;
property.y = 1;
property.width = 3;
property.height = 1;
property.defaultColor = c_ltgray;
property.onClickColor = c_white;
property.disabledColor = c_dkgray;
property.activeColor = c_lime;


create_update();
conditions = function() {
	if(instance_exists(ob_player)) {
		if(ob_player.canCastSpell(SPELL.MOVE)) {
			return true;	
		}
	}
	return false;
}

activate_button = function() {
	show_debug_message("Speed button.");
	if(ob_player.canCastSpell(SPELL.MOVE)){
		ob_player.activateSpell(SPELL.MOVE);
	}

}

deactivate_button = function() {
	show_debug_message("Speed button.");
	ob_player.deactivateSpell(SPELL.MOVE);
}