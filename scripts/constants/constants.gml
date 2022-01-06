//Shortcuts


#macro WIDTH global.ideal_width
#macro HEIGHT global.ideal_height



//Core Tiles Enum
enum CORETILES
{
	NORMAL = 1, //Light Gray
	PLACEHOLDER_2 = 2, //Light Teal
	DOOR_FLOOR = 3, //Light Blue
	PLACEHOLDER_4 = 4, //Light Pink
	PLACEHOLDER_5 = 5, //Light Red
	PLACEHOLDER_6 = 6, //Light Yellow
	PLACEHOLDER_7 = 7, //Light Purple
	SPAWN = 8, //Light Green/Lime
	PLACEHOLDER_9 = 9, //Light Gold/Light Orange
	PLACEHOLDER_10 = 10, //Split Light Gray/Dark Gray
	SOLID_WALL = 11, //Dark Gray
	PLACEHOLDER_12 = 12, //Dark Teal
	DOOR_WALL = 13, //Dark Blue
	PLACEHOLDER_14 = 14, //Dark Magenta/Dark Pink
	PLACEHOLDER_15 = 15, //Dark Red
	PLACEHOLDER_16 = 16, //Dark Yellow
	PLACEHOLDER_17 = 17, //Dark Purple
	PLACEHOLDER_18 = 18, //Dark Green
	PLACEHOLDER_19 = 19 //Dark Orange/Dark Brown
}

//List of all attacks available in game
//TODO: Put this into structs on what they can do
enum ATTACK
{
	LUNGE, //Attacker moves directly into target
	DIRECT, //Attacker starts near target and can move along side the target
	
	RANGED_PROJECTILE, //Attacker fires a projectile into a target.  Account for piercing for depth
	RANGED_WALL, //Attacker fires a line of attacks.  All targets in a line X long are damaged	
	
}

enum STATES
{
	//Game States
	SETUP,
	PLAYER_STARTING,
	PLAYER_ACTIVE,
	PLAYER_ENDING,
	AI_STARTING,
	AI_ACTIVE,
	AI_ENDING,
	TURN_END,
	PAUSED,
	INACTIVE,
	
	//Player States
	IDLE,
	WALK,
	ATTACK,
	HURT,
	ITEM_GET,
	
	//Touch States
	//IDLE, //This already exists, that's why it's commented out
	NEW_TOUCH,
	SAME_TOUCH,
	DIFFERENT_TOUCH,
	DRAGGING,
	RELEASE,
	
}


#region TrueState
#macro G global

	//Direction
#macro NO_DIRECTION -1
#macro EAST 0
#macro NORTH_EAST 45
#macro NORTH 90
#macro NORTH_WEST 135
#macro WEST 180
#macro SOUTH_WEST 225
#macro SOUTH 270
#macro SOUTH_EAST 315
#macro HORIZONTAL 0
#macro VERTICAL 1

	//Input
#macro HELD 0
#macro PRESSED 1
#macro RELEASED 2


#endregion