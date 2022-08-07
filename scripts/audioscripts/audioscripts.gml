/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function addSound(_soundInst, _sound, _priority, _type, _loop, _fadeIn, _fadeOut) constructor{
	inst = _soundInst;
	sound = _sound;
	priority = _priority;
	type = _type;
	loop = _loop;
	fadeIn = _fadeIn;
	fadeOut = _fadeOut;
	allowMultiple = false; //Whether or not multiple sounds of the sound asset are allowed to exist
}

function audio_play_sfx(_sound, _loop = false, _fadeIn = 0, _fadeOut = 0) {
	/// @desc Play sfx
	/// @arg sound
	/// @arg loop[optional]
	/// @arg fadeIn[optional]
	/// @arg fadeOut[optional]
	co_audioManager.playSound(_sound, VOL_TYPE.SFX, VOL_PRIORITY.HIGH, _loop, _fadeIn, _fadeOut);
}

function audio_play_music(_sound, _crossfade) {
	/// @desc Play music
	/// @arg sound
	/// @arg crossfade[optional]
	
}