#pragma once
#ifndef DKThread_H
#define DKThread_H

#include "DK/DK.h"

#if defined(MAC) || defined(ANDROID) || defined(IOS)
#define TIME_UTC_ TIME_UTC
#endif

#include "threadpool/boost/threadpool.hpp" //Not truly a Boost library.

#include <boost/asio.hpp>
#include <boost/smart_ptr.hpp>
#include <boost/thread.hpp>


///////////////////////////////////////////////////
class DKThreadPool : public DKObjectT<DKThreadPool>
{
public:
	bool Init();
	bool End();

	void Queue(const DKString& name, boost::function<void ()> func);
	void Queue(const DKString& name, boost::function<void ()> func, const DKString& data);
	void Process();
	
	bool active;
	boost::threadpool::pool* dkThreadPool; //Not truly a Boost function.
	DKStringArray names;
	DKStringArray tdata;
};

//Global quick functions
////////////////////////////////////////////////////////////////////////
static void DKQueue(const DKString& name, boost::function<void ()> func)
{
	DKThreadPool::Instance("DKThreadPool0");
	DKThreadPool::Instance("DKThreadPool0")->Queue(name, func);
}
//////////////////////////////////////////////////////////////////////////////////////////////
static void DKQueue(const DKString& name, boost::function<void ()> func, const DKString& data)
{
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

    void start()
    {
        if (thread) return; // running

		DKLog("Starting new thread...\n");
        thread.reset(new boost::thread(
            boost::bind(&boost::asio::io_service::run, &io_service)
        ));
    }

    void stop()
    {
        if (!thread) return; // stopped

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
#endif //DKThread.h

