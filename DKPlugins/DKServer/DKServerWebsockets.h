//http://usualcarrot.com/libwebsockets-simple-websocket-server
//https://barkingbogart.wordpress.com/2014/10/07/test-drive-libwebsockets-library-a-simple-server/

#pragma once
#ifndef DKServerWebsockets_H
#define DKServerWebsockets_H
#include <libwebsockets.h>


///////////////////////////////////////////
class DKServerWebsockets : public DKObjectT<DKServerWebsockets>
{
public:
	void Init();
	void End();
};


REGISTER_OBJECT(DKServerWebsockets, true);

#endif //DKServerWebsockets_H