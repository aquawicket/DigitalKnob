@echo off & %dkbatch%

start /wait C:\Users\Administrator\digitalknob\Download\vs_Community.exe --layout "C:\Users\Administrator\digitalknob\Download\VisualStudio" ^
--add Microsoft.VisualStudio.Component.CoreEditor ^
--add Microsoft.VisualStudio.Workload.CoreEditor ^
--add Microsoft.Net.Component.4.7.2.TargetingPack ^
--add Microsoft.VisualStudio.Component.Roslyn.Compiler ^
--add Microsoft.Component.MSBuild ^
--add Microsoft.VisualStudio.Component.Roslyn.LanguageServices ^
--add Microsoft.VisualStudio.Component.TextTemplating ^
--add Microsoft.VisualStudio.Component.NuGet ^
--add Microsoft.NetCore.Component.Runtime.6.0 ^
--add Microsoft.NetCore.Component.SDK ^
--add Microsoft.VisualStudio.Component.FSharp ^
--add Microsoft.ComponentGroup.ClickOnce.Publish ^
--add Microsoft.NetCore.Component.DevelopmentTools ^
--add Microsoft.VisualStudio.Component.Debugger.JustInTime ^
--add Microsoft.VisualStudio.Component.IntelliCode ^
--add Microsoft.VisualStudio.Component.VC.CoreIde ^
--add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 ^
--add Microsoft.VisualStudio.Component.Graphics.Tools ^
--add Microsoft.VisualStudio.Component.VC.DiagnosticTools ^
--add Microsoft.VisualStudio.Component.Windows10SDK.19041 ^
--add Component.OpenJDK ^
--add Component.Android.SDK.MAUI ^
--add Microsoft.VisualStudio.Component.MonoDebugger ^
--add Microsoft.VisualStudio.Component.Merq ^
--add Component.Xamarin.RemotedSimulator ^
--add Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.TemplateEngine ^
--add Component.Xamarin ^
--add Microsoft.VisualStudio.Component.VC.Redist.14.Latest ^
--add Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core ^
--add Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake ^
--add Microsoft.VisualStudio.Component.VC.CMake.Project ^
--add Microsoft.VisualStudio.Component.VC.ATL ^
--add Microsoft.VisualStudio.Component.VC.ASAN ^
--add Microsoft.VisualStudio.ComponentGroup.VC.Tools.142.x86.x64 ^
--add Microsoft.VisualStudio.Workload.NativeDesktop ^
--add Microsoft.VisualStudio.Component.Windows10SDK.IpOverUsb ^
--add Component.Android.SDK25.Private ^
--add Component.Android.NDK.R21E ^
--add Component.Ant ^
--add Component.MDD.Android ^
--add Microsoft.VisualStudio.Workload.NativeMobile ^
--add Microsoft.VisualStudio.Component.VC.14.29.16.11.x86.x64 ^
--lang en-US --passive --wait
 
 
%DKEND% 
