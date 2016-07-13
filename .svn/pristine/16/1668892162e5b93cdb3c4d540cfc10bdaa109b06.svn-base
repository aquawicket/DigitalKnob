#include "stdafx.h"
#include "App.h"
#include "DKPlugin.h"

////////////////
void App::Init()
{
	DKLog("App::Init() \n", DKDEBUG);
	DKPlugins::LoadPlugin("C:/digitalknob/DKPlugins/DKPlugin1/win32/Debug/DKPlugin1.dll");
	DKClass::CallFunc("DKPlugin1::SomeFunction");
}