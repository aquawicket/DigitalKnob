@ECHO off

set "DKDOWNLOAD=C:\Users\%USERNAME%\digitalknob\Download"

%DKDOWNLOAD%\vs_Community.exe --layout %DKDOWNLOAD%\vslayout^
 --add Microsoft.VisualStudio.Component.CoreEditor^
 --add Microsoft.VisualStudio.Workload.CoreEditor^
 --add Microsoft.VisualStudio.Component.Roslyn.Compiler^
 --add Microsoft.Component.MSBuild^
 --add Microsoft.VisualStudio.Component.TextTemplating^
 --add Microsoft.VisualStudio.Component.VC.CoreIde^
 --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64^
 --add Microsoft.VisualStudio.Component.Windows10SDK.19041^
 --add Microsoft.VisualStudio.Component.VC.Redist.14.Latest^
 --add Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core^
 --add Microsoft.VisualStudio.Workload.NativeDesktop^
 --lang en-US