#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKMidi/DKMidi.h"
#include "DKMidi/DKWebSocketsV8.h"

///////////////////////////
bool DKWebSocketsV8::Init()
{
	DKLog("DKWebSocketsV8::Init()\n", DKDEBUG);
	return true;
}

//////////////////////////
bool DKWebSocketsV8::End()
{
	DKLog("DKWebSocketsV8::End()\n", DKDEBUG);
	return true;
}

#endif //USE_DKCef