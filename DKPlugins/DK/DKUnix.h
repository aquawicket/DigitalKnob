#ifndef WIN32 //UNIX
#pragma once
#ifndef DKUnix_H
#define DKUnix_H

class DKUnix{
public:
	static bool GetKey(int& key);
	static bool Sleep(int milliseconds);
	static bool GetUsername(DKString& username);

	static char getch(void);
	static char getche(void);
	static char getch_(int echo);
	static void initTermios(int echo);
	static void restoreTermios(void);
};

#endif //DKUnix_H
#endif //!WIN32