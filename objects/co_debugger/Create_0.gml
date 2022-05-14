/// @description Upscale game

//Used when resizing window on computer
var _scale = 2; //Used to multiply scale for testing on Windows builds
test_resolution(_scale);
alarm[0] = 1;
alarm[1] = 4;
wait = true; //Set to false in alarm1, gives a chance for game to be created
drawX1 = 0;
drawX2 = 0;
drawY1 = 0;
drawY2 = 0;