set "VS_COMMUNITY=vs_community__621291036.1634852628.exe"
set "DKDOWNLOAD=C:\Users\%USERNAME%\digitalknob\Download"

start /wait %DKDOWNLOAD%\%VS_COMMUNITY% --layout "%DKDOWNLOAD%\VisualStudio" ^
--add Microsoft.VisualStudio.Component.CoreEditor ^
--add Microsoft.VisualStudio.Workload.CoreEditor ^
--add Microsoft.NetCore.Component.Runtime.5.0 ^
--add Microsoft.NetCore.Component.Runtime.3.1 ^
--add Microsoft.NetCore.Component.SDK ^
--add Microsoft.VisualStudio.Component.NuGet ^
--add Microsoft.Net.Component.4.6.1.TargetingPack ^
--add Microsoft.VisualStudio.Component.Roslyn.Compiler ^
--add Microsoft.VisualStudio.Component.Roslyn.LanguageServices ^
--add Microsoft.VisualStudio.Component.FSharp ^
--add Microsoft.ComponentGroup.ClickOnce.Publish ^
--add Microsoft.NetCore.Component.DevelopmentTools ^
--add Microsoft.Component.MSBuild ^
--add Microsoft.VisualStudio.Component.TextTemplating ^
--add Microsoft.VisualStudio.Component.Debugger.JustInTime ^
--add Microsoft.VisualStudio.Component.IntelliCode ^
--add Microsoft.VisualStudio.Component.VC.CoreIde ^
--add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 ^
--add Microsoft.VisualStudio.Component.Graphics.Tools ^
--add Microsoft.VisualStudio.Component.VC.DiagnosticTools ^
--add Microsoft.VisualStudio.Component.Windows10SDK.19041 ^
--add Microsoft.VisualStudio.Component.VC.Redist.14.Latest ^
--add Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core ^
--add Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake ^
--add Microsoft.VisualStudio.Component.VC.CMake.Project ^
--add Microsoft.VisualStudio.Component.VC.ATL ^
--add Microsoft.VisualStudio.Workload.NativeDesktop ^
--add Microsoft.VisualStudio.Component.Windows10SDK.IpOverUsb ^
--add Component.OpenJDK ^
--add Microsoft.VisualStudio.Component.MonoDebugger ^
--add Microsoft.VisualStudio.Component.Merq ^
--add Component.Xamarin.RemotedSimulator ^
--add Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.TemplateEngine ^
--add Component.Xamarin ^
--add Component.Android.SDK25.Private ^
--add Component.MDD.Android ^
--add Microsoft.VisualStudio.Workload.NativeMobile ^
--lang en-US --passive --wait > nul
echo %errorlevel%
ECHO Exit
pause