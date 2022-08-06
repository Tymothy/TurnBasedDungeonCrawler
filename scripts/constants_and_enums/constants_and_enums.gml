//Shortcuts


#macro WIDTH global.ideal_width
#macro HEIGHT global.ideal_height
#macro NATIVE_WIDTH 640 //This is 3x smaller than 1080P
#macro NATIVE_HEIGHT  360 //This is 3x smaller than 1080P

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
	FRONT_WALL = 10, //Split Light Gray/Dark Gray
	SOLID_WALL = 11, //Dark Gray
	PLACEHOLDER_12 = 12, //Dark Teal
	DOOR_WALL = 13, //Dark Blue
	PLACEHOLDER_14 = 14, //Dark Magenta/Dark Pink
	PLACEHOLDER_15 = 15, //Dark Red
	PLACEHOLDER_16 = 16, //Dark Yellow
	OBSTACLE_LOW = 17, //Dark Purple - Used for pits, or walls up to waist height
	PLACEHOLDER_18 = 18, //Dark Green
	PLACEHOLDER_19 = 19 //Dark Orange/Dark Brown
}

enum ROOMTYPE
{
	NONE, //Not an accessible cell, solid earth
	SPAWN, //The spawn room for the level
	NORMAL, // A standard room
	BOSS, // Boss room
	SHOP, // Shop room
	ITEM, //Item room
}
//List of all attacks available in game
//TODO: Put this into structs on what they can do
enum ATTACK
{
	LUNGE, //Attacker moves directly into target from at least 1 square away
	DIRECT, //Attacker starts near target, AI only
	SLIDE, //Attack starts near target and moves while also staying near target
	RANGED_PROJECTILE, //Attacker fires a projectile into a target.  Account for piercing for depth
	RANGED_WALL, //Attacker fires a line of attacks.  All targets in a line X long are damaged	
}

enum MOVE {
	NONE,
	SEEK_DIRECT,
	SEEK_RANGE,
}
enum STATES
{
	BLANK, //Holder for no code
	//Game States
	INACTIVE,
	GAME_SETUP,
	PLAYER_STARTING,
	PLAYER_ACTIVE,
	PLAYER_ENDING,
	AI_STARTING,
	AI_ACTIVE,
	AI_ENDING,
	TURN_END,
	PAUSED,
	
	//Player States
	WAIT,
	IDLE,
	MOVE,
	WALK,
	ATTACK,
	HURT,
	ITEM_GET,
	END,
	
	//Touch States
	//IDLE, //This already exists, that's why it's commented out
	NEW_TOUCH,
	SAME_TOUCH,
	DIFFERENT_TOUCH,
	DRAGGING,
	RELEASE,
	
	//Enemy states
	//IDLE, //Already used above
	//MOVE, //Already used above
	FLEE,
	//ATTACK //Already used above
	//HURT //Already used above
	
	
	//DOOR STATES
	LOCKED,
	OPEN,
}

enum DIFFICULTY
{
	NONE,
	PEACEFUL,
	EASY,
	MEDIUM,
	HARD,
}

enum INTENT 
{
	NONE,
	PLAY_AREA,
	MENU
	
}

enum ANCHOR {
	//Controls where the GUI is anchored at
	TOP_LEFT,
	TOP_CENTER,
	TOP_RIGHT,
	MIDDLE_LEFT,
	MIDDLE_CENTER,
	MIDDLE_RIGHT,
	BOTTOM_LEFT,
	BOTTOM_CENTER,
	BOTTOM_RIGHT,
	
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