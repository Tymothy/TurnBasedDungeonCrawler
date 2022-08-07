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
			if (soundsPlaying[i].keepPlaying == false) {
				//We want to keep playing the sound
				soundsPlaying[i].keepPlaying = true;
				
			}
			//_allowSoundToPlay was created as true, we don't need to set true here
		}
		
	}
	if(_allowSoundToPlay == true) {
		//Play the sound
		var _soundInst = audio_play_sound(_sound,_priority, _loop);
		var _soundStruct = new addSound(_soundInst, _sound, _priority, _type, _loop, _fadeIn, _fadeOut);
		addSoundToArray(_soundStruct);
	}
	
	//Set the volume level of all tracks
	setSoundLevel();

}

setSoundLevel = function() {
	//TODO/BUG: This will overwrite any fading
	var _volSfx = global.volumeMaster * global.volumeSFX;
	var _volMusic = global.volumeMaster * global.volumeMusic;
	var _volEnvrionment = global.volumeMaster * global.volumeEnvironment;
	
	for(var i = 0; i < array_length(soundsPlaying); i++) {
		switch(soundsPlaying[i].type) {
			case VOL_TYPE.SFX:
				audio_sound_gain(soundsPlaying[i].inst, _volSfx, 0);
			break;
			
			case VOL_TYPE.MUSIC:
				audio_sound_gain(soundsPlaying[i].inst, _volMusic, 0);
			break;
			
			case VOL_TYPE.ENVIRONMENT:
				audio_sound_gain(soundsPlaying[i].inst, _volEnvrionment, 0);
			break;
			
		}
	}
	
}

addSoundToArray = function(_soundStruct) {
	
	array_push(soundsPlaying, _soundStruct);
}

stopSound = function(_soundInst) {
	for(var i = 0; i < array_length(soundsPlaying); i++) {
		if(soundsPlaying[i].inst == _soundInst) {
			if(audio_is_playing(soundsPlaying[i].inst)){
				audio_stop_sound(soundsPlaying[i].inst);
			}
			array_delete(soundsPlaying, i , 1);	
		}
	}	
}

stepEnd = function() {
	//Go through array and flip the justStarted flag from true to false so the same sound can be played next frame if desired
	for(var i = 0; i < array_length(soundsPlaying); i++) {
		//Check if the sound is a looping sound.  If it is looping, we don't want multiple
		if(soundsPlaying[i].loop == true) {
			//Do not allow multiple, so we leave it alone
			//We do not set to false as it's created with false and if something else sets it we don't
			//want to override it
			
			//We want to check if the sound has been played again this step, if so keep it going
			//Otherwise, stop the stound
			if(soundsPlaying[i].keepPlaying == false) {
				stopSound(soundsPlaying[i].inst);
				i--;
				break; //stopSound removes the sound from the array, so we need to -1 to i and start for loop over
			} else {
				//Set to false so if we do not play the sound again next frame, we will stop the sound.
				soundsPlaying[i].keepPlaying = false;	
			}
			
		}
		else if(soundsPlaying[i].allowMultiple == false) {
			//Allow multiple sounds to start playing
			soundsPlaying[i].allowMultiple = true;
			
		}
		
		//Check if the audio is done, if so, clean it up
		if(!audio_is_playing(soundsPlaying[i].inst)){
			stopSound(soundsPlaying[i].inst);
			i--;
			break;
		}
		
	}
	
}
