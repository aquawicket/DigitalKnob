#ifdef USE_DKCef
#include "DKThread.h"
#include "DKThreadV8.h"

///////////////////////
bool DKThreadV8::Init()
{
	DKDebug();
	DKV8::AttachFunction("DKThread_DKQueue", &DKThreadV8::_DKQueue);
	DKV8::AttachFunction("DKThread_GetThreadNames", DKThreadV8::GetThreadNames);
	return true;
}

//////////////////////
bool DKThreadV8::End()
{
	DKDebug();
	return true;
}

//////////////////////////////////////////////////////////////
bool DKThreadV8::GetThreadNames(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	DKString names = toString(DKThreadPool::Instance("DKThreadPool")->names, ",");
	//retval = CefV8Value::CreateString(names.c_str());
	retval->SetString(0, names.c_str());
	return true;
}

////////////////////////////////////////////////////////
bool DKThreadV8::_DKQueue(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	//DKString name = args[0]->GetStringValue();
	DKString name = args->GetString(0);
	//DKString code = args[1]->GetStringValue();
	DKString code = args->GetString(1);
	
	DKLog("DKThreadJS::DKQueue("+name+","+code+")\n");
//#ifdef WIN32
//	DKQueue(name, QueueItem, code); //Call in thread
//#else
	DKCef::Get()->RunJavascript(0, code); //Call directly
//#endif
	return true;
}

/////////////////////////////
void DKThreadV8::QueueItem()
{
	DKDebug(args, retval);
	DKUtil::Sleep(100); //Bad!  FIXME
	//duk_context* ctx2 = DKDuktape::ctx;
	//if(!ctx2){ return; }// post error here
	
	//DKThreadPool::Get("DKThreadPool0")->tdata is also created in the main thread.. this is bad bad bad...
	DKThreadPool* dkThreadTool = DKThreadPool::Get("DKThreadPool0");
	if(!dkThreadTool){ return; }
	//duk_eval_string(ctx2, dkThreadTool->tdata[dkThreadTool->tdata.size()-1].c_str());
	DKUtil::Sleep(500); //Bad!  FIXME
}

#endif //USE_DKCef