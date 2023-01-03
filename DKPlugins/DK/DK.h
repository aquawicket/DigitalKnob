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
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/


// https://www.mantidproject.org/C++_Coding_Standards
#pragma once
#ifndef DK_H
#define DK_H

#include "DK/DKPreprocessor.h"

#if defined(WIN32)
#	include "DK/DKWindows.h"
#elif defined(MAC)
#	include "DK/DKMac.h"
#elif defined(IOS)
#	include "DK/DKIos.h"
#elif defined(LINUX)
#	include "DK/DKLinux.h"
#elif defined(RASPBERRY)
#	include "DK/DKLinux.h"
#elif defined(ANDROID)
#	include "DK/DKAndroid.h"
#elif defined(EMSCRIPTEN)
#	include "DK/DKEmscripten.h"
#else
#	error NO KNOWN PLATFORM FLAG WAS FOUND (WIN,MAC,LINUX,ANDROID,IOS,RASPBERRY)
#endif

#include "DK/DKClass.h"
#include "DK/DKEvents.h"
#include "DK/DKUtil.h"
#include "DK/DKApp.h"

#ifdef DKAPP
#	include "DKPlugins.h"
#endif

#endif
