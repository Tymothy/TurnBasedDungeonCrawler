/// @description Show the entity grid
if(instance_exists(co_debugEntityGrid))
{
	instance_destroy(co_debugEntityGrid);
}
else
{
	instance_create_depth(x, y, -1, co_debugEntityGrid);	
}