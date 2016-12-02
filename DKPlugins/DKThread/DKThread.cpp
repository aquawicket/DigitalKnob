#include "stdafx.h"
#include "DKThread.h"

/////////////////////////
void DKThreadPool::Init()
{
	DKCreate("DKThreadJS");
	DKCreate("DKThreadV8");
	DKCreate("DKThread/DKThreadPoolDlg.js");
	active = true;//false;

	dkThreadPool = new boost::threadpool::pool(1);

	DKApp::AppendLoopFunc(&DKThreadPool::Process, this);
}

////////////////////////
void DKThreadPool::End()
{
	dkThreadPool->clear();
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
	//we can update info about the threadpool in the main thread here..
	if(dkThreadPool->active() + dkThreadPool->pending() != names.size()){
		names.erase(names.begin());
		tdata.erase(tdata.begin());
		DKEvent::SendEvent("DKThreadPoolDlg.html", "Update", "");
	}
}
