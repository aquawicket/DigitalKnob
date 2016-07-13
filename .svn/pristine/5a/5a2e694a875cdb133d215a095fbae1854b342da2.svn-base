///// DK.h /////

//NOTE:
// This is the core of DigitalKnob. 
// Anything that is an absolute must for the core to work, starts in this header file.

#pragma once
#ifndef DK_H
#define DK_H

#if defined(WIN32)
#include "DKWindows.h"
#elif defined(MAC)
#include "DKMac.h"
#elif defined(LINUX)
#include "DKLinux.h"
#elif defined(ANDROID)
#include "DKAndroid.h"
#elif defined(IOS)
#include "DKIos.h"
#else
#error NO KNOWN OS FLAG WAS STATED (WIN32,MAC,LINUX,ANDROID,IOS)
#endif

//DK
#include "DKClass.h"
#include "DKEvent.h"
#include "DKUtil.h"
#include "DKApp.h"

#ifdef DKAPP
	#include "DKPlugins.h"
#endif

#endif //DK_H
