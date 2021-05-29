//########## THIS PLUGIN IS OBSOLETE, PLEASE USE DKWebSockets ##########

#include "DK/stdafx.h"
#include "DKServer/DKServer.h"
//#ifdef USE_Boost_Thread


/////////////////////
bool DKServer::Init()
{
	DKDEBUGFUNC();
	//DKCreate("DKServerJS");
	thread = new DKThread();

    s = new server(thread->io_service, 8087);

	thread->start();
	return true;
}

////////////////////
bool DKServer::End()
{
	DKDEBUGFUNC();
	thread->stop();
	return true;
}


///////////////////////////////////////////////////////////////////////////
session::session(boost::asio::io_service& io_service) : socket_(io_service)
{
	DKDEBUGFUNC();
	DKINFO("Sever session created\n");
}

//////////////////////////////
tcp::socket& session::socket()
{
	DKDEBUGFUNC();
    return socket_;
}

/////////////////////
void session::start()
{
	DKDEBUGFUNC();
	socket_.async_read_some(boost::asio::buffer(data_, max_length),
		boost::bind(&session::handle_read, this,
		boost::asio::placeholders::error,
		boost::asio::placeholders::bytes_transferred));
}

///////////////////////////////////////////////////////////////////////////////////////////
void session::handle_read(const boost::system::error_code& error, size_t bytes_transferred)
{ 
	//DKDEBUGFUNC(error, bytes_transferred);
	if(!error){
	DKINFO(DKString(data_,bytes_transferred)+"\n");
	DKEvent::SendEvent("window", "server", DKString(data_, bytes_transferred));

	socket_.async_read_some(boost::asio::buffer(data_, max_length),
        boost::bind(&session::handle_read, this,
        boost::asio::placeholders::error,
		boost::asio::placeholders::bytes_transferred));

	/* 
	////  Echo Back ////
	boost::asio::async_write(socket_,
		boost::asio::buffer(data_, bytes_transferred),
        boost::bind(&session::handle_write, this,
        boost::asio::placeholders::error));
	*/
    }
    else{
      delete this;
    }
}

//////////////////////////////////////////////////////////////////
void session::handle_write(const boost::system::error_code& error)
{
	//DKDEBUGFUNC(error);
	if(!error){
      socket_.async_read_some(boost::asio::buffer(data_, max_length),
		boost::bind(&session::handle_read, this,
		boost::asio::placeholders::error,
		boost::asio::placeholders::bytes_transferred));
    }
    else{
      delete this;
    }
}


///////////////////////////////////////////////////////////////
server::server(boost::asio::io_service& io_service, short port)
	: io_service_(io_service),
    acceptor_(io_service, tcp::endpoint(tcp::v4(), port))
{
	DKDEBUGFUNC();
	start_accept();
}

///////////////////////////
void server::start_accept()
{
	DKDEBUGFUNC();
    new_session = new session(io_service_);
    acceptor_.async_accept(new_session->socket(),
        boost::bind(&server::handle_accept, this, new_session,
          boost::asio::placeholders::error));
}

////////////////////////////////////////////////////////////////////////////////////////
void server::handle_accept(session* new_session, const boost::system::error_code& error)
{
	DKDEBUGFUNC(new_session, error);
	if(!error){
		new_session->start();
    }
    else{
      delete new_session;
    }

	start_accept();
}


//#endif //USE_Boost_Thread