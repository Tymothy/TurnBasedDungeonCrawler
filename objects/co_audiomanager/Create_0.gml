/// @description Create audio manager

/*
Object should created in the init room, and it should be created only once.

What do I need to play a sound
 - A flag to track whether a sound should be played
 - The sound file to play
 - Whether the sound should loop or not
 - Whether the sound should fade or not
 
Other Things to Consider
 - Global Master Volume
 - SFX Volume
 - Music Volume
 - Environment Volume


I want to be able to have an object to pass a sound file to audio manager, set the flags and play

*/
global.volumeMaster = 1;
global.volumeSFX = 1;
global.volumeMusic = 1;
global.volumeEnvironment = 1;

enum VOL_TYPE {
	SFX,
	MUSIC,
	ENVIRONMENT
}

enum VOL_PRIORITY {
	LOWEST = 10,
	LOW = 20,
	NORMAL = 30,
	HIGH = 40,
	HIGHEST = 50,
}

//an array of structs to track the sounds playing
soundsPlaying = array_create(0);
//when a sound has stopped playing, remove it from the array.  Array should not have any empty values

playSound = function(_sound, _type, _priority = VOL_PRIORITY.NORMAL, _loop = false, _fadeIn = 0, _fadeOut = 0) {
	/// @desc ...
	/// @arg sound
	/// @arg type
	/// @arg priority
	
	//_sound = sound asset to play
	//_type = set enum, SFX, MUSIC, or ENVIRONMENT.
	//_loop = loop the track if true
	//_fadeIn = time in milliseconds to fade in the volume
	//_fadeOut = time in milliseconds to fade out the volume
	
	//Check sounds Playing array to see if we can play the sound.
	//If the same sound asset has been played on the same frame, skip playing the sound
	var _allowSoundToPlay = true;
	for(var i = 0; i < array_length(soundsPlaying); i++) {
		if(soundsPlaying[i].sound == _sound) {
			//Sound matches an existing sound.  Check if we can play it multiple times
			if(soundsPlaying[i].allowMultiple == false) {
				_allowSoundToPlay = false;
			}
			//_allowSoundToPlay was created as true, we don't need to set true here
		}
		
	}
	if(_allowSoundToPlay == true) {
		var _soundInst = audio_play_sound(_sound,_priority, _loop);
		var _soundStruct = new addSound(_soundInst, _sound, _priority, _type, _loop, _fadeIn, _fadeOut);
		addSoundToArray(_soundStruct);
		
	}
}


addSoundToArray = function(_soundStruct) {
	
	array_push(soundsPlaying, _soundStruct);
}

stepEnd = function() {
	//Go through array and flip the justStarted flag from true to false so the same sound can be played next frame if desired
	for(var i = 0; i < array_length(soundsPlaying); i++) {
		//Check if the sound is a looping sound.  If it is looping, we don't want multiple
		if(soundsPlaying[i].loop == true) {
			//Do not allow multiple, so we leave it alone
			//We do not set to false as it's created with false and if something else sets it we don't
			//want to override it
		}
		else if(soundsPlaying[i].allowMultiple == false) {
			//Allow multiple sounds to start playing
			soundsPlaying[i].allowMultiple = true;
			
		}		
	}
	
}
