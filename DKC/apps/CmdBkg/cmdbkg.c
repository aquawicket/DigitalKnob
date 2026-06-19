/* CmdBkg (c) 2016-2021 Mikael Sollenborn and Steffen Illhardt */
// Compilation: gcc -o cmdbkg.exe cmdbkg.c -Os -s -lgdi32 -ldwmapi -lgdiplus

#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <limits.h>
#undef UNICODE
#define UNICODE
#include <windows.h>
#include <dwmapi.h>
#include <tlhelp32.h>

#define HEADER "\nCmdBkg v3.0 : Mikael Sollenborn and Steffen Illhardt 2016-2021"
#define DEFAULT_TRANSPARENCY 33
#define DELAY 20
#define TIMEOUT (DELAY * 100)
#define WM_CON_EVENT (WM_APP + 1)
#define AUMID L"CmdBkg.2nd" // specified in the STARTUPINFOW structure to tag the second process, along with the STARTF_TITLEISAPPID flag
#define WCA_ACCENT_POLICY 19
#define ACCENT_DISABLED 0
#define ACCENT_ENABLE_BLURBEHIND 3
#define ACCENT_ENABLE_ACRYLICBLURBEHIND 4
#define STR_(v) #v
#define STR(m) STR_(m)

// Output usage information.
static inline void Help(FILE *stream)
{ /* clang-format off */
  fputs(
    "\nUsage: cmdbkg [\"file.[bmp|jpg|gif|png]\" [/t p] [/c [bg]] [/b] [/g|/a]]\n\n"
    "  /t  Transparency with p = percentage 0..100 (default " STR(DEFAULT_TRANSPARENCY) ").\n"
    "  /c  Center image and preserve aspect ratio. Optionally specify\n"
    "      background color with hex value format RRGGBB (default is the\n"
    "      color of the console buffer's upper left corner on start).\n"
    "  /b  Borders included.\n"
    "  /g  Glass background, only Windows 10 onwards.\n"
    "      This takes precedence over /a and is used as fall-back if acrylic fails.\n"
    "      If specified, option /t will be used for alpha blending with black:\n"
    "       For a console background set to black\n"
    "         0 yields a dark grayish background image with no color contrast\n"
    "        33 yields a frosted, grayish background image with low color contrast\n"
    "       100 yields a frosted background image with high color contrast\n"
    "  /a  Acrylic background, only Windows 10 v. 1803 (10.0.17134) onwards.\n"
    "      If specified, option /t will be used for alpha blending with black:\n"
    "       For a console background set to black\n"
    "         0 yields a dark grayish background image with almost no color contrast\n"
    "        33 yields a acrylic, grayish background image with low color contrast\n"
    "        99 yields a acrylic background image with high color contrast\n"
    "       100 yields the original background image\n"
    "\nSpecify no arguments to remove previous background.\n"
    "Specify /? as first argument to see this help message.\n",
    stream); /* clang-format on */
}

// Structure containing information about the received program options.
typedef struct tag_opt
{
  BOOL isFirst; // TRUE if the current process is the original process
  BOOL doHelp; // TRUE if /? was the first argument
  BOOL doBorders; // TRUE if /b is passed
  BOOL doCenter; // TRUE if /c is passed
  BOOL doGlass; // TRUE if /g is passed
  BOOL doAcrylic; // True if /a is passed
  wchar_t *imgPath; // path of the image file, will be NULL if either no argument or /? has been passed
  wchar_t *transparency; // pointer to the transparency definition in argList, will be NULL if /t is not passed
  wchar_t *color; // pointer to the color definition in argList, will be NULL if the color definition after /c is omitted
} opt_t;

// Structure containing data for the BackgroundRedrawThread thread.
typedef struct tag_thread_arg
{
  const HANDLE hRedrawEvent; // if the event is signalled the loop in the BackgroundRedrawThread thread will iterate once again
  const LPCRITICAL_SECTION pMtx; // pointer to a mutex object of type CRITICAL_SECTION which prevents us from data races and unsynchronized drawing
  const HBITMAP hBmp; // handle to the original bitmap
  const BOOL doCenter; // center the image on the background (TRUE) or stretch to fit (FALSE)
  SIZE size; // width and height of the background rectangle to be used, might get updated to become the size of the image to be drawn
  BOOL forceRedraw; // copy of the global forceRedraw value
  BOOL sigExit; // TRUE signals the thread to quit
} thread_arg_t;

// Structure used along with SetWindowCompositionAttribute to enable blurred (acrylic) background effects.
typedef struct tag_window_composition_attrib_data
{
  DWORD attrib;
  LPVOID pData;
  DWORD cbData;
} window_composition_attrib_data_t;

// Structure pointed to by the pData member of window_composition_attrib_data_t.
typedef struct tag_accent_policy
{
  DWORD accentState;
  DWORD accentFlags;
  DWORD gradientColor;
  DWORD animationId;
} accent_policy_t;

// SetWindowCompositionAttribute is not defined in any header, we need to pull the address at runtime.
typedef BOOL(WINAPI *set_window_composition_attribute_t)(HWND hWnd, window_composition_attrib_data_t *data);

// Parse the received program options.
BOOL GetOpt(int argc, wchar_t **argv, opt_t *pOpt);
// Create the process for the background window.
BOOL CreateBkgProcess(wchar_t *cmdLine);
// Read the background color of a character cell and convert it from 4-bit RGBI (actually in IRGB order) to 24-bit RGB.
DWORD GetConsoleBkgColor(void);
// Try to get the PID of the conhost.exe process which owns the console window. If it fails (e.g. prior to Win 10) we get 0 back, which is still good enough for SetWinEventHook. However, in this case we will have an unnecessary CPU base load in the callback function coming from other windows.
DWORD GetConHostProcessId(void);
// Thread function to redraw the background window. It'll prevent the message queue from growing if we do this asynchronously.
DWORD WINAPI BackgroundRedrawThread(void *pThdArg);
// Find the window where the user data field contains the console window handle (previous background window, if any), and close it.
BOOL CALLBACK CloseWindowByUserDataCB(HWND hWnd, LPARAM lPConWnd);
// Window callback function necessary to handle WM_NCPAINT and WM_DESTROY.
LRESULT CALLBACK WindowMessageCB(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam);
// Receive window events and post WM_CON_EVENT or WM_CLOSE to the message queue if the event came from the console window. (make the message loop iterate)
void CALLBACK WinEventCB(HWINEVENTHOOK hHook, DWORD event, HWND hWnd, LONG obj, LONG child, DWORD thread, DWORD time);
// Check if we are able to read an image in the passed file.
BOOL CheckImgFile(const wchar_t *imagePath);
// Read the content of an image file, convert it to a bitmap in memory, and return a handle of it.
HBITMAP GetHBitmapFromFile(const wchar_t *imagePath, DWORD gesso, BOOL doCenter);

HWND conWnd = NULL, bkgWnd = NULL; // console and background window handles need to be global because we can't pass them to WinEventCB
BOOL forceRedraw = TRUE; // initially TRUE, elsewise TRUE if WM_NCPAINT is processed in the message callback

int main(void)
{
  conWnd = GetConsoleWindow();
  if (!conWnd || !SendMessageW(conWnd, WM_GETICON, 0U, 0)) // the latter roughly verifies that the window is a console (rather than a terminal emulator)
  {
    fputs("\nCmdBkg error: Unable to prepare window creation.\n", stderr);
    return 1;
  }

  int argCount = 0;
  wchar_t *cmdLine = GetCommandLineW();
  wchar_t **argList = CommandLineToArgvW(cmdLine, &argCount);
  if (argList == NULL)
  {
    fputs("\nCmdBkg error: Unable to get arguments.\n", stderr);
    return 1;
  }

  opt_t opt = { 0 };
  if (!GetOpt(argCount, argList, &opt))
  {
    LocalFree(argList);
    fputs("\nCmdBkg syntax error.\n", stderr);
    Help(stderr);
    return 1;
  }

  if (opt.doHelp) // show help
  {
    LocalFree(argList);
    puts(HEADER);
    Help(stdout);
    return 0;
  }

  SetLayeredWindowAttributes(conWnd, 0UL, 0xFF, LWA_ALPHA); // opaque (if the window isn't layered this call will fail without downside because it's already opaque)
  if (opt.imgPath == NULL) // no argument passed => quit without background window
  {
    LocalFree(argList);
    EnumWindows(CloseWindowByUserDataCB, (LPARAM)conWnd); // close the background window running for the monitored console (if any)
    return 0;
  }

  if (opt.isFirst) // if this is the original process, create a new asynchronously running process for the background window (if it's worth it), and quit
  {
    EnumWindows(CloseWindowByUserDataCB, (LPARAM)conWnd); // close the background window running for the monitored console (if any)
    const BOOL isGood = CheckImgFile(opt.imgPath); // before creating a new process, check if we can read the image in order to report a possible error still synchronously
    LocalFree(argList); // can't be done earlier, opt.imgPath points to an element in argList
    if (!isGood)
    {
      fputs("\nCmdBkg error: Unable to load image.\n", stderr);
      return 1;
    }

    SetWindowLongPtrW(conWnd, GWL_EXSTYLE, GetWindowLongPtrW(conWnd, GWL_EXSTYLE) | WS_EX_LAYERED); // transparency can only be updated if the window is layered
    if (!CreateBkgProcess(cmdLine))
    {
      fputs("\nCmdBkg error: Creation of background process failed.\n", stderr);
      return 1;
    }

    return 0;
  }

  // everything from this point onwards is for the background process only

  const DWORD gesso = opt.color ? wcstoul(opt.color, NULL, 16) & 0xFFFFFF : GetConsoleBkgColor(); // order 00RRGGBB (ARGB with alpha being ignored)
  WNDCLASSW wndCls = { 0 };
  wndCls.lpszClassName = L"CmdBkgWindowBackground";
  wndCls.lpfnWndProc = WindowMessageCB;
  wndCls.hbrBackground = CreateSolidBrush(((gesso & 0xFF0000) >> 16) | (gesso & 0xFF00) | ((gesso & 0xFF) << 16)); // order 00BBGGRR (COLORREF)
  wndCls.hCursor = LoadCursorW(NULL, IDC_ARROW);
  if (!RegisterClassW(&wndCls) || !(bkgWnd = CreateWindowExW(WS_EX_TOOLWINDOW, wndCls.lpszClassName, NULL, WS_POPUP | WS_VISIBLE, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, NULL, NULL, NULL, NULL)))
  {
    LocalFree(argList);
    return 1;
  }

  SetWindowLongPtrW(bkgWnd, GWLP_USERDATA, (LONG_PTR)conWnd); // the user data field contains the console window handle for the sake of finding it from within another instance of cmdbkg
  FreeConsole(); // don't move this line to a position before GetConsoleBkgColor is still called, or before the user data field contains the console window handle because WaitForInputIdle will return after this line
  RECT wndBounds = { 0 }, extendedBounds = { 0 };
  long frameWidth = 0L, frameOverallHight = 0L, frameTitleHight = 0L;
  GetWindowRect(conWnd, &wndBounds);
  DwmGetWindowAttribute(conWnd, DWMWA_EXTENDED_FRAME_BOUNDS, &extendedBounds, (DWORD)sizeof(extendedBounds));
  if (!opt.doBorders || (opt.doBorders && extendedBounds.left != wndBounds.left))
  {
    frameWidth = GetSystemMetrics(SM_CXSIZEFRAME);
    if (!opt.doBorders)
      frameTitleHight = GetSystemMetrics(SM_CYSIZEFRAME) + GetSystemMetrics(SM_CYCAPTION);

    frameOverallHight = frameTitleHight + GetSystemMetrics(SM_CYSIZEFRAME);
  }

  const HBITMAP hBmp = GetHBitmapFromFile(opt.imgPath, gesso, opt.doCenter);
  const unsigned long transparencyDegree = opt.transparency ? wcstoul(opt.transparency, NULL, 10) : DEFAULT_TRANSPARENCY;
  LocalFree(argList); // don't move this line to a position before opt.imgPath, opt.transparency, or opt.color is still used, they point to elements in argList
  if (!hBmp)
    return 1;

  CRITICAL_SECTION mtx = { 0 };
  thread_arg_t tArg = { CreateEventW(NULL, FALSE, FALSE, NULL), &mtx, hBmp, opt.doCenter, { 1, 1 }, forceRedraw, FALSE };
  if (!tArg.hRedrawEvent)
  {
    DeleteObject(hBmp);
    return 1;
  }

  const HWINEVENTHOOK hHook = SetWinEventHook(EVENT_OBJECT_DESTROY, EVENT_OBJECT_LOCATIONCHANGE, NULL, WinEventCB, GetConHostProcessId(), 0UL, WINEVENT_OUTOFCONTEXT | WINEVENT_SKIPOWNPROCESS);
  if (!hHook)
  {
    CloseHandle(tArg.hRedrawEvent);
    DeleteObject(hBmp);
    return 1;
  }

  const HANDLE hThread = CreateThread(NULL, 0U, BackgroundRedrawThread, &tArg, 0UL, NULL);
  if (!hThread)
  {
    UnhookWinEvent(hHook);
    CloseHandle(tArg.hRedrawEvent);
    DeleteObject(hBmp);
    return 1;
  }

  InitializeCriticalSection(tArg.pMtx); // late for a reason, it's not yet accessed and we would have had to delete it for any previous error ...
  const unsigned long alpha = (255UL * (100UL - (transparencyDegree > 100UL ? DEFAULT_TRANSPARENCY : transparencyDegree)) + 50UL) / 100UL;
  accent_policy_t accentPolicy = { 0UL, 2UL, alpha << 24UL, 0UL }; // gradientColor order AABBGGRR with alpha being defined, and the color portion left 0 (black)
  window_composition_attrib_data_t attrData = { WCA_ACCENT_POLICY, &accentPolicy, (DWORD)sizeof(accentPolicy) };
  set_window_composition_attribute_t pSetWindowCompositionAttribute = NULL;
  if ((opt.doGlass || opt.doAcrylic) && (pSetWindowCompositionAttribute = (set_window_composition_attribute_t)(INT_PTR)GetProcAddress(GetModuleHandleA("user32.dll"), "SetWindowCompositionAttribute")))
  {
    accentPolicy.accentState = opt.doGlass ? ACCENT_ENABLE_BLURBEHIND : ACCENT_ENABLE_ACRYLICBLURBEHIND;
    if (!pSetWindowCompositionAttribute(conWnd, &attrData))
    {
      accentPolicy.accentState = ACCENT_ENABLE_BLURBEHIND; // fall back to frosty glass
      pSetWindowCompositionAttribute(conWnd, &attrData);
    }

    if (opt.doAcrylic) // acrylic is buggy and needs a little workaround to get effective
    {
      PulseEvent(tArg.hRedrawEvent);
      Sleep(1UL);
      EnterCriticalSection(tArg.pMtx);
      LeaveCriticalSection(tArg.pMtx);
      Sleep(40UL);
    }
  }
  else
    SetLayeredWindowAttributes(conWnd, 0UL, (const BYTE)alpha, LWA_ALPHA); // transparent

  if (GetForegroundWindow() == bkgWnd)
    SetForegroundWindow(conWnd);

  BOOL doRearrange = TRUE, isMinimizedBkg = FALSE;
  UINT_PTR timerId = 0U;
  MSG msg = { 0 };
  while (GetMessageW(&msg, NULL, 0U, 0U))
  {
    if (msg.message == WM_CON_EVENT)
      doRearrange = TRUE;
    else if (msg.message == WM_TIMER && msg.wParam == timerId) // ready to restore the background window
    {
      KillTimer(NULL, timerId);
      timerId = 0U;
      isMinimizedBkg = FALSE; // not yet, but later within this iteration
    }
    else
      DispatchMessageW(&msg);

    if (!isMinimizedBkg)
    {
      if (doRearrange || forceRedraw)
      {
        GetWindowRect(conWnd, &wndBounds);
        const SIZE wndSize = { wndBounds.right - wndBounds.left - frameWidth * 2, wndBounds.bottom - wndBounds.top - frameOverallHight };
        SetWindowPos(bkgWnd, conWnd, wndBounds.left + frameWidth, wndBounds.top + frameTitleHight, wndSize.cx, wndSize.cy, SWP_SHOWWINDOW | SWP_NOACTIVATE);
        if (IsIconic(conWnd))
          isMinimizedBkg = TRUE; // SetWindowPos did it
        else if (TryEnterCriticalSection(tArg.pMtx)) // Try... because (to keep the window responsive) we want to skip redrawing as long as the thread is busy
        {
          PulseEvent(tArg.hRedrawEvent); // let the thread move to EnterCriticalSection, we can still safely update the tArg members because we own the mutex
          tArg.forceRedraw = forceRedraw; // we need a copy to avoid data races
          tArg.size = wndSize; // same here
          LeaveCriticalSection(tArg.pMtx); // the final go for the thread since it can take ownership of the mutex now
          doRearrange = FALSE;
          forceRedraw = FALSE;
        }
      }
    }
    else if (!timerId && !IsIconic(conWnd))
      timerId = SetTimer(NULL, 0U, DELAY * 10, NULL); // let the console fade in before we restore the background, but don't block the message loop while we are waiting
  }

  UnhookWinEvent(hHook);
  if (pSetWindowCompositionAttribute)
  {
    accentPolicy.accentState = ACCENT_DISABLED;
    pSetWindowCompositionAttribute(conWnd, &attrData); // remove the fuzzyness from the console background
  }

  EnterCriticalSection(tArg.pMtx); // once that we own the mutex, we know that the thread stucks in WaitForSingleObject, listening for the redraw event
  tArg.sigExit = TRUE; // now we can safely set sigExit to TRUE which will get evaluated as soon as (but not before) the redraw event is signalled
  PulseEvent(tArg.hRedrawEvent); // make WaitForSingleObject return, but sigExit is TRUE whereupon the loop in the thread is left instantly and the thread exits
  DeleteObject(hBmp);
  WaitForSingleObject(hThread, DELAY);
  CloseHandle(tArg.hRedrawEvent);
  CloseHandle(hThread);
  LeaveCriticalSection(tArg.pMtx);
  DeleteCriticalSection(tArg.pMtx);
  return 0;
}

BOOL GetOpt(int argc, wchar_t **argv, opt_t *pOpt) // relies on the referenced opt_t object being zero-initialized
{
  STARTUPINFOW startInfo = { 0 };
  GetStartupInfoW(&startInfo);
  pOpt->isFirst = (!(startInfo.dwFlags & STARTF_TITLEISAPPID) || !startInfo.lpTitle || wcscmp(startInfo.lpTitle, AUMID) != 0); // for the second run we specified an AppUserModelID along with flag STARTF_TITLEISAPPID

  // first run => verify and validate everything in order to report syntax errors synchronously (in the second run it would be asynchronously)
  if (pOpt->isFirst)
  {
    if (argc < 2)
      return TRUE;

    if (wcscmp(argv[1], L"/?") == 0)
    {
      pOpt->doHelp = TRUE;
      return TRUE;
    }

    pOpt->imgPath = argv[1];
    for (wchar_t **pArg = argv + 2, **end = argv + argc; pArg < end; ++pArg) // the image path is at index 1, so we start with index 2 to process the remaining arguments
    {
      if (**pArg == L'/')
      {
        if (_wcsicmp(L"b", *pArg + 1) == 0)
          pOpt->doBorders = TRUE;
        else if (_wcsicmp(L"g", *pArg + 1) == 0)
          pOpt->doGlass = TRUE;
        else if (_wcsicmp(L"a", *pArg + 1) == 0)
          pOpt->doAcrylic = TRUE;
        else if (_wcsicmp(L"t", *pArg + 1) == 0)
        {
          if (pArg + 1 == end || *pArg[1] == L'/')
            return FALSE;

          pOpt->transparency = *++pArg;
        }
        else if (_wcsicmp(L"c", *pArg + 1) == 0)
        {
          pOpt->doCenter = TRUE;
          if (pArg + 1 != end && *pArg[1] != L'/')
            pOpt->color = *++pArg;
        }
        else
          return FALSE;
      }
    }

    return (argc == (2 + pOpt->doBorders + ((pOpt->transparency != NULL) << 1) + pOpt->doCenter + (pOpt->color != NULL) + pOpt->doGlass + pOpt->doAcrylic)); // for simplification of parsing in the second run it's also necessary to verify that we didn't receive any additional arguments
  }

  // second run => just assign the struct members and return TRUE because the syntax check has been done in the first run already, furthermore we would never get to this point if either no argument or if /? had been passed
  pOpt->imgPath = argv[1];
  for (wchar_t **pArg = argv + 2, **end = argv + argc; pArg < end; ++pArg)
  {
    switch ((*pArg)[1])
    {
      case L'b':
      case L'B':
        pOpt->doBorders = TRUE;
        break;
      case L'g':
      case L'G':
        pOpt->doGlass = TRUE;
        break;
      case L'a':
      case L'A':
        pOpt->doAcrylic = TRUE;
        break;
      case L't':
      case L'T':
        pOpt->transparency = *++pArg;
        break;
      default: // if we reach this, only option /c will be left over
        pOpt->doCenter = TRUE;
        if (pArg + 1 != end && *pArg[1] != L'/')
          pOpt->color = *++pArg;
    }
  }

  return TRUE;
}

BOOL CreateBkgProcess(wchar_t *cmdLine)
{
  PROCESS_INFORMATION procInfo = { 0 };
  STARTUPINFOW startInfo = { .cb = (DWORD)sizeof(STARTUPINFOW), .lpTitle = AUMID, .dwFlags = STARTF_TITLEISAPPID }; // specify an AppUserModelID along with flag STARTF_TITLEISAPPID to indicate the second run
  if (!CreateProcessW(NULL, cmdLine, NULL, NULL, FALSE, 0UL, NULL, NULL, &startInfo, &procInfo)) // start the child process
    return FALSE;

  WaitForInputIdle(procInfo.hProcess, TIMEOUT); // ensure the child process' window can already be found before we return to our parent
  CloseHandle(procInfo.hThread);
  CloseHandle(procInfo.hProcess);
  return TRUE;
}

DWORD GetConsoleBkgColor(void)
{
  const HANDLE hOut = CreateFileW(L"CONOUT$", GENERIC_READ | GENERIC_WRITE, FILE_SHARE_READ | FILE_SHARE_WRITE, NULL, OPEN_EXISTING, 0UL, NULL); // because stdout could be redirected ...
  if (hOut != INVALID_HANDLE_VALUE)
  {
    WORD attr = 0;
    const BOOL isGood = ReadConsoleOutputAttribute(hOut, &attr, 1UL, (COORD){ 0 }, &*(DWORD[]){ 0UL });
    CloseHandle(hOut);
    if (isGood)
    { // 4-Bit RGBI, converted using 0xAA (2/3 0xFF) for dark colors and 0x55 (1/3 0xFF) added for brightness to make "dark white" lighter than "bright black"
      const DWORD bright = (attr & BACKGROUND_INTENSITY) ? 0x55UL : 0x00UL;
      return ((((attr & BACKGROUND_RED) ? 0xAA : 0x00) + bright) << 16) | ((((attr & BACKGROUND_GREEN) ? 0xAA : 0x00) + bright) << 8) | (((attr & BACKGROUND_BLUE) ? 0xAA : 0x00) + bright);
    }
  }

  return 0UL;
}

DWORD GetConHostProcessId(void)
{
  DWORD conPid = 0UL, hostPid = 0UL;
  PROCESSENTRY32W procEntry = { .dwSize = (DWORD)sizeof(PROCESSENTRY32W) };
  GetWindowThreadProcessId(conWnd, &conPid); // for a console window GetWindowThreadProcessId publishes the PID of the console process which is NOT the owner of the window
  const HANDLE hProcSnap = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0UL);
  if (hProcSnap == INVALID_HANDLE_VALUE)
    return 0UL;

  for (BOOL isGood = Process32FirstW(hProcSnap, &procEntry); isGood; isGood = Process32NextW(hProcSnap, &procEntry))
  {
    if (procEntry.th32ParentProcessID == conPid && wcscmp(procEntry.szExeFile, L"conhost.exe") == 0) // conhost.exe is the owner of the window
    {
      hostPid = procEntry.th32ProcessID;
      break;
    }
  }

  CloseHandle(hProcSnap);
  return hostPid;
}

DWORD WINAPI BackgroundRedrawThread(void *pThdArg)
{
  thread_arg_t *pTArg = pThdArg;
  BITMAP bmp = { 0 };
  const HDC hDcWnd = GetObjectW(pTArg->hBmp, (int)sizeof(BITMAP), &bmp) ? GetDC(bkgWnd) : NULL, hDcBmp = hDcWnd ? CreateCompatibleDC(hDcWnd) : NULL;
  if (!hDcBmp) // unable to get the prerequisites for the thread tasks, bail out after triggering the window to close
  {
    if (hDcWnd)
      ReleaseDC(bkgWnd, hDcWnd);

    PostMessageW(bkgWnd, WM_CLOSE, 0U, 0); // once the message loop is entered, it'll dispatch the close message which finally results in the termination of the process
    return 0UL;
  }

  HBITMAP hBmpScaled = NULL; // handle to the previously scaled image
  SIZE prevBkgSize = { 0 }, prevImgSize = { 0 }; // previous size of the background window, previous size of the image on the background window
  const long ratioH = (bmp.bmHeight << 4) / bmp.bmWidth, ratioW = (bmp.bmWidth << 4) / bmp.bmHeight;
  while (WaitForSingleObject(pTArg->hRedrawEvent, INFINITE) == WAIT_OBJECT_0 && !pTArg->sigExit) // event loop, iterates only if the event is signalled and the thread was not forced to quit
  {
    EnterCriticalSection(pTArg->pMtx);
    if (pTArg->forceRedraw || !hBmpScaled || memcmp(&pTArg->size, &prevBkgSize, sizeof(SIZE))) // redrawing required
    {
      prevBkgSize = pTArg->size; // save the current size of the background window early, pTArg->size might get updated to the size of the scaled image in the doCenter branch
      POINT imgPos = { 0 };
      if (pTArg->doCenter)
      { // calculate position and size of the image, to avoid flicker redraw only background areas which are not covered by the image
        if ((prevBkgSize.cy << 4) / prevBkgSize.cx < ratioH) // redraw the background at the left and right side
        {
          pTArg->size.cx = (prevBkgSize.cx * ratioW * pTArg->size.cy / prevBkgSize.cx + 8) >> 4;
          imgPos.x = (((prevBkgSize.cx - pTArg->size.cx) << 3) + 8) >> 4;
          RedrawWindow(bkgWnd, &(RECT){ 0L, 0L, imgPos.x, pTArg->size.cy }, NULL, RDW_ERASE | RDW_INVALIDATE);
          RedrawWindow(bkgWnd, &(RECT){ imgPos.x + pTArg->size.cx, 0L, prevBkgSize.cx, pTArg->size.cy }, NULL, RDW_ERASE | RDW_INVALIDATE | RDW_UPDATENOW);
        }
        else // redraw the background at the top and bottom
        {
          pTArg->size.cy = (prevBkgSize.cy * ratioH * pTArg->size.cx / prevBkgSize.cy + 8) >> 4;
          imgPos.y = (((prevBkgSize.cy - pTArg->size.cy) << 3) + 8) >> 4;
          RedrawWindow(bkgWnd, &(RECT){ 0L, 0L, pTArg->size.cx, imgPos.y }, NULL, RDW_ERASE | RDW_INVALIDATE);
          RedrawWindow(bkgWnd, &(RECT){ 0L, imgPos.y + pTArg->size.cy, pTArg->size.cx, prevBkgSize.cy }, NULL, RDW_ERASE | RDW_INVALIDATE | RDW_UPDATENOW);
        }
      }

      if (!hBmpScaled || !pTArg->doCenter || memcmp(&pTArg->size, &prevImgSize, sizeof(SIZE))) // CopyImage is by far the most expensive function in CmdBkg, we will only call it if absolutely necessary
      {
        prevImgSize = pTArg->size;
        if (hBmpScaled)
          DeleteObject(hBmpScaled);

        hBmpScaled = (HBITMAP)CopyImage((HANDLE)pTArg->hBmp, IMAGE_BITMAP, (int)pTArg->size.cx, (int)pTArg->size.cy, LR_DEFAULTCOLOR);
      }

      if (hBmpScaled)
      {
        const HGDIOBJ hExchange = SelectObject(hDcBmp, (HGDIOBJ)hBmpScaled);
        if (hExchange != NULL)
        {
          BitBlt(hDcWnd, (int)imgPos.x, (int)imgPos.y, (int)pTArg->size.cx, (int)pTArg->size.cy, hDcBmp, 0, 0, SRCCOPY); // draw the bitmap
          hBmpScaled = (HBITMAP)SelectObject(hDcBmp, hExchange);
        }
      }
    } // redrawing required

    Sleep(1UL); // deceleration, saves us ~25% of the CPU usage that we would have without this 1 ms delay
    PostMessageW(bkgWnd, WM_PAINT, 0U, 0); // the last update of the background may not be effective without this WM_PAINT message, it works best after the 1 ms delay
    LeaveCriticalSection(pTArg->pMtx);
  } // event loop

  if (hBmpScaled)
    DeleteObject(hBmpScaled);

  DeleteDC(hDcBmp);
  ReleaseDC(bkgWnd, hDcWnd);
  return 0UL;
}

BOOL CALLBACK CloseWindowByUserDataCB(HWND hWnd, LPARAM lPConWnd)
{
  if (GetWindowLongPtrW(hWnd, GWLP_USERDATA) != lPConWnd)
    return TRUE;

  SendNotifyMessageW(hWnd, WM_CLOSE, 0U, 0);
  for (int i = 0; i++ < TIMEOUT / DELAY && IsWindow(hWnd); Sleep(DELAY)) // ensure the window has been closed before we return
    ;

  return FALSE;
}

LRESULT CALLBACK WindowMessageCB(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
  if (msg == WM_DESTROY)
  {
    SetLayeredWindowAttributes(conWnd, 0UL, 0xFF, LWA_ALPHA); // make the console opaque again
    PostQuitMessage(0);
    return 0U;
  }

  if (msg == WM_NCPAINT) // if the window was partially moved across the edges of the screen, the parts of the picture which have been invisible won't get restored
    forceRedraw = TRUE; // indicate to force painting the picture new in this case

  return DefWindowProcW(hWnd, msg, wParam, lParam);
}

void CALLBACK WinEventCB(HWINEVENTHOOK hHook, DWORD event, HWND hWnd, LONG obj, LONG child, DWORD thread, DWORD time)
{
  hHook = hHook, obj = obj, child = child, thread = thread, time = time; // unused
  if (conWnd != hWnd)
    return;

  if (event == EVENT_OBJECT_LOCATIONCHANGE || event == EVENT_OBJECT_FOCUS)
    PostMessageW(bkgWnd, WM_CON_EVENT, 0U, 0);
  else if (event == EVENT_OBJECT_DESTROY)
    PostMessageW(bkgWnd, WM_CLOSE, 0U, 0);
}

// GDI+ headers are C++-only in MS Visual Studio (even dependencies of the Flat API). Instead of including <gdiplus.h> we declare the necessary things here, simplified to just meet our needs. However, the gdiplus lib has to be linked.
typedef struct tag_GdiplusStartupInput
{
  UINT32 GdiplusVersion;
  void *DebugEventCallback; // simplified, we will always assign NULL
  BOOL SuppressBackgroundThread;
  BOOL SuppressExternalCodecs;
} GdiplusStartupInput;

int __stdcall GdiplusStartup(ULONG_PTR *pTokenOut, const GdiplusStartupInput *pInput, void *pOutput); // pOutput simplified, we will always pass NULL
void __stdcall GdiplusShutdown(ULONG_PTR token);
int __stdcall GdipCreateBitmapFromFile(const wchar_t *fileName, LPVOID *pBitmapOut);
int __stdcall GdipCreateHBITMAPFromBitmap(LPVOID bitmap, HBITMAP *pHBmpOut, DWORD backgroundColor);
int __stdcall GdipGetImageWidth(LPVOID image, unsigned *pWidthOut);
int __stdcall GdipGetImageHeight(LPVOID image, unsigned *pHeightOut);
int __stdcall GdipDisposeImage(LPVOID image);

BOOL CheckImgFile(const wchar_t *imagePath)
{
  ULONG_PTR gpToken = 0U;
  LPVOID gpBmp = NULL;
  GdiplusStartup(&gpToken, &(GdiplusStartupInput){ 1U, NULL, FALSE, FALSE }, NULL);
  GdipCreateBitmapFromFile(imagePath, &gpBmp);
  BOOL isGood = (gpBmp != NULL);
  if (isGood)
  {
    unsigned width = 0U, height = 0U;
    GdipGetImageWidth(gpBmp, &width);
    GdipGetImageHeight(gpBmp, &height);
    GdipDisposeImage(gpBmp);
    isGood = (width > 0U && width <= (LONG_MAX >> 4) && height > 0U && height <= (LONG_MAX >> 4)); // in later calculations we shift 4 bits left, ensure we wouldn't cause an overflow of type long
  }

  GdiplusShutdown(gpToken);
  return isGood;
}

HBITMAP GetHBitmapFromFile(const wchar_t *imagePath, DWORD gesso, BOOL doCenter)
{
  ULONG_PTR gpToken = 0U;
  LPVOID gpBmp = NULL;
  HBITMAP hBmp = NULL;
  GdiplusStartup(&gpToken, &(GdiplusStartupInput){ 1U, NULL, FALSE, FALSE }, NULL);
  GdipCreateBitmapFromFile(imagePath, &gpBmp);
  if (gpBmp)
  {
    GdipCreateHBITMAPFromBitmap(gpBmp, &hBmp, gesso);
    GdipDisposeImage(gpBmp);
  }

  GdiplusShutdown(gpToken);
  if (!hBmp)
    return NULL;

  BITMAP bmp = { 0 };
  MONITORINFO monInfo = { .cbSize = (DWORD)sizeof(MONITORINFO) };
  BOOL doShrink = FALSE;
  if (GetObjectW(hBmp, (int)sizeof(BITMAP), &bmp) && GetMonitorInfoW(MonitorFromWindow(conWnd, MONITOR_DEFAULTTONEAREST), &monInfo))
  { // if the original image is larger than the work area of the used monitor we will downsize it to make scaling in BackgroundRedrawThread cheaper
    const SIZE monWASize = { monInfo.rcWork.right - monInfo.rcWork.left, monInfo.rcWork.bottom - monInfo.rcWork.top };
    if (bmp.bmWidth > monWASize.cx)
    {
      doShrink = TRUE;
      if (doCenter) // we need to maintain the aspect ratio for a centered image
        bmp.bmHeight = ((bmp.bmHeight << 4) / bmp.bmWidth * monWASize.cx + 8) >> 4;

      bmp.bmWidth = monWASize.cx;
    }

    if (bmp.bmHeight > monWASize.cy)
    {
      doShrink = TRUE;
      if (doCenter)
        bmp.bmWidth = ((bmp.bmWidth << 4) / bmp.bmHeight * monWASize.cy + 8) >> 4;

      bmp.bmHeight = monWASize.cy;
    }
  }

  if (bmp.bmWidth < 1L || bmp.bmHeight < 1L)
  {
    DeleteObject(hBmp);
    return NULL;
  }

  return doShrink ? (HBITMAP)CopyImage((HANDLE)hBmp, IMAGE_BITMAP, (int)bmp.bmWidth, (int)bmp.bmHeight, LR_COPYDELETEORG) : hBmp;
}
