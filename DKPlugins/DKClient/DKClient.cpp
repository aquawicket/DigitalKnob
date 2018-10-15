//########## THIS PLUGIN IS OBSOLETE, PLEASE USE DKWebSockets ##########

#include "DK/stdafx.h"
#include "DKClient/DKClient.h"
#include <iostream>
#include <string>


/////////////////////
bool DKClient::Init()
{
	//DKLog("DKClient::Init()\n", DKDEBUG);
	
	DKClass::DKCreate("DKClientJS");
	//DKClass::DKCreate("DKClientV8"); //TODO
	thread = new DKThread();
	c = new client(thread->io_service);
	thread->start();
	return true;
}

//////////////////////////////////////////////
void DKClient::Connect(const DKString address)
{
	if(address.empty()){ return; }

	try{
		c->stop();
		tcp::resolver resolver(thread->io_service);
		c->start(resolver.resolve(tcp::resolver::query(address.c_str(), "8087")));
		if(_address != address){ _address = address; }
	}
	catch(boost::system::system_error& e){
		DKLog(DKString(e.what())+"\n", DKERROR);
		return;
	}
}

///////////////////////////////////////////
void DKClient::Send(const DKString& string)
{
	if(!c->socket_.is_open()){ 
		Connect(_address);
		if(!c->socket_.is_open()){ 
		  DKLog("DKClient::Send(): could not find open socket\n", DKWARN);
		  return; 
		}
	}

	const char* z = string.c_str();
	size_t request_length = std::strlen(z);
	boost::asio::write(c->socket_, boost::asio::buffer(z, request_length));
}
