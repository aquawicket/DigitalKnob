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

// https://stackoverflow.com/a/32593825/688352

#pragma once
#ifndef DKThread_H
#define DKThread_H

#include "DK/DK.h"

#if MAC || IOS //|| ANDROID
#define TIME_UTC_ TIME_UTC
#endif

WARNING_DISABLE
#include "threadpool/boost/threadpool.hpp" //Not truly a Boost library.
#include <boost/asio.hpp>
#include <boost/smart_ptr.hpp>
#include <boost/thread.hpp>
WARNING_ENABLE


class DKThreadPool : public DKObjectT<DKThreadPool>
{
public:
	bool Init();
	bool End();

	//void Queue(const DKString& name, boost::function<void ()> func);
	void Queue(const DKString& name, std::function<void()> func);
	//void Queue(const DKString& name, boost::function<void ()> func, const DKString& data);
	void Queue(const DKString& name, std::function<void()> func, const DKString& data);
	void Process();
	
	bool active;
	boost::threadpool::pool* dkThreadPool; //Not truly a Boost function.
	DKStringArray names;
	DKStringArray tdata;
};

//Global quick functions
//static void DKQueue(const DKString& name, boost::function<void ()> func){
static void DKQueue(const DKString& name, std::function<void()> func) {
	DKThreadPool::Instance("DKThreadPool0");
	DKThreadPool::Instance("DKThreadPool0")->Queue(name, func);
}

//static void DKQueue(const DKString& name, boost::function<void ()> func, const DKString& data){
static void DKQueue(const DKString& name, std::function<void()> func, const DKString& data) {
	DKThreadPool::Instance("DKThreadPool0");
	DKThreadPool::Instance("DKThreadPool0")->Queue(name, func, data);
}


///////////////////////////////////////////////////////////////////////
///NOTE: This class has nothing to do with the DKThreadPool class above
// it's used for DKClient and DKServer
//http://codelever.com/blog/2013/06/18/using-boost-asio-io-service-in-another-thread/
//////////////
class DKThread
{
public:
    DKThread() : io_service(), work(io_service), thread() {}
    ~DKThread() {}

    void start(){
        if (thread) 
			return; // running
		DKINFO("Starting new thread...\n");
        thread.reset(new boost::thread(
            boost::bind(&boost::asio::io_service::run, &io_service)
        ));
    }

    void stop(){
        if (!thread) 
			return; // stopped
        io_service.stop();
        thread->join();
        io_service.reset();
        thread.reset();
    }

//private:
    boost::asio::io_service io_service;
	boost::asio::io_service::work work;
    boost::scoped_ptr<boost::thread> thread;
};



REGISTER_OBJECT(DKThreadPool, true)
#endif //DKThread_h
