#include "DKCefV8.h"

CefRefPtr<CefV8Handler> DKCefV8::handler;

////////////////////
void DKCefV8::Init()
{
	handler = new DKV8Handler();
}

///////////////////
void DKCefV8::End()
{

}

