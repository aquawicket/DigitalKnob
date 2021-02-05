///// DK.h /////

//* NOTE:
//* This is the core of DigitalKnob. 
//* Anything that is an absolute for the core to work, starts in this header file.

#pragma once
#ifndef DK_H
#define DK_H

#if defined(WIN32)
#include "DK/DKWindows.h"
#elif defined(MAC)
#include "DK/DKMac.h"
#elif defined(LINUX)
#include "DK/DKLinux.h"
#elif defined(ANDROID)
#include "DK/DKAndroid.h"
#elif defined(IOS)
#include "DK/DKIos.h"
#elif defined(RASPBERRY)
#include "DK/DKLinux.h"
#else
#error NO KNOWN OS FLAG WAS STATED (WIN32,MAC,LINUX,ANDROID,IOS,RASPBERRY)
#endif

//* DK
#include "DK/DKClass.h"
#include "DK/DKEvents.h"
#include "DK/DKUtil.h"
#include "DK/DKApp.h"

#ifdef DKAPP
	#include "DKPlugins.h"
#endif

#endif
