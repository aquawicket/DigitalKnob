#include "DK/stdafx.h"
#include "DKPlugin.h"
#include "DKFile.h"

#ifdef WIN32
	std::vector<HINSTANCE> DKPlugins::modules;
#endif
std::vector<DKObject*> DKPlugins::dkobjs;

///////////////////////////////////////////////////
bool DKPlugins::LoadPlugin(const std::string& file)
{
#ifdef WIN32
	// Load the library
    HINSTANCE mod = LoadLibrary(file.c_str());
	if(!mod){ 
		DKLog("DKPlugins::LoadPlugin("+file+"): failed to load plugin. \n", DKERROR);
		return false; 
	}

	// Define the function types for what we are retrieving
	typedef void* (__cdecl *ObjProc)();
    typedef void* (__cdecl *NameProc)();

	// Retrive the functions
    ObjProc objFunc = (ObjProc) GetProcAddress(mod, "getObj");
    NameProc nameFunc = (NameProc) GetProcAddress(mod, "getName");

	if (!objFunc || !nameFunc){
		DKLog("DKPlugins::LoadPlugin("+file+"): failed to connect objFunc or nameFunc. \n", DKERROR);
		return false;
	}

	// push the objects and modules into our vectors
	dkobjs.push_back(static_cast<DKObject*>(objFunc()));
    modules.push_back(mod);
	DKString filename;
	DKFile::GetFileName(file, filename);
	DKLog("Plugin Loaded: "+filename+"\n");
	return true;
#endif
	return false;
}

//////////////////////////////
void DKPlugins::ClosePlugins()
{
#ifdef WIN32
	// Program finishing, time to clean up
    for (HINSTANCE hInst : modules)
        FreeLibrary(hInst);
#endif
}
