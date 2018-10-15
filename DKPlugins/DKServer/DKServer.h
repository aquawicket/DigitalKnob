//########## THIS PLUGIN IS OBSOLETE, PLEASE USE DKWebSockets ##########

// http://www.boost.org/doc/libs/1_41_0/doc/html/boost_asio/example/echo/async_tcp_echo_server.cpp

//#ifdef USE_Boost_Thread
#pragma once
#ifndef DKServer_H
#define DKServer_H
#include <cstdlib>
#include <iostream>
#include <boost/bind.hpp>
#include <boost/asio.hpp>
#include "DKThread/DKThread.h"

using boost::asio::ip::tcp;

/////////////
class session
{
public:
	session(boost::asio::io_service& io_service);
	tcp::socket& socket();
	void start();

	//private:
	void handle_read(const boost::system::error_code& error, size_t bytes_transferred);
	void handle_write(const boost::system::error_code& error);

	tcp::socket socket_;
	enum { max_length = 1024 };
	char data_[max_length];
};


////////////
class server
{
public:
	server(boost::asio::io_service& io_service, short port);

private:
	void start_accept();
	void handle_accept(session* new_session, const boost::system::error_code& error);

	boost::asio::io_service& io_service_;
	tcp::acceptor acceptor_;
	session* new_session;
};


///////////////////////////////////////////
class DKServer : public DKObjectT<DKServer>
{
public:
	bool Init();
	bool End();

	DKThread* thread;
	server* s;
};


REGISTER_OBJECT(DKServer, true);

#endif //DKServer_H
//#endif //USE_Boost_Thread