#pragma once
#ifndef DKPlugin1_H
#define DKPlugin1_H

#include "DK/DKPlugin.h"

/////////////////////////////////////////////
class DKPlugin1 : public DKObjectT<DKPlugin1>
{
public:
	void Init();
	void End(){};
	bool SomeFunction(void* input, void* output);
};

extern "C" void* getObj() {
    return static_cast<void*>(DKPlugin1::Instance(""));
}

extern "C" void* getName() {
    return static_cast<void*>("DKPlugin1");
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

REGISTER_OBJECT(DKPlugin1, true);

#endif //DKPlugin1_H