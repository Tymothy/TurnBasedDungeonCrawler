/// @description Create the camera
set_camera(0, 0, WIDTH, HEIGHT);
set_gui_size(WIDTH);

camID = view_camera[0];
camWidth = camera_get_view_width(camID);
camHeight = camera_get_view_height(camID);

targX = x;
targY = y;

//offset in tiles
xOffset = 0;
yOffset = PLAY_AREA_OFFSET_Y;



xOffset = xOffset * TILE_SIZE;
yOffset = yOffset * TILE_SIZE;