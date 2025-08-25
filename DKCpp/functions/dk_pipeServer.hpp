#pragma once
#ifndef dk_pipeServer_hpp
#define dk_pipeServer_hpp

#include "DK.hpp"


//################################################################################
//# dk_pipeServer()
//#
//#		Reference:https://github.com/peter-bloomfield/win32-named-pipes-example/blob/master/src/server.cpp
//#
#include <iostream>
#include <windows.h>

int dk_pipeServer() {
    std::wcout << "Creating an instance of a named pipe..." << std::endl;

	std::string pipeName = "\\\\.\\pipe\\TestPipe";
	//LPCSTR sw = pipeName.c_str();
	
    // Create a pipe to send data
    HANDLE pipe = CreateNamedPipe(
        pipeName.c_str(), // name of the pipe
        PIPE_ACCESS_OUTBOUND, // 1-way pipe -- send only
        PIPE_TYPE_BYTE, // send data as a byte stream
        1, // only allow 1 instance of this pipe
        0, // no outbound buffer
        0, // no inbound buffer
        0, // use default wait time
        NULL // use default security attributes
        );

    if (pipe == NULL || pipe == INVALID_HANDLE_VALUE) {
        std::wcout << "Failed to create outbound pipe instance." << std::endl;
        // look up error code here using GetLastError()
        system("pause");
        return 1;
    }

    std::wcout << "Waiting for a client to connect to the pipe..." << std::endl;

    // This call blocks until a client process connects to the pipe
    BOOL result = ConnectNamedPipe(pipe, NULL);
    if (!result) {
        std::wcout << "Failed to make connection on named pipe." << std::endl;
        // look up error code here using GetLastError()
        CloseHandle(pipe); // close the pipe
        system("pause");
        return 1;
    }

    std::wcout << "Sending data to pipe..." << std::endl;

    // This call blocks until a client process reads all the data
    const wchar_t *data = L"*** Hello Pipe World ***";
    DWORD numBytesWritten = 0;
    result = WriteFile(
        pipe, // handle to our outbound pipe
        data, // data to send
        wcslen(data) * sizeof(wchar_t), // length of data to send (bytes)
        &numBytesWritten, // will store actual amount of data sent
        NULL // not using overlapped IO
        );

    if (result) {
        std::wcout << "Number of bytes sent: " << numBytesWritten << std::endl;
    } else {
        std::wcout << "Failed to send data." << std::endl;
        // look up error code here using GetLastError()
    }

    // Close the pipe (automatically disconnects client too)
    CloseHandle(pipe);

    std::wcout << "Done." << std::endl;

    system("pause");
    return 0;
};

#endif //dk_pipeServer_hpp