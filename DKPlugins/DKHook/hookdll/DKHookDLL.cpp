#include "windows.h"
#include "Strsafe.h"
#include "Tlhelp32.h"

#pragma data_seg (".SHARED")
	HHOOK keyboardHook = 0;
	HINSTANCE g_hInstance = 0;
	unsigned long exeProcId = 0;
#pragma data_seg()

#pragma comment(linker, "/SECTION:.SHARED,RWS")

BOOL APIENTRY DllMain(HMODULE hModule, DWORD  ul_reason_for_call, LPVOID lpReserved) 
{     
	switch (ul_reason_for_call){
		case DLL_PROCESS_ATTACH:
			g_hInstance  = (HINSTANCE) hModule;
			break;
		case DLL_THREAD_ATTACH:
		case DLL_THREAD_DETACH:
		case DLL_PROCESS_DETACH:
			break;
	} 

	return TRUE; 
}