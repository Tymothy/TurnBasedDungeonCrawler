/// @description Create Slime

// Inherit the parent event
event_inherited();

targetObject = ob_player;

property.attackable = true;
property.moveSpeed = 1;
property.turnSpeed = 1;
property.name = "Slime";
property.collisionGrid = co_grid.mpGrid_collideOther;
property.movePattern = MOVE.SEEK_DIRECT;
property.hp = 1;
property.meleeAttackRange = 1;
property.meleeAttackPower = 1;
property.rangeAttackRange = 4;
property.rangeAttackPower = 1;
property.attacks.meleeDirect = true;
property.attacks.rangeLine = false;
property.attacks.rangeDiag = false;
property.hp = 1;
