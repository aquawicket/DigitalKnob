Set objShell = CreateObject("Shell.Application") 
args = Right("C:\Windows\ImmersiveControlPanel\SystemSettings.exe", (Len("C:\Windows\ImmersiveControlPanel\SystemSettings.exe") - Len("C:\Windows\ImmersiveControlPanel\SystemSettings.exe"))) 
objShell.ShellExecute "C:\Windows\ImmersiveControlPanel\SystemSettings.exe", args, "", "runas" 
