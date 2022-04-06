/// @description Range Grid
if(instance_exists(co_debugRangeGrid))
{
	instance_destroy(co_debugRangeGrid);
}
else
{
	instance_create_depth(x, y, -1, co_debugRangeGrid);	
}