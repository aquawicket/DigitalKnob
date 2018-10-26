#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKScreenRecorder/DKScreenRecorder.h"
#include "DKScreenRecorder/DKScreenRecorderV8.h"

///////////////////////////////
bool DKScreenRecorderV8::Init()
{
	DKDEBUGFUNC();
	DKV8::AttachFunction("DKScreenRecorder_Record", DKScreenRecorderV8::Record);
	DKV8::AttachFunction("DKScreenRecorder_Stop", DKScreenRecorderV8::Stop);
	return true;
}

//////////////////////////////
bool DKScreenRecorderV8::End()
{
	DKDEBUGFUNC();
	return true;
}


///////////////////////////////////////////////////////////////
bool DKScreenRecorderV8::Record(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	DKString file = args->GetString(0);
	if(!DKScreenRecorder::Record(file)){ return false; }
	return true;
}

/////////////////////////////////////////////////////////////
bool DKScreenRecorderV8::Stop(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	if(!DKScreenRecorder::Stop()){ return false; }
	return true;
}

#endif //USE_DKCef