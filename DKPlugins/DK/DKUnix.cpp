#include "DK/stdafx.h"
#ifndef WIN32
#include "DKUnix.h"
#include "DKFile.h"
#include <cstdlib>     // GetUsername()  std::getenv()
#include <unistd.h>    // sleep()  / usleep()
#include <termios.h>                  //for system(), tcsetattr()
static struct termios current, old;
/*
#include <pwd.h>       //GetUsername()  getpwuid()/getuid()
#include <unistd.h>    //GetUsername()  getlogin()/getlogin_r()
#include <sys/types.h> //GetUsername()  getpwnam()
*/


bool DKUnix::GetKey(int& key){
	DKDEBUGFUNC(key);
	return getch()
}

bool DKUnix::Sleep(int milliseconds){
	//DKDEBUGFUNC(milliseconds);
#ifdef ANDROID
	sleep(milliseconds * 1000);
#else
	usleep(milliseconds * 1000);
#endif
	return true;
}

bool DKUnix::GetUsername(DKString& username){
	DKDEBUGFUNC(username);
#ifdef MAC
	if (const char* usr_a = std::getenv("USER")){ //'USERNAME' on Windows
		username = usr_a;
		return true;
	}
#endif
#ifdef IOS
    //Get the username from the app_path in case we are in ios-simulator
    std::string::size_type pos = DKFile::app_path.find("/Library");
    username = DKFile::app_path.substr(0, pos);
    replace(username, "/Users/", "");
    DKINFO("DKUnix::GetUsername() = "+username+"\n");
    if(!username.empty())
        return true;
    return false;
#endif
#ifdef LINUX
	if (const char* usr_a = std::getenv("USER")){ //'USERNAME' on Windows
		username = usr_a;
		return true;
	}
#endif
	/*
	struct passwd* usr_b = getpwuid(getuid());
	if (usr_b) {
		username = usr_b->pw_name;
		return true;
	}
	char* usr_c;
	if ((usr_c = getlogin()) != NULL){
		username = usr_c;
		return true;
	}
	char usr_d[64];
	if (getlogin_r(usr_d, sizeof(usr_d) - 1) != 0) {
		username = usr_d;
		return true;
	}
	char* usr_e;
	struct passwd* pw;
	if ((pw = getpwnam(usr_e)) != NULL){
		username = pw->pw_uid;
		return true;
	}
	return DKERROR("ERROR: cannot get username");
	*/
	return false;
}

char DKUnix::getch_(int echo) {
	DKDEBUGFUNC();
	char ch;
	initTermios(echo);
	ch = getchar();
	restoreTermios();
	return ch;
}

char DKUnix::getch(void) {
	DKDEBUGFUNC();
	return getch_(0);
}

char DKUnix::getche(void) {
	DKDEBUGFUNC();
	return getch_(1);
}

void DKUnix::initTermios(int echo) {
	DKDEBUGFUNC();
	tcgetattr(0, &old);              // save current terminal settings 
	current = old;                   // store them
	current.c_lflag &= ~ICANON;      // disable buffered i/o
	if (echo) {
		current.c_lflag |= ECHO;     // set echo mode on
	}
	else {
		current.c_lflag &= ~ECHO;    // set echo mode off
	}
	tcsetattr(0, TCSANOW, &current);  // use created terminal settings
	/*
	// Fallback shell command method
	if (echo) {
		system("stty raw echo"); // Set terminal to raw mode with echo, (no wait for enter)
	}
	else {
		system("stty raw -echo"); // Set terminal to raw mode without echo, (no wait for enter)
	}
	*/
}

void DKUnix::restoreTermios(void) {
	DKDEBUGFUNC();
	tcsetattr(0, TCSANOW, &old);
	// Fallback shell command method
	// system("stty cooked"); // Reset terminal to normal "cooked" mode
}

#endif //!WIN32
