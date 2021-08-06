#pragma once
#ifndef DKPoll_H
#define DKPoll_H

#ifdef WIN32
	#include <Winsock2.h>
	#define poll WSAPoll
#endif

#ifdef ANDROID
	#include "android_poll.h"
#endif

#ifdef MAC
	#include <sys/poll.h>
#endif

#ifdef IOS
	#include <sys/poll.h>
#endif

#ifdef LINUX
	#include <sys/poll.h>
#endif

#endif //DKPoll_H