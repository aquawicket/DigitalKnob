#ifdef USE_DKCef
#include "DKCefV8.h"

///////////////////////
void DKThreadV8::Init()
{
	DKCefApp::AttachFunction("myfunc", DKThreadV8::MyFunc);
}

//////////////////////
void DKThreadV8::End()
{

}

///////////////////////////////////////////////////////
bool DKThreadV8::MyFunc(CefArgs args, CefReturn retval)
{
	DKString arg = args[0]->GetStringValue();
	DKLog("DKThreadV8::MyFunc("+arg+")\n", DKFILTER);

	retval = CefV8Value::CreateString("output");
	return true;
}

#endif //USE_DKCef