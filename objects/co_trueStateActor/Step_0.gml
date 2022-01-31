/// @desc State step
if(script_exists(ai_script)) {
	script_execute(ai_script);
}
else {

//You can do other things in your step event if you 
//want, but you sorta need this:
event_inherited();
}