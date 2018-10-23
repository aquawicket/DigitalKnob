//https://oroboro.com/stack-trace-on-crash

#include "DK/stdafx.h"
#include "DKDebug/DKDebug.h"
#include "DK/DKFile.h"
#include "DKAssets/DKAssets.h"
#include "DKCurl/DKCurl.h"
#include <stdio.h>

#ifdef WIN32
#include "StackWalker.h"
#include <tchar.h>
#include <fstream>
// secure-CRT_functions are only available starting with VC8
#if _MSC_VER < 1400
#define _tcscpy_s _tcscpy
#define _tcscat_s _tcscat
#define _stprintf_s _stprintf
#define strcpy_s(a, b, c) strcpy(a, c)
#endif

static BOOL s_bUnhandledExeptionFilterSet = FALSE;

#if defined _M_X64 || defined _M_IX86
////////////////////////////////////////////////
static BOOL PreventSetUnhandledExceptionFilter()
{
	HMODULE hKernel32 = LoadLibrary("kernel32.dll");
	if(hKernel32 == NULL) return FALSE;
	void *pOrgEntry = GetProcAddress(hKernel32, "SetUnhandledExceptionFilter");
	if(pOrgEntry == NULL) return FALSE;
 
#ifdef _M_IX86
	// Code for x86:
	// 33 C0                xor         eax,eax  
	// C2 04 00             ret         4 
	unsigned char szExecute[] = { 0x33, 0xC0, 0xC2, 0x04, 0x00 };
#elif _M_X64
	// 33 C0                xor         eax,eax 
	// C3                   ret  
	unsigned char szExecute[] = { 0x33, 0xC0, 0xC3 };
#else
#error "The following code only works for x86 and x64!"
#endif
 
	DWORD dwOldProtect = 0;
	BOOL bProt = VirtualProtect(pOrgEntry, sizeof(szExecute), PAGE_EXECUTE_READWRITE, &dwOldProtect);

	SIZE_T bytesWritten = 0;
	BOOL bRet = WriteProcessMemory(GetCurrentProcess(), pOrgEntry, szExecute, sizeof(szExecute), &bytesWritten);

	if((bProt != FALSE) && (dwOldProtect != PAGE_EXECUTE_READWRITE)){
		DWORD dwBuf;
		VirtualProtect(pOrgEntry, sizeof(szExecute), dwOldProtect, &dwBuf);
	}
	return bRet;
}
#else
#pragma message("This code works only for x86 and x64!")
#endif

///////////////////////////////////////////////
class StackWalkerToConsole : public StackWalker
{
protected:
	// do not print modules initialization
	void OnLoadModule(LPCSTR, LPCSTR, DWORD64, DWORD, DWORD, LPCSTR, LPCSTR, ULONGLONG){}
	// do not print symbols initialization
	void OnSymInit(LPCSTR, DWORD, LPCSTR){}
	virtual void OnOutput(LPCSTR szText){
		//DKLog("StackWalkerToConsole(): OnOutput\n");
		DKLog(szText, DKWARN);
	}
};

//////////////////////////////////////////////////////////////////////////////
static LONG __stdcall CrashHandlerExceptionFilter(EXCEPTION_POINTERS* pExPtrs)
{
#ifdef _M_IX86
	if(pExPtrs->ExceptionRecord->ExceptionCode == EXCEPTION_STACK_OVERFLOW){
		static char MyStack[1024*128];  // be sure that we have enought space...
		// it assumes that DS and SS are the same!!! (this is the case for Win32)
		// change the stack only if the selectors are the same (this is the case for Win32)
		//__asm push offset MyStack[1024*128];
		//__asm pop esp;
		__asm mov eax,offset MyStack[1024*128];
		__asm mov esp,eax;
	}
#endif

	DKLog("########## C++ CALL STACK ##########\n", DKWARN);
	StackWalkerToConsole sw;  // output to console
	sw.ShowCallstack(GetCurrentThread(), pExPtrs->ContextRecord);
	DKLog("\n");
  
	TCHAR lString[500];
	_stprintf_s(lString,
		_T("*** Unhandled Exception! See console output for more info\n")
		_T("   ExpCode: 0x%8.8X\n")
		_T("   ExpFlags: %d\n")
		_T("   ExpAddress: 0x%8.8X\n")
		_T("   Please report!"),
		pExPtrs->ExceptionRecord->ExceptionCode,
		pExPtrs->ExceptionRecord->ExceptionFlags,
		(unsigned int)pExPtrs->ExceptionRecord->ExceptionAddress);

	//Upload error file
	TCHAR filename[500];
	_stprintf_s(filename,_T("0x%8.8X"), (unsigned int)pExPtrs->ExceptionRecord->ExceptionAddress);

	if(!DKFile::Copy(DKFile::local_assets+"log.txt", DKFile::local_assets+DKString(filename)+".log", true, false)){ 
		return EXCEPTION_CONTINUE_SEARCH; 
	}
	
	DKCurl* dkCurl = DKCurl::Instance("DKCurl0");
	dkCurl->FtpConnect("ftp.aquawicket.com","dkupload","DKPassword123!", "21");
	dkCurl->FtpUpload(DKFile::local_assets+DKString(filename)+".log", "ftp.aquawicket.com/"+DKString(filename)+".log");

	FatalAppExit(-1, lString);
	return EXCEPTION_CONTINUE_SEARCH;
}

//////////////////////////////////////////
static void InitUnhandledExceptionFilter()
{
	if(s_bUnhandledExeptionFilterSet == FALSE){
		//set global exception handler (for handling all unhandled exceptions)
		SetUnhandledExceptionFilter(CrashHandlerExceptionFilter);
#if defined _M_X64 || defined _M_IX86
		PreventSetUnhandledExceptionFilter();
#endif
		s_bUnhandledExeptionFilterSet = TRUE;
	}
}
#endif //WIN32

// https://panthema.net/2008/0901-stacktrace-demangled/
#if !defined(WIN32) && !defined(ANDROID)
#include <execinfo.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>

////////////////////////////////////////////////////////////////////////////////////
static inline void printStackTrace(FILE *out = stderr, unsigned int max_frames = 63)
{
	DKString logfile = DKFile::local_assets+"log.txt";
	FILE* log = fopen(logfile.c_str(),"a");
	fprintf(out, "stack trace:\n");
	fprintf(log, "stack trace:\n");
 
	// storage array for stack trace address data
	void* addrlist[max_frames+1];
 
	// retrieve current stack addresses
	int addrlen = backtrace(addrlist, sizeof(addrlist) / sizeof(void*));
 
	if(addrlen == 0){ return; }
 
	// create readable strings to each frame.
	char** symbollist = backtrace_symbols(addrlist, addrlen);
 
	// print the stack trace.
	for(int i = 1; i < addrlen; i++ ){
		fprintf(out, "%s\n", symbollist[i]);
		fprintf(log, "%s\n", symbollist[i]);
	}

 	fclose(log);
	free(symbollist);
}

////////////////////////
void handler(int signum) 
{
	const char* name = NULL;
	switch(signum){
		case SIGABRT: name = "SIGABRT";  break;
		case SIGSEGV: name = "SIGSEGV";  break;
		case SIGBUS:  name = "SIGBUS";   break;
		case SIGILL:  name = "SIGILL";   break;
		case SIGFPE:  name = "SIGFPE";   break;
	}

	if(name){
		//fprintf( stderr, "Caught signal %d (%s)\n", signum, name );
		DKLog("Caught signal "+toString(signum)+" "+name+"\n", DKERROR);
	}
	else{
		//fprintf( stderr, "Caught signal %d\n", signum );
		DKLog("Caught signal "+toString(signum)+" \n", DKERROR);
	}
 
	printStackTrace();
 
	DKString filename = toString(signum);
	DKDebug::SendBugReport(filename);
	exit(signum);
}
#endif 

////////////////////
bool DKDebug::Init()
{
	DKDebug();
	DKClass::DKCreate("DKDebugJS");
	DKClass::DKCreate("DKDebugV8");
	
#ifdef WIN32
	//Copy PDB file if it exists
	DKString exename;
	DKFile::GetExeName(exename);
	DKFile::RemoveExtention(exename);
	DKString apppath;
	DKFile::GetAppPath(apppath);

#ifndef DEBUG
	//TODO: we need to do this in the build script. The exe will be using the .pdb, so the file is locked. 
	//DKLog("DKFile::Copy("+DKFile::local_assets+exename+".pdb,"+apppath+exename+".pdb)\n");
	//DKFile::Copy(DKFile::local_assets+exename+".pdb", apppath+exename+".pdb", true, true);
#endif

	InitUnhandledExceptionFilter();
#endif
#if !defined(WIN32) && !defined(ANDROID)
	signal(SIGABRT, handler);
	signal(SIGSEGV, handler);
	signal(SIGBUS,  handler);
	signal(SIGILL,  handler);
	signal(SIGFPE,  handler);
#endif

	DKClass::RegisterFunc("DKDebug::ShowStackTrace", &DKDebug::ShowStackTrace, this);

	return true;
}

///////////////////
bool DKDebug::End()
{
	DKDebug();
	return true;
}

/////////////////////////////////////////////////////
bool DKDebug::SendBugReport(const DKString& filename)
{
	DKDebug(filename);
	if(!DKFile::Copy(DKFile::local_assets+"log.txt", DKFile::local_assets+DKString(filename)+".log", true, false)){ return false; }
	DKCurl* dkCurl = DKCurl::Instance("DKCurl0");
	if(!dkCurl->FtpConnect("ftp.aquawicket.com","dkupload","DKPassword123!", "21")){ return false; }
	if(!dkCurl->FtpUpload(DKFile::local_assets+DKString(filename)+".log", "ftp.aquawicket.com/"+DKString(filename)+".log")){ return false; }
	return true;
}

/////////////////////////////////////////////////////////////
bool DKDebug::ShowStackTrace(const void* input, void* output)
{
	DKDebug();
	DKLog("########## C++ CALL STACK ##########\n", DKWARN);
#ifdef WIN32
	StackWalkerToConsole sw;  // output to console
	sw.ShowCallstack(GetCurrentThread(), NULL);
	DKLog("\n");
	return true;
#else
	DKLog("DKDebug::ShowStackTrace(): no implemented on this OS\n", DKERROR);
	return false;
#endif
}