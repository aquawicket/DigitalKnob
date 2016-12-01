
////////////////////////////
function Input_Init()
{
	DKCreate("DKDebug/Input.html");
	//DKAddEvent("Input_Button", "click", Input_OnEvent);
}

////////////////////////////
function Input_End()
{
	DKClose("DKDebug/Input.html");
}

/////////////////////////////////////
function Input_OnEvent(event)
{
	//if(DK_Id(event, "Input_Button")){
	//	Input_CreateReport();
	//}
}
