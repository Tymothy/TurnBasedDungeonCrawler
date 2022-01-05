/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function truestate_draw_history(_title, _x, _y, _count, _bg_color, _bg_alpha) {
	var _str = _title;
	var _stack = ds_stack_create();
	ds_stack_copy(_stack,truestate_stack);
	var _lineHeight = string_height(_str);
	_str+="\n\n"
	var _i = 0;
	while(_i < _count && !ds_stack_empty(_stack)) {
		_str += truestate_names[? ds_stack_pop(_stack)] +"\n";
		_i++;
	}
	ds_stack_destroy(_stack);
	var _margin = 20;
	draw_set_color(_bg_color);
	draw_set_alpha(_bg_alpha);
	draw_rectangle(_x,_y,	
									_x+string_width(_str)+_margin*2,
									_y+_lineHeight*(_count+1)+_margin*3,
									false);
	draw_set_alpha(1);
	draw_set_halign(fa_left); 
	draw_set_valign(fa_top); 
	draw_set_color(c_white);
	draw_text(_x+_margin,_y+_margin,_str);
}

