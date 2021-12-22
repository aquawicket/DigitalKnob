///// DK.h /////

//* NOTE:
//* This is the core of DigitalKnob. 
//* Anything that is an absolute for the core to work, starts in this header file.

#pragma once
#ifndef DK_H
#define DK_H
#include "DKPreprocessor.h"

#if WIN32
#include "DK/DKWindows.h"
#elif MAC
#include "DK/DKMac.h"
#elif IOS
#include "DK/DKIos.h"
#elif LINUX
#include "DK/DKLinux.h"
#elif RASPBERRY
#include "DK/DKLinux.h"
#elif ANDROID
#include "DK/DKAndroid.h"
#else
#error NO KNOWN PLATFORM FLAG WAS FOUND (WIN,MAC,LINUX,ANDROID,IOS,RASPBERRY)
#endif

#include "DK/DKClass.h"
#include "DK/DKEvents.h"
#include "DK/DKUtil.h"
#include "DK/DKApp.h"

#ifdef DKAPP
	#include "DKPlugins.h"
#endif

#endif
