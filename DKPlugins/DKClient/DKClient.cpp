#include "stdafx.h"
#include "DKClient.h"
#include <iostream>
#include <string>


/////////////////////
void DKClient::Init()
{
	//DKLog("DKClient::Init()\n", DKDEBUG);
	
	DKCreate("DKClientJS");
	thread = new DKThread();
	c = new client(thread->io_service);
	thread->start();
}

//////////////////////////////////////////////
void DKClient::Connect(const DKString address)
{
	if(address.empty()){ return; }

	//try{
		c->stop();
		tcp::resolver resolver(thread->io_service);
		c->start(resolver.resolve(tcp::resolver::query(address.c_str(), "8087")));
		_address = address;
	//}
	//catch(boost::system::system_error& e){
	//	std::cerr << e.what() << '\n';
	//	return;
	//}
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
