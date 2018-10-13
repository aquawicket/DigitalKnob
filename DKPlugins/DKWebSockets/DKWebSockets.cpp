#include "DK/stdafx.h"
#include "DKWebSockets/DKWebSockets.h"

//#include "libwebsockets.h"


/////////////////////////
bool DKWebSockets::Init()
{
	//DKClass::DKCreate("DKWebSocketsJS");
	//DKClass::DKCreate("DKWebSocketsV8");

	//TODO look into test-echo.c for details on how to build a simple echo server 
	//C:\digitalknob\DK\3rdParty\libwebsockets-2.2-stable\test-server\test-echo.c
	return true;
}

////////////////////////
bool DKWebSockets::End()
{
	return true;
}