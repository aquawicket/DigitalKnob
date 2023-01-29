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

#pragma once
#ifndef DKPlugin_H
#define DKPlugin_H

#include "DK/DKClass.h"
#include "DK/DKObject.h"
#include "DK/DKString.h"

WARNING_DISABLE
#include <vector>
WARNING_ENABLE

#if WIN
//#ifdef BUILD_DLL
    #define DLLAPI __declspec(dllexport)
//#else
//    #define DLLAPI
//#endif // BUILD_DLL
#else
	#define DLLAPI
#endif

#ifdef __cplusplus  // if we are compiling C++
extern "C" {        // export the functions with C linkage
#endif

// DLL export funcs
DLLAPI void* getObj();
DLLAPI void* getName();

#ifdef __cplusplus
}
#endif 

class DKPlugins{
public:
	static bool LoadPlugin(const std::string& file);
	static void ClosePlugins();

#if WIN
	static std::vector<HINSTANCE> modules;
#endif
	static std::vector<DKObject*> dkobjs;
};

#endif //DKPlugin_H