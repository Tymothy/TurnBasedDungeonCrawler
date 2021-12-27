/// @description Create/Destroy debug grid
if(instance_exists(co_grid))
{
	instance_destroy(co_grid);
}
else
{
	instance_create_depth(x, y, -1, co_grid);	
}