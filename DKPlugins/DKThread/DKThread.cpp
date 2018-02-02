#include "DK/stdafx.h"
#include "DKThread.h"

/////////////////////////
bool DKThreadPool::Init()
{
#ifdef USE_DKDuktape 
	DKCreate("DKThreadJS");
#endif
#ifdef USE_DKCef
	DKCreate("DKThreadV8");
#endif
	DKCreate("DKThread/DKThreadPoolDlg.js");
	active = true;//false;

	dkThreadPool = new boost::threadpool::pool(1);

	DKApp::AppendLoopFunc(&DKThreadPool::Process, this);
	return true;
}

////////////////////////
void DKThreadPool::End()
{
	active = false;
	dkThreadPool = NULL;
	delete dkThreadPool;
	//dkThreadPool->clear();
}

/////////////////////////////////////////////////////////////////////////////
void DKThreadPool::Queue(const DKString& name, boost::function<void ()> func)
{
	if(active){
		dkThreadPool->schedule(func);
		tdata.push_back("");
		names.push_back(name);
		DKEvent::SendEvent("DKThreadPoolDlg.html", "Update", "");
		return;
	}
	func();
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void DKThreadPool::Queue(const DKString& name, boost::function<void ()> func, const DKString& data)
{
	if(active){
		dkThreadPool->schedule(func);
		tdata.push_back(data);
		names.push_back(name);
		DKEvent::SendEvent("DKThreadPoolDlg.html", "Update", "");
		return;
	}
	func();
}

////////////////////////////
void DKThreadPool::Process()
{
	if(names.empty()){ return; }
	//we can update info about the threadpool in the main thread here..
	if(dkThreadPool->active() + dkThreadPool->pending() != names.size()){
		names.erase(names.begin());
		tdata.erase(tdata.begin());
		DKEvent::SendEvent("DKThreadPoolDlg.html", "Update", "");
	}
}
