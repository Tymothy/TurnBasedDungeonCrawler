/// @description Resolution debug grid
if(instance_exists(co_debugResGrid))
{
	instance_destroy(co_debugResGrid);
}
else
{
	instance_create_depth(x, y, -1, co_debugResGrid);	
}