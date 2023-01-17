/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#include "DK/stdafx.h"
#include "DKThread/DKThread.h"


bool DKThreadPool::Init(){
#ifdef HAVE_DKDuktape 
	DKClass::DKCreate("DKThreadJS");
#endif
#ifdef HAVE_DKCef
	DKClass::DKCreate("DKThreadV8");
#endif
	DKClass::DKCreate("DKThread/DKThreadPoolDlg.js");
	active = true;//false;

	dkThreadPool = new boost::threadpool::pool(1);

	DKApp::AppendLoopFunc(&DKThreadPool::Process, this);
	return true;
}

bool DKThreadPool::End(){
	active = false;
	dkThreadPool = NULL;
	delete dkThreadPool;
	//dkThreadPool->clear();
	return true;
}

//void DKThreadPool::Queue(const DKString& name, boost::function<void ()> func)
void DKThreadPool::Queue(const DKString& name, std::function<void()> func){
	if(active){
		dkThreadPool->schedule(func);
		tdata.push_back("");
		names.push_back(name);
		DKEvents::SendEvent("DKThreadPoolDlg.html", "Update", "");
		return;
	}
	func();
}

//void DKThreadPool::Queue(const DKString& name, boost::function<void ()> func, const DKString& data)
void DKThreadPool::Queue(const DKString& name, std::function<void()> func, const DKString& data){
	if(active){
		dkThreadPool->schedule(func);
		tdata.push_back(data);
		names.push_back(name);
		DKEvents::SendEvent("DKThreadPoolDlg.html", "Update", "");
		return;
	}
	func();
}

void DKThreadPool::Process(){
	if(names.empty()){ return; }
	//we can update info about the threadpool in the main thread here..
	if(dkThreadPool->active() + dkThreadPool->pending() != names.size()){
		names.erase(names.begin());
		tdata.erase(tdata.begin());
		DKEvents::SendEvent("DKThreadPoolDlg.html", "Update", "");
	}
}
