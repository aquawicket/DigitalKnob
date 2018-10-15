//########## THIS PLUGIN IS OBSOLETE, PLEASE USE DKWebSockets ##########

//http://stackoverflow.com/questions/30904560/libwebsocket-client-example
//https://barkingbogart.wordpress.com/2014/10/07/test-drive-libwebsockets-library-a-simple-server/
//http://usualcarrot.com/libwebsockets-simple-websocket-server   NOTE: 5 YEARS OLD!
//https://gist.github.com/martinsik/3216369 NOTE: 5 YEARS OLD!

#pragma once
#ifndef DKServerWebsockets_H
#define DKServerWebsockets_H

//#include <libwebsockets.h>


///////////////////////////////////////////////////////////////
class DKServerWebsockets : public DKObjectT<DKServerWebsockets>
{
public:
	bool Init();
	bool End();
};


REGISTER_OBJECT(DKServerWebsockets, true);

#endif //DKServerWebsockets_H