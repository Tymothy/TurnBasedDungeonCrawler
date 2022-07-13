/// @description Create Enemy

// Inherit the parent event
event_inherited();

targetObject = ob_player;

property.attackable = true;
property.moveSpeed = 2;
property.turnSpeed = 2;
property.name = "Grave Revenant";
property.collisionGrid = co_grid.mpGrid_collideOther;
property.movePattern = MOVE.SEEK_DIRECT;
property.hp = 1;
property.meleeAttackRange = 1;
property.meleeAttackPower = 1;
property.rangeAttackRange = 1;
property.rangeAttackPower = 1;
property.attacks.meleeDirect = true;
property.attacks.rangeLine = false;
property.attacks.rangeDiag = false;
property.hp = 1;
