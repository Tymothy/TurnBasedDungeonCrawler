/// @description Create
event_inherited();
vel = 0; //Velocity of projectile
dir = 0; //Direction of projectile

alarm[0] = 60; //Automatically destroys object after 2 seconds

targetObject = noone;

truestate_create_state(STATES.BLANK, state_blank);
