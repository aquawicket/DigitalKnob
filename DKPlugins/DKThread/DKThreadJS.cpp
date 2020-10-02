#ifdef USE_DKDuktape 
#include "DKThread.h"
#include "DKThreadJS.h"


///////////////////////
bool DKThreadJS::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKCPP_DKThread_DKQueue", &DKThreadJS::_DKQueue);
	DKDuktape::AttachFunction("DKCPP_DKThread_GetThreadNames", &DKThreadJS::GetThreadNames);
	return true;
}

////////////////////////////////////////////////
int DKThreadJS::GetThreadNames(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString names = toString(DKThreadPool::Instance("DKThreadPool")->names, ",");
	duk_push_string(ctx, names.c_str());
	return 1;
}

//////////////////////////////////////////
int DKThreadJS::_DKQueue(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString name = duk_require_string(ctx, 0);
	DKString code = duk_require_string(ctx, 1);
	DKINFO("DKThreadJS::DKQueue("+name+","+code+")\n");
#ifdef WIN32
	DKQueue(name, QueueItem, code); //Call in thread
#else
	duk_eval_string(DKDuktape::ctx, code.c_str()); //Call directly
#endif
	return 1;
}

////////////////////////////
void DKThreadJS::QueueItem()
{
	DKDEBUGFUNC();
	DKUtil::Sleep(100); //Bad!  FIXME
	duk_context* ctx2 = DKDuktape::ctx;
	if(!ctx2){ return; }// post error here
	//DKDuktape::ctx = NULL;
	//Create a copy of the context to work with in a new thread..  
	//P.S.  I am very bad a threading. This needs to be fixed.

	//trying to actually mutex lock the DKDuktape::ctx variable and use it.
	//duk_context* ctx2 = (duk_context*)malloc(sizeof(DKDuktape::ctx));
	//memcpy((void*)ctx2, DKDuktape::ctx, sizeof(DKDuktape::ctx));
	
	//DKThreadPool::Get("DKThreadPool0")->tdata is also created in the main thread.. this is bad bad bad...
	DKThreadPool* dkThreadTool = DKThreadPool::Get("DKThreadPool0");
	if(!dkThreadTool){ return; }
	duk_eval_string(ctx2, dkThreadTool->tdata[dkThreadTool->tdata.size()-1].c_str());
	DKUtil::Sleep(500); //Bad!  FIXME
	//free(ctx);
	//DKDuktape::ctx = ctx2;
}

#endif //USE_DKThread