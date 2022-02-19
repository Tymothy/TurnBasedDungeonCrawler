/// @description Show Player Collision
draw_set_alpha(.25); //Lower opacity of collision grid overlay
mp_grid_draw(co_grid.mpGrid_entity);
draw_set_alpha(1); //Reset opacity back to default