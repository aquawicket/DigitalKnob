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
#include "DK/DKPlugin.h"
#include "DK/DKFile.h"

#if WIN
	std::vector<HINSTANCE> DKPlugins::modules;
#endif
std::vector<DKObject*> DKPlugins::dkobjs;

bool DKPlugins::LoadPlugin(const std::string& file){
#if WIN
	// Load the library
    HINSTANCE mod = LoadLibrary(file.c_str());
	if(!mod)
		return DKERROR("("+file+"): failed to load plugin.\n");
	// Define the function types for what we are retrieving
	typedef void* (__cdecl *ObjProc)();
    typedef void* (__cdecl *NameProc)();
	// Retrive the functions
    ObjProc objFunc = (ObjProc) GetProcAddress(mod, "getObj");
    NameProc nameFunc = (NameProc) GetProcAddress(mod, "getName");
	if(!objFunc || !nameFunc)
		return DKERROR("("+file+"): failed to connect objFunc or nameFunc.\n");
	// push the objects and modules into our vectors
	dkobjs.push_back(static_cast<DKObject*>(objFunc()));
    modules.push_back(mod);
	DKString filename;
	DKFile::GetFileName(file, filename);
	DKINFO("Plugin Loaded: "+filename+"\n");
	return true;
#endif
	return false;
}

void DKPlugins::ClosePlugins()
{
#if WIN
	// Program finishing, time to clean up
    for (HINSTANCE hInst : modules)
        FreeLibrary(hInst);
#endif
}
