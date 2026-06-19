#pragma once
#ifndef dk_pipeClient_hpp
#define dk_pipeClient_hpp

#include "DK.hpp"


//################################################################################
//# dk_pipeClient()
//#
//#		Reference:https://dev.to/gabbersepp/ipc-between-c-and-c-by-using-named-pipes-4em9
//#
#include <windows.h>
#include <iostream>

HANDLE fileHandle;

void GetInput(std::string& input){
	std::cout << ":";
	std::cin >> input;
};

void SendPipe(std::string& msg){
	msg = msg + std::string("\r\n"); // add carrage return;
	WriteFile(fileHandle, msg.c_str(), strlen(msg.c_str()), nullptr, NULL);
};

void ReadPipe(std::string& msg) {
	char* buffer = new char[100];
	memset(buffer, 0, 100);
	ULONG read = 0;
	int index = 0;
	do {
		ReadFile(fileHandle, buffer + index++, 1, &read, NULL);
	} while (read > 0 && *(buffer + index - 1) != '\n');
	msg = buffer;
};

/*
LPCWSTR TEXT(std::string s){
	std::wstring stemp = std::wstring(s.begin(), s.end());
	LPCWSTR sw = stemp.c_str();
	return sw;
};
*/

int dk_pipeClient(){
	//fileHandle = CreateFileW(TEXT("\\\\.\\pipe\\"+pipeName), GENERIC_READ | GENERIC_WRITE, FILE_SHARE_WRITE, NULL, OPEN_EXISTING, 0, NULL);
	std::string pipeName = "TestPipe";
	std::string s = "\\\\.\\pipe\\"+pipeName;
	std::wstring stemp = std::wstring(s.begin(), s.end());
	LPCWSTR sw = stemp.c_str();
	fileHandle = CreateFileW(sw, GENERIC_READ | GENERIC_WRITE, FILE_SHARE_WRITE, NULL, OPEN_EXISTING, 0, NULL);
	
	// send username
	std::cout << "Enter a username:";
	std::string username;
	GetInput(username);
	SendPipe(username);
	
	std::cout << "Connected to " << pipeName << " Server\n";
	
	while(1){
		// send data to server
		std::string input;
		GetInput(input);
		SendPipe(input);
		
		// read from server
		std::string output;
		ReadPipe(output);
		std::cout << output << "\r\n";	
	}
	return 0;
};


#endif //dk_pipeClient_hpp