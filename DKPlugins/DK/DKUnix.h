#ifndef WIN32 //UNIX
#pragma once
#ifndef DKUnix_H
#define DKUnix_H

class DKUnix{
public:
	static bool GetKey(int& key);
	static bool Sleep(int milliseconds);
	static bool GetUsername(DKString& username);
};

#endif //DKUnix_H
#endif //!WIN32