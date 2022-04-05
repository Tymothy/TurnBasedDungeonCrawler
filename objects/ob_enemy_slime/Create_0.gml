/// @description Create Slime

// Inherit the parent event
event_inherited();

targetObject = ob_player;

property.attackable = true;
property.moveSpeed = 1;
property.turnSpeed = 1;
property.name = "Slime";
property.collisionGrid = co_grid.mpGrid_collideOther;
property.hp = 1;
property.meleeAttackRange = 1;
property.meleeAttackPower = 1;
property.rangeAttackRange = 4;
property.rangeAttackPower = 1;
property.attacks.meleeDirect = true;
//Ranged only in for testing
property.attacks.rangeLine = true;
property.attacks.rangeDiag = true;
property.hp = 1;

sprite_index = sp_slime;