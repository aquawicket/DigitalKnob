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

//https://oroboro.com/stack-trace-on-crash

#include "DK/stdafx.h"
#include "DKDebug/DKDebug.h"
#include "DK/DKFile.h"
#include "DKAssets/DKAssets.h"
#if HAVE_DKCurl 
	#include "DKCurl/DKCurl.h"
#endif

#include <stdio.h>


#if WIN32
WARNING_DISABLE
#include "StackWalker.h"
#include <tchar.h>
#include <fstream>
WARNING_ENABLE
// secure-CRT_functions are only available starting with VC8
#if _MSC_VER < 1400  //Visual Studio 2003
#define _tcscpy_s _tcscpy
#define _tcscat_s _tcscat
#define _stprintf_s _stprintf
#define strcpy_s(a, b, c) strcpy(a, c)
#endif

static BOOL s_bUnhandledExeptionFilterSet = FALSE;

#if _M_X64 || _M_IX86
static BOOL PreventSetUnhandledExceptionFilter(){
	DKDEBUGFUNC();
	HMODULE hKernel32 = LoadLibrary("kernel32.dll");
	if(hKernel32 == NULL) return FALSE;
	void *pOrgEntry = GetProcAddress(hKernel32, "SetUnhandledExceptionFilter");
	if(pOrgEntry == NULL) return FALSE;
#if _M_IX86
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


class StackWalkerToConsole : public StackWalker{
protected:
	// do not print modules initialization
	void OnLoadModule(LPCSTR, LPCSTR, DWORD64, DWORD, DWORD, LPCSTR, LPCSTR, ULONGLONG){
		//DKDEBUGFUNC();  //EXCESSIVE LOGGING
	}
	// do not print symbols initialization
	void OnSymInit(LPCSTR, DWORD, LPCSTR){
		DKDEBUGFUNC();
	}
	virtual void OnOutput(LPCSTR szText){
		//DKDEBUGFUNC(szText);  //EXCESSIVE LOGGING
		DKWARN(szText);
	}
};

static LONG __stdcall CrashHandlerExceptionFilter(EXCEPTION_POINTERS* pExPtrs){
	DKDEBUGFUNC(pExPtrs);
#if _M_IX86
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
	DKWARN("########## C++ CALL STACK ##########\n");
	StackWalkerToConsole sw;  // output to console
	sw.ShowCallstack(GetCurrentThread(), pExPtrs->ContextRecord);
	DKINFO("\n");
	TCHAR lString[500];
	_stprintf_s(lString,
		_T("*** Unhandled Exception! See console output for more info\n")
		_T("   ExpCode: 0x%8.8X\n")
		_T("   ExpFlags: %d\n")
		_T("   ExpAddress: 0x%8.8X\n")
		_T("   Please report!"),
		pExPtrs->ExceptionRecord->ExceptionCode,
		pExPtrs->ExceptionRecord->ExceptionFlags,
		//(unsigned int)pExPtrs->ExceptionRecord->ExceptionAddress);
		PtrToUint(pExPtrs->ExceptionRecord->ExceptionAddress));
	//Upload error file
	TCHAR filename[500];
	//_stprintf_s(filename,_T("0x%8.8X"), (unsigned int)pExPtrs->ExceptionRecord->ExceptionAddress);
	_stprintf_s(filename, _T("0x%8.8X"), PtrToUint(pExPtrs->ExceptionRecord->ExceptionAddress));
	if(!DKFile::Copy(DKFile::local_assets+"log.txt", DKFile::local_assets+DKString(filename)+".log", true, false))
		return EXCEPTION_CONTINUE_SEARCH; 
	//DKCurl* dkCurl = DKCurl::Instance("DKCurl0");
	//dkCurl->FtpConnect("ftp.aquawicket.com","dkupload","DKPassword123!", "21");
	//dkCurl->FtpUpload(DKFile::local_assets+DKString(filename)+".log", "ftp.aquawicket.com/"+DKString(filename)+".log");
	FatalAppExit((unsigned int)-1, lString);
	return EXCEPTION_CONTINUE_SEARCH;
}

static void InitUnhandledExceptionFilter(){
	DKDEBUGFUNC();
	if(s_bUnhandledExeptionFilterSet == FALSE){
		//set global exception handler (for handling all unhandled exceptions)
		SetUnhandledExceptionFilter(CrashHandlerExceptionFilter);
#if _M_X64 || _M_IX86
		PreventSetUnhandledExceptionFilter();
#endif
		s_bUnhandledExeptionFilterSet = TRUE;
	}
}
#endif //WIN32

// https://panthema.net/2008/0901-stacktrace-demangled/
#if !WIN32 && !ANDROID
#include <execinfo.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>

static inline void printStackTrace(FILE *out = stderr, unsigned int max_frames = 63){
	DKDEBUGFUNC(out, max_frames);
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

void handler(int signum) {
	DKDEBUGFUNC(signum);
	const char* name = NULL;
	switch(signum){
		case SIGABRT: name = "SIGABRT";  break;
		case SIGSEGV: name = "SIGSEGV";  break;
		case SIGBUS:  name = "SIGBUS";   break;
		case SIGILL:  name = "SIGILL";   break;
		case SIGFPE:  name = "SIGFPE";   break;
	}
	if(name){
		DKERROR("Caught signal "+toString(signum)+" "+name+"\n");
	}
	else{
		DKERROR("Caught signal "+toString(signum)+"\n");
	}
	printStackTrace();
	DKString filename = toString(signum);
	DKDebug::SendBugReport(filename);
	exit(signum);
}
#endif 


bool DKDebug::Init(){
	DKDEBUGFUNC();
	DKClass::DKCreate("DKDebugJS");
	DKClass::DKCreate("DKDebugV8");
#if WIN
	//Copy PDB file if it exists
	DKString exename;
	DKFile::GetExeName(exename);
	DKFile::RemoveExtention(exename);
	DKString apppath;
	DKFile::GetAppPath(apppath);
#if !DEBUG
	//TODO: we need to do this in the build script. The exe will be using the .pdb, so the file is locked. 
	//DKINFO("DKFile::Copy("+DKFile::local_assets+exename+".pdb,"+apppath+exename+".pdb)\n");
	//DKFile::Copy(DKFile::local_assets+exename+".pdb", apppath+exename+".pdb", true, true);
#endif
	InitUnhandledExceptionFilter();
#endif
#if !WIN32 && !ANDROID
	signal(SIGABRT, handler);
	signal(SIGSEGV, handler);
	signal(SIGBUS,  handler);
	signal(SIGILL,  handler);
	signal(SIGFPE,  handler);
#endif
	DKClass::RegisterFunc("DKDebug::ShowStackTrace", &DKDebug::ShowStackTrace, this);
	return true;
}

bool DKDebug::End(){
	DKDEBUGFUNC();
	DKClass::DKClose("DKDebugJS");
	DKClass::DKClose("DKDebugV8");
	return true;
}

bool DKDebug::SendBugReport(const DKString& filename){
	DKDEBUGFUNC(filename);
	if(!DKFile::Copy(DKFile::local_assets+"log.txt", DKFile::local_assets+DKString(filename)+".log", true, false))
		return DKERROR("DKFile::Copy() failed");
	//DKCurl* dkCurl = DKCurl::Instance("DKCurl0");
	//if(!dkCurl->FtpConnect("ftp.aquawicket.com","dkupload","DKPassword123!", "21")){ return false; }
	//if(!dkCurl->FtpUpload(DKFile::local_assets+DKString(filename)+".log", "ftp.aquawicket.com/"+DKString(filename)+".log")){ return false; }
	return true;
}

bool DKDebug::ShowStackTrace(const void* input, void* output){
	//DKDEBUGFUNC(input, output);  //EXCESSIVE LOGGING
	DK_UNUSED(input);
	DK_UNUSED(output);
#if WIN32
	DKWARN("########## C++ CALL STACK ##########\n");
	StackWalkerToConsole sw;
	sw.ShowCallstack(GetCurrentThread(), NULL); // output to console
	DKINFO("\n");
	return true;
#else
	return DKREDINFO("not implemented on this OS \n");
#endif
}
