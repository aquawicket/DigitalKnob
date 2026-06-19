@echo off &setlocal

set ConsoleInfo=powershell -nop -ep Bypass -c ^"$w=Add-Type -Name WAPI -PassThru -MemberDefinition '^
%===% [DllImport(\"kernel32.dll\"^)] public static extern void GetCurrentConsoleFont(IntPtr hOut,int isMax,int[] info^);^
%===% [DllImport(\"kernel32.dll\"^)] public static extern IntPtr CreateFile(string name,int acc,int share,IntPtr sec,int how,int flags,IntPtr tmplt^);^
%===% [DllImport(\"kernel32.dll\"^)] public static extern void CloseHandle(IntPtr h^);';^
%=% [int[]]$info=0,0;$h=$w::CreateFile('CONOUT$',0xC0000000,2,[IntPtr]::Zero,3,0,[IntPtr]::Zero^);$w::GetCurrentConsoleFont($h,0,$info^);$w::CloseHandle($h^);^
%=% $r=$host.UI.RawUI;$c=$r.WindowSize;$l=$r.MaxPhysicalWindowSize;^
%=% \"cfx^=$($info[1] -band 0xFFFF^)^,cfy^=$(($info[1] -shr 16^) -band 0xFFFF^)^,ccx^=$($c.Width^)^,ccy^=$($c.Height^)^,clx^=$($l.Width^)^,cly^=$($l.Height^)\";^"

for /f %%i in ('%ConsoleInfo%') do set /a "%%i"
echo console font size: %cfx%, %cfy%
echo console current size: %ccx%, %ccy%
echo console largest size: %clx%, %cly%

pause