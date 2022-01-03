/// @description Show player collision
if(instance_exists(co_debugGridPlayerCollision))
{
	instance_destroy(co_debugGridPlayerCollision);
}
else
{
	instance_create_depth(x, y, -1, co_debugGridPlayerCollision);	
}