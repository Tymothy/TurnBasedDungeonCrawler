/// @description Initialize State Machine and misc
event_inherited();

#region movement properties
face_direction=SOUTH;
move_speed=1.25;
#endregion

#region Controls
up = [0,0,0];
down = [0,0,0];
left = [0,0,0];
right = [0,0,0];
dpad_dir = NO_DIRECTION;
attack = [0,0,0];
run= [0,0,0];
jump= [0,0,0];
slide_dash = [0,0,0];
ai_script=noone;
//ai_vars=[0,AiActions.stand,1,NO_DIRECTION]; //Temp disabled, this accounts for ai scripting
#endregion