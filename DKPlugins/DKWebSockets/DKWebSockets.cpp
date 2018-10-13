#include "DK/stdafx.h"
#include "DKWebSockets/DKWebSockets.h"

#include "libwebsockets.h"

/////////////////////////
bool DKWebSockets::Init()
{
	//DKClass::DKCreate("DKWebSocketsJS");
	//DKClass::DKCreate("DKWebSocketsV8");
	return true;
}

////////////////////////
bool DKWebSockets::End()
{
	return true;
}