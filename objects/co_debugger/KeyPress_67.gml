/// @description Show player collision
if(instance_exists(co_debugGridStructView))
{
	instance_destroy(co_debugGridStructView);
}
else
{
	instance_create_depth(x, y, -1, co_debugGridStructView);	
}