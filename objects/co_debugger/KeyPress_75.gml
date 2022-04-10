/// @description Damage all hostiles by 1
for (var i = 0; i < instance_number(ob_par_hostile); ++i;)
{
    var _hostile = instance_find(ob_par_hostile,i);
	_hostile.takeDamage(1);
}


