/// @description Check if minimap needs refreshed
if(!surface_exists(surf) && waitForLevelGen == false) {
	//If surface was somehow lost, recreate the surface
	minimapRefresh = true;
}

if(waitForLevelGen == true){
	if(instance_exists(co_roomGen)) {
		waitForLevelGen = false;
		minimapRefresh = true;
		
	}
}