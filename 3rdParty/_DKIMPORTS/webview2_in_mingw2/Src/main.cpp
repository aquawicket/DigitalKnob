#define CINTERFACE
#include "WebView2.h"
#include "event.h"
#include <tchar.h>
#include <locale>
#include <string>
#ifndef UNICODE
#include <codecvt>
#endif

ICoreWebView2* webview2 = nullptr;
ICoreWebView2Controller* controller = nullptr;

std::wstring TStrToWStr(LPCTSTR str)
{
#ifdef UNICODE
    return std::wstring(str);
#else
	std::wstring_convert<std::codecvt_utf8_utf16<wchar_t>> converter;
	return converter.from_bytes(str);
#endif
}

void GetDataPath(LPTSTR szOut, DWORD nSize)
{
	TCHAR szExePath[MAX_PATH];
	GetModuleFileName(nullptr, szExePath, _countof(szExePath));

	LPTSTR szExeName = _tcsrchr(szExePath, TEXT('\\'));
	szExeName = szExeName ? szExeName + 1 : szExePath;

	TCHAR szAppData[MAX_PATH];
	GetEnvironmentVariable(TEXT("AppData"), szAppData, _countof(szAppData));

	_tcsncpy(szOut, szAppData, nSize);
	_tcsncat(szOut, TEXT("\\"), nSize);
	_tcsncat(szOut, szExeName, nSize);
}

[[ noreturn ]] void FatalError(LPCTSTR format, ...)
{
	MessageBox(nullptr, format, TEXT("webview2-mingw"), MB_OK | MB_ICONSTOP);
	ExitProcess(1);
}

void ResizeBrowser(HWND hWnd)
{
	if (!controller)
	{
		return;
	}
	RECT bounds;
	GetClientRect(hWnd, &bounds);
	controller->lpVtbl->put_Bounds(controller, bounds);
}

LRESULT WINAPI WndProc(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
	switch (msg)
	{
	case WM_SIZE:
		ResizeBrowser(hWnd);
		break;
	case WM_CLOSE:
		DestroyWindow(hWnd);
		break;
	case WM_DESTROY:
        PostQuitMessage(0);
		break;
	default:
		return DefWindowProc(hWnd, msg, wParam, lParam);
	}
	return 0;
}

INT WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, INT nCmdShow)
{
	UNREFERENCED_PARAMETER(hPrevInstance);
	UNREFERENCED_PARAMETER(lpCmdLine);
	UNREFERENCED_PARAMETER(nCmdShow);

	HICON icon = reinterpret_cast<HICON>(LoadImage(
		hInstance,
		IDI_APPLICATION,
		IMAGE_ICON,
		GetSystemMetrics(SM_CXICON),
		GetSystemMetrics(SM_CYICON),
		0
	));

	WNDCLASSEX wc{};
	wc.cbSize = sizeof(WNDCLASSEX);
	wc.hInstance = hInstance;
	wc.lpszClassName = TEXT("webview");
	wc.hIcon = icon;
	wc.hIconSm = icon;
	wc.lpfnWndProc = WndProc;
	RegisterClassEx(&wc);
	HWND hWnd = CreateWindowEx(
		0,
		TEXT("webview"),
		TEXT("MinGW WebView2 Demo"),
		WS_OVERLAPPEDWINDOW,
		CW_USEDEFAULT,
		CW_USEDEFAULT,
		1024,
		768,
		nullptr,
		nullptr,
		hInstance,
		nullptr
	);

	ShowWindow(hWnd, SW_SHOW);
	UpdateWindow(hWnd);
	SetFocus(hWnd);

	// Get data path.
	TCHAR szDataPath[MAX_PATH];
	GetDataPath(szDataPath, _countof(szDataPath));

	// Set up some event handlers.
	EventHandler handler{};

	handler.EnvironmentCompleted = [&](HRESULT result, ICoreWebView2Environment* created_environment)
	{
		if (FAILED(result))
		{
			FatalError(TEXT("Failed to create environment?"));
		}
		created_environment->lpVtbl->CreateCoreWebView2Controller(created_environment, hWnd, &handler);
		return S_OK;
	};

	handler.ControllerCompleted = [&](HRESULT result, ICoreWebView2Controller* new_controller)
	{
		if (FAILED(result))
		{
			FatalError(TEXT("Failed to create controller?"));
		}
		controller = new_controller;
		controller->lpVtbl->AddRef(controller);
		controller->lpVtbl->get_CoreWebView2(controller, &webview2);
		webview2->lpVtbl->AddRef(webview2);
		webview2->lpVtbl->Navigate(webview2, L"https://google.com");
		ResizeBrowser(hWnd);
		return S_OK;
	};

	HRESULT result = CreateCoreWebView2EnvironmentWithOptions(
		nullptr,
		TStrToWStr(szDataPath).c_str(),
		nullptr,
		&handler
	);
	if (FAILED(result))
	{
		FatalError(TEXT("Call to CreateCoreWebView2EnvironmentWithOptions failed!"));
	}

	MSG msg;
	while (GetMessage(&msg, nullptr, 0, 0))
	{
		if (msg.message == WM_QUIT)
		{
			break;
		}
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}

	return 0;
}
