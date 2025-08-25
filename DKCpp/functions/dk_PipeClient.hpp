#pragma once
#ifndef dk_pipeClient_hpp
#define dk_pipeClient_hpp

#include "DK.hpp"


//################################################################################
//# dk_pipeClient()
//#
#include <windows.h>
#include <iostream>

HANDLE fileHandle;

void ReadString(char* output) {
	ULONG read = 0;
	int index = 0;
	do {
		ReadFile(fileHandle, output + index++, 1, &read, NULL);
	} while (read > 0 && *(output + index - 1) != 0);
};

int dk_pipeClient(){
	// create file
	fileHandle = CreateFileW(TEXT("\\\\.\\pipe\\my-very-cool-pipe-example"), GENERIC_READ | GENERIC_WRITE, FILE_SHARE_WRITE, NULL, OPEN_EXISTING, 0, NULL);

	// read from pipe server
	char* buffer = new char[100];
	memset(buffer, 0, 100);
	ReadString(buffer);

	std::cout << "read from pipe server: " << buffer << "\r\n";

	// send data to server
	const char* msg = "hello from c++\r\n";
	WriteFile(fileHandle, msg, strlen(msg), nullptr, NULL);
};


#endif //dk_pipeClient_hpp