/// @description Delete Grids
ds_grid_destroy(tileGrid);
mp_grid_destroy(mpGrid_collidePlayer);
mp_grid_destroy(mpGrid_collideOther);
mp_grid_destroy(mpGrid_collideProjectile);
if(LOGGING) show_debug_message("Destroyed grids");