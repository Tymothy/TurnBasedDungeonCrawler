/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function state_blank(_event){
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			//This code will run once when the state is brand new.
			truestate_clear_history();
			
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{



		}break;
	
		//DRAW---------------------------------------
		case TRUESTATE_DRAW:
		{

		}break;
	
		//FINAL---------------------------------------
		case TRUESTATE_FINAL:
		{

		}break;
	}
}