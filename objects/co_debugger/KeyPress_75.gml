/// @description Damage all hostiles by 1
//for (var i = 0; i < instance_number(ob_par_hostile); ++i;)
//{
//    var _hostile = instance_find(ob_par_hostile,i);
//	_hostile.takeDamage(1);
//}

for (var i = 0; i <  instance_number(ob_par_hostile); i++) {

		var _aiID = instance_find(ob_par_hostile, i);		
		var _inRoom = is_instance_in_current_room(_aiID);
		if(_inRoom == true) {
			_aiID.takeDamage(1);
		}
	}
	if(LOGGING) show_debug_message("Damaged all hostiles in room by 1");
