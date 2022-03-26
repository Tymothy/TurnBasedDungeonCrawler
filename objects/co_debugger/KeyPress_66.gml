/// @description Show bitmask grid
if(instance_exists(co_debugBitmaskTile))
{
	instance_destroy(co_debugBitmaskTile);
}
else
{
	show_debug_message("Creating debug mask tile");
	instance_create_depth(x, y, -1, co_debugBitmaskTile);	
}
