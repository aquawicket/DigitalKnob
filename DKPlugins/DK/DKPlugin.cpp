#include "DK/stdafx.h"
#include "DKPlugin.h"
#include "DKFile.h"

#ifdef WIN32
	std::vector<HINSTANCE> DKPlugins::modules;
#endif
std::vector<DKObject*> DKPlugins::dkobjs;

bool DKPlugins::LoadPlugin(const std::string& file){
#ifdef WIN32
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
#ifdef WIN32
	// Program finishing, time to clean up
    for (HINSTANCE hInst : modules)
        FreeLibrary(hInst);
#endif
}
