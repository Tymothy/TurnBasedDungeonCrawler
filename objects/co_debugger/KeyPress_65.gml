/// @description Test formula in output
var _testNum = 100;
//global.currentFloor = 3;
//var _str = goal_rooms();

for(var i = 0; i < _testNum; i++) {
	array[i] = goal_rooms();	
}

show_debug_message("Out of " + string(_testNum) + " gens, on floor " + string(global.currentFloor) + " this is the count of rooms: ");
var _count = 0;
for(var i = 0; i < 80; i++) {
	for(var j = 0; j < array_length(array); j++) {
			if(array[j] == i) _count++;
	}
	if(_count > 0) show_debug_message("Rooms: " + string(i) + " | Count: " + string(_count));
	_count = 0;
}