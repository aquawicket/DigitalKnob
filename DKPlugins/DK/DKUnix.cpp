/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#include "DK/stdafx.h"
#ifndef WIN32
#include "DK/DKUnix.h"
#include "DK/DKFile.h"

WARNING_DISABLE
#include <cstdlib>     // GetUsername()  std::getenv()
#include <unistd.h>    // sleep()  / usleep()
#include <termios.h>   // for system(), tcsetattr()

#include <cstring>      // std::memset()
#include <stdio.h>		// GetLocalIP()
#include <string.h>		// GetLocalIP()
#include <sys/types.h>	// GetLocalIP()
#include <sys/socket.h>	// GetLocalIP()
#include <netdb.h>		// GetLocalIP()
#include <arpa/inet.h>	// GetLocalIP()
#include <netinet/in.h>	// GetLocalIP()
WARNING_ENABLE

static struct termios current, old;
/*
#include <pwd.h>       //GetUsername()  getpwuid()/getuid()
#include <unistd.h>    //GetUsername()  getlogin()/getlogin_r()
#include <sys/types.h> //GetUsername()  getpwnam()
*/


char getch(void) {
	DKDEBUGFUNC();
	return DKUnix::getch_(0);
}

char getche(void) {
	DKDEBUGFUNC();
	return DKUnix::getch_(1);
}

bool DKUnix::GetKey(int& key){
	DKDEBUGFUNC(key);
	return getch();
}

bool DKUnix::Sleep(int milliseconds){
	//DKDEBUGFUNC(milliseconds);  //EXCESSIVE LOGGING
	usleep(milliseconds * 1000);
	return true;
}

bool DKUnix::GetUsername(DKString& username){
	DKDEBUGFUNC(username);
#if MAC
	if (const char* usr_a = std::getenv("USER")){ //'USERNAME' on Windows
		username = usr_a;
		return true;
	}
#endif
#if IOS
    //Get the username from the app_path in case we are in ios-simulator
    std::string::size_type pos = DKFile::app_path.find("/Library");
    username = DKFile::app_path.substr(0, pos);
    replace(username, "/Users/", "");
    DKINFO("DKUnix::GetUsername() = "+username+"\n");
    if(!username.empty())
        return true;
    return false;
#endif
#if LINUX
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

bool DKUnix::GetLocalIP(DKString& ip){
	DKDEBUGFUNC(ip);
	
	// https://stackoverflow.com/a/59025254/688352
	int sock = socket(PF_INET, SOCK_DGRAM, 0);
    sockaddr_in loopback;

    if (sock == -1)
        return DKERROR("socket() failed! \n");

    std::memset(&loopback, 0, sizeof(loopback));
    loopback.sin_family = AF_INET;
    loopback.sin_addr.s_addr = 1337;   // can be any IP address
    loopback.sin_port = htons(9);      // using debug port

    if (connect(sock, reinterpret_cast<sockaddr*>(&loopback), sizeof(loopback)) == -1) {
        close(sock);
        return DKERROR("connect() failed! \n");
    }

    socklen_t addrlen = sizeof(loopback);
    if (getsockname(sock, reinterpret_cast<sockaddr*>(&loopback), &addrlen) == -1) {
        close(sock);
        return DKERROR("getsockname() failed! \n");
    }

    close(sock);

    char buf[INET_ADDRSTRLEN];
    if (inet_ntop(AF_INET, &loopback.sin_addr, buf, INET_ADDRSTRLEN) == 0x0)
        return DKERROR("inet_ntop() failed! \n");
	else
		ip = toString(buf);
    
	//DKINFO("ip address = "+ip);
	return true;
}

char DKUnix::getch_(int echo) {
	DKDEBUGFUNC();
	char ch;
	initTermios(echo);
	ch = getchar();
	restoreTermios();
	return ch;
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
