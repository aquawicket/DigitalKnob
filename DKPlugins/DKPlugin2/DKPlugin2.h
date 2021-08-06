#pragma once
#ifndef DKPlugin2_H
#define DKPlugin2_H
#include "DKPlugin.h"

/////////////////////////////////////////////
class DKPlugin2 : public DKObjectT<DKPlugin2>
{
public:
	void Init();
	void End(){};
	void* SomeFunction(void* data);
};

extern "C" void* getObj() {
    return static_cast<void*>(DKPlugin2::Instance(""));
}

extern "C" void* getName() {
    return static_cast<void*>("DKPlugin2");
}


extern "C" DLLAPI BOOL APIENTRY DllMain(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpvReserved)
{
    switch (fdwReason)
    {
        case DLL_PROCESS_ATTACH:
            // attach to process
            // return FALSE to fail DLL load
            break;

        case DLL_PROCESS_DETACH:
            // detach from process
            break;

        case DLL_THREAD_ATTACH:
            // attach to thread
            break;

        case DLL_THREAD_DETACH:
            // detach from thread
            break;
    }
    return TRUE; // succesful
}

REGISTER_OBJECT(DKPlugin2, true);

#endif //DKPlugin2_H