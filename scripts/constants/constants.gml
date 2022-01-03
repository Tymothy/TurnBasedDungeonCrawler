//Shortcuts
#macro ADMIN 0
#macro LOGGING 0
#macro VISUAL_DEBUG 0
#macro UNLOCK_ALL 0
#macro CONFIGURATION 0


#macro test:ADMIN 1
#macro test:LOGGING 1
#macro test:VISUAL_DEBUG 1
#macro test:UNLOCK_ALL 1
#macro test:CONFIGURATION 1

#macro WIDTH global.ideal_width
#macro HEIGHT global.ideal_height

//Size of the tiles in game
#macro TILE_SIZE 32 

//How many tiles should the game target to display on screen. 
#macro DESIGN_TILES_WIDE 13 

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