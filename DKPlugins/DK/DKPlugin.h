#pragma once
#ifndef DKPlugin_H
#define DKPlugin_H

#include "DKClass.h"
#include "DKObject.h"
#include "DKString.h"
#include <vector>

#ifdef WIN32
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

#ifdef WIN32
	static std::vector<HINSTANCE> modules;
#endif
	static std::vector<DKObject*> dkobjs;
};

#endif //DKPlugin_H