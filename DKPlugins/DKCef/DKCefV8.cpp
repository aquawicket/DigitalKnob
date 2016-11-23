#include "DKCefV8.h"

////////////////////
void DKCefV8::Init()
{
	DKCefApp::AttachFunction("myfunc", &DKCefV8::MyFunc, this);
}

///////////////////
void DKCefV8::End()
{

}

////////////////////////////////////////
DKString DKCefV8::MyFunc(DKString input)
{
	DKLog("DKCefV8::MyFunc("+input+")", DKDEBUG);
	return "MyFunc output";
}

