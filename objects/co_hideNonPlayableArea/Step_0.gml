/// @description Check if minimap needs refreshed
if(!surface_exists(surf) && waitForLevelGen == false) {
	//If surface was somehow lost, recreate the surface
	refresh = true;
}

if(waitForLevelGen == true){
	if(instance_exists(co_roomGen)) {
		waitForLevelGen = false;
		refresh = true;
		
	}
}