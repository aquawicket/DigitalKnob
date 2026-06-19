@echo off
if not "%1"=="max" start /max cmd /c %0 max & Exit /b
rem ##################################################################################################
rem # Title     : Rundll32 Commands List                                                             #
rem # Created By: Paul Black [From Brink's (Administrator) Tutorial at TenForums.com listed below]   #
rem # Created On: 29-Oct-2022                                                                        #
rem # Filename  : Rundll32 Commands_List.bat                                                         #
rem # Tutorial  : https://www.tenforums.com/tutorials/77458-rundll32-commands-list-windows-10-a.html #
rem ##################################################################################################
set "Title=Rundll32 Commands List" & set "Author=Paul Black"
title %Title% - Written by %Author%.

setlocal EnableDelayedExpansion
fsutil Dirty Query %SystemDrive% > nul && goto:[RunAs]
echo CreateObject^("Shell.Application"^). ^
ShellExecute "%~0","+","","RunAs",1 > "%Temp%\+.vbs" && "%Temp%\+.vbs" & Exit
:[RunAs]

:Options

echo. & echo  =====================================================================================================================================================================
        echo  %Title%:-
        echo  =====================================================================================================================================================================
echo. & echo  INFORMATION:
echo. & echo    ^> Windows [Rundll32] commands loads and runs 32-bit Dynamic-Link Libraries (DLLs) that can be used for directly invoking specified functions, or used to create
        echo      shortcuts with.
        echo    ^> This program provides a quick way to directly invoke these specified functions.
        echo    ^> The Windows that open may look slightly different to normal, this is because they are opened in their pure form WITHOUT ANY enhanced viual effects being applied.
echo. & echo  WARNING:
echo. & echo    The following immediately RUNS the commands associated with them:
echo. & echo    ^> [20] Hibernate or Sleep
        echo    ^> [40] Lock PC
        echo    ^> [69] Sleep or Hibernate
echo. & echo  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
echo. & echo  Options:
echo. & echo  [ 0] EXIT this Program.
echo. & echo  [ 1] About Windows                                                             [46] Mouse Properties - Wheel Tab
        echo  [ 2] Add Network Location Wizard                                               [47] Mouse Properties - Hardware Tab
        echo  [ 3] Add Printer Wizard                                                        [48] Network Connections
        echo  [ 4] Add Standard TCP/IP Printer Port Wizard                                   [49] ODBC Data Source Administrator
        echo  [ 5] Control Panel                                                             [50] Offline Files (General Tab)
        echo  [ 6] Date and Time                                                             [51] Offline Files (Disk Usage Tab)
        echo  [ 7] Date and Time - Additional Clocks Tab                                     [52] Offline Files (Encryption Tab)
        echo  [ 8] Desktop Icon Settings                                                     [53] Offline Files (Network Tab)
        echo  [ 9] Device Installation Settings                                              [54] Pen and Touch
        echo  [10] Device Manager                                                            [55] Personalization - Background Settings
        echo  [11] Display Settings                                                          [56] Power Options
        echo  [12] Ease of Access Center                                                     [57] Printer User Interface
        echo  [13] Environment Variables                                                     [58] Printers Folder
        echo  [14] File Explorer Options - General Tab                                       [59] Process Idle Tasks
        echo  [15] File Explorer Options - Search Tab                                        [60] Programs and Features
        echo  [16] File Explorer Options - View Tab                                          [61] Region - Formats Tab
        echo  [17] Fonts Folder                                                              [62] Region - Location Tab
        echo  [18] Forgotten Password Wizard                                                 [63] Region - Administrative Tab
        echo  [19] Game Controllers                                                          [64] Safely Remove Hardware
        echo  [20] Hibernate or Sleep                                                        [65] Screen Saver Settings
        echo  [21] Indexing Options                                                          [66] Security and Maintenance
        echo  [22] Infared                                                                   [67] Set Program Access and Computer Defaults
        echo  [23] Internet Explorer - Delete ALL Browsing History                           [68] Set Up a Network Wizard
        echo  [24] Internet Explorer - Delete ALL Browsing History and Add-Ons History       [69] Sleep or Hibernate
        echo  [25] Internet Explorer - Delete Cookies and Website Data                       [70] Sound - Playback Tab
        echo  [26] Internet Explorer - Delete Download History                               [71] Sound - Recording Tab
        echo  [27] Internet Explorer - Delete Form Data                                      [72] Sound - Sounds Tab
        echo  [28] Internet Explorer - Delete History                                        [73] Sound - Communications Tab
        echo  [29] Internet Explorer - Delete Passwords                                      [74] Speech Properties - Text to Speech Tab
        echo  [30] Internet Explorer - Delete Temporary Internet Files and Website Files     [75] Start Settings
        echo  [31] Internet Explorer - Organize Favorites                                    [76] Stored User Names and Passwords
        echo  [32] Internet Properties - General Tab                                         [77] System Properties - Computer Name Tab
        echo  [33] Internet Properties - Security Tab                                        [78] System Properties - Hardware Tab
        echo  [34] Internet Properties - Privacy Tab                                         [79] System Properties - Advanced Tab
        echo  [35] Internet Properties - Content Tab                                         [80] System Properties - System Protection Tab
        echo  [36] Internet Properties - Connections Tab                                     [81] System Properties - Remote Tab
        echo  [37] Internet Properties - Programs Tab                                        [82] Taskbar Settings
        echo  [38] Internet Properties - Advanced Tab                                        [83] Text Services and Input Languages
        echo  [39] Keyboard Properties                                                       [84] User Accounts
        echo  [40] Lock PC                                                                   [85] Windows Features
        echo  [41] Map Network Drive Wizard                                                  [86] Windows Firewall
        echo  [42] Mouse Button swap Left and Right Button Function                          [87] Windows To Go Startup Options
        echo  [43] Mouse Properties - Buttons Tab
        echo  [44] Mouse Properties - Pointers Tab
        echo  [45] Mouse Properties - Pointer Options Tab
echo. & echo  =====================================================================================================================================================================& echo.

set "UserInput="
set /p "UserInput=>Enter an Option number and press <Enter>: "

if   "%UserInput%"=="" cls & goto :Options
if /i %UserInput%==0  Exit
if /i %UserInput%==1  goto:AboutWindows
if /i %UserInput%==2  goto:AddNetworkLocationWizard
if /i %UserInput%==3  goto:AddPrinterWizard
if /i %UserInput%==4  goto:AddStandardTCP/IPPrinterPortWizard
if /i %UserInput%==5  goto:ControlPanel
if /i %UserInput%==6  goto:DateAndTime
if /i %UserInput%==7  goto:DateAndTime-AdditionalClocksTab
if /i %UserInput%==8  goto:DesktopIconSettings
if /i %UserInput%==9  goto:DeviceInstallationSettings
if /i %UserInput%==10 goto:DeviceManager
if /i %UserInput%==11 goto:DisplaySettings
if /i %UserInput%==12 goto:EaseOfAccessCenter
if /i %UserInput%==13 goto:EnvironmentVariables
if /i %UserInput%==14 goto:FileExplorerOptions-GeneralTab
if /i %UserInput%==15 goto:FileExplorerOptions-SearchTab
if /i %UserInput%==16 goto:FileExplorerOptions-ViewTab
if /i %UserInput%==17 goto:FontsFolder
if /i %UserInput%==18 goto:ForgottenPasswordWizard
if /i %UserInput%==19 goto:GameControllers
if /i %UserInput%==20 goto:HibernateOrSleep
if /i %UserInput%==21 goto:IndexingOptions
if /i %UserInput%==22 goto:Infared
if /i %UserInput%==23 goto:InternetExplorer-DeleteALLBrowsingHistory
if /i %UserInput%==24 goto:InternetExplorer-DeleteALLBrowsingHistoryAndAdd-OnsHistory
if /i %UserInput%==25 goto:InternetExplorer-DeleteCookiesAndWebsiteData
if /i %UserInput%==26 goto:InternetExplorer-DeleteDownloadHistory
if /i %UserInput%==27 goto:InternetExplorer-DeleteFormData
if /i %UserInput%==28 goto:InternetExplorer-DeleteHistory
if /i %UserInput%==29 goto:InternetExplorer-DeletePasswords
if /i %UserInput%==30 goto:InternetExplorer-DeleteTemporaryInternetFilesAndWebsiteFiles
if /i %UserInput%==31 goto:InternetExplorer-OrganizeFavorites
if /i %UserInput%==32 goto:InternetProperties-GeneralTab
if /i %UserInput%==33 goto:InternetProperties-SecurityTab
if /i %UserInput%==34 goto:InternetProperties-PrivacyTab
if /i %UserInput%==35 goto:InternetProperties-ContentTab
if /i %UserInput%==36 goto:InternetProperties-ConnectionsTab
if /i %UserInput%==37 goto:InternetProperties-ProgramsTab
if /i %UserInput%==38 goto:InternetProperties-AdvancedTab
if /i %UserInput%==39 goto:KeyboardProperties
if /i %UserInput%==40 goto:LockPC
if /i %UserInput%==41 goto:MapNetworkDrivewizard
if /i %UserInput%==42 goto:MouseButtonswapLeftAndRightButtonFunction
if /i %UserInput%==43 goto:MouseProperties-ButtonsTab
if /i %UserInput%==44 goto:MouseProperties-PointersTab
if /i %UserInput%==45 goto:MouseProperties-PointerOptionsTab
if /i %UserInput%==46 goto:MouseProperties-WheelTab
if /i %UserInput%==47 goto:MouseProperties-HardwareTab
if /i %UserInput%==48 goto:NetworkConnections
if /i %UserInput%==49 goto:ODBCDataSourceAdministrator
if /i %UserInput%==50 goto:OfflineFiles(GeneralTab)
if /i %UserInput%==51 goto:OfflineFiles(DiskUsageTab)
if /i %UserInput%==52 goto:OfflineFiles(EncryptionTab)
if /i %UserInput%==53 goto:OfflineFiles(NetworkTab)
if /i %UserInput%==54 goto:PenAndTouch
if /i %UserInput%==55 goto:Personalization-BackgroundSettings
if /i %UserInput%==56 goto:PowerOptions
if /i %UserInput%==57 goto:PrinterUserInterface
if /i %UserInput%==58 goto:PrintersFolder
if /i %UserInput%==59 goto:Processidletasks
if /i %UserInput%==60 goto:ProgramsAndFeatures
if /i %UserInput%==61 goto:Region-FormatsTab
if /i %UserInput%==62 goto:Region-LocationTab
if /i %UserInput%==63 goto:Region-AdministrativeTab
if /i %UserInput%==64 goto:SafelyRemoveHardware
if /i %UserInput%==65 goto:ScreenSaverSettings
if /i %UserInput%==66 goto:SecurityAndMaintenance
if /i %UserInput%==67 goto:SetProgramAccessAndComputerDefaults
if /i %UserInput%==68 goto:SetUpaNetworkWizard
if /i %UserInput%==69 goto:SleepOrHibernate
if /i %UserInput%==70 goto:Sound-PlaybackTab
if /i %UserInput%==71 goto:Sound-RecordingTab
if /i %UserInput%==72 goto:Sound-SoundsTab
if /i %UserInput%==73 goto:Sound-CommunicationsTab
if /i %UserInput%==74 goto:SpeechProperties-TexttoSpeechTab
if /i %UserInput%==75 goto:StartSettings
if /i %UserInput%==76 goto:StoredUserNamesAndPasswords
if /i %UserInput%==77 goto:SystemProperties-ComputerNameTab
if /i %UserInput%==78 goto:SystemProperties-HardwareTab
if /i %UserInput%==79 goto:SystemProperties-AdvancedTab
if /i %UserInput%==80 goto:SystemProperties-SystemProtectionTab
if /i %UserInput%==81 goto:SystemProperties-RemoteTab
if /i %UserInput%==82 goto:TaskbarSettings
if /i %UserInput%==83 goto:TextServicesAndInputLanguages
if /i %UserInput%==84 goto:UserAccounts
if /i %UserInput%==85 goto:WindowsFeatures
if /i %UserInput%==86 goto:WindowsFirewall
if /i %UserInput%==87 goto:WindowsToGoStartupOptions
goto :Options

:AboutWindows
Rundll32.exe shell32.dll,ShellAbout
cls & goto :Options

:AddNetworkLocationWizard
Rundll32 %SystemRoot%\system32\shwebsvc.dll,AddNetPlaceRunDll
cls & goto :Options

:AddPrinterWizard
Rundll32.exe shell32.dll,SHHelpShortcuts_RunDLL AddPrinter
cls & goto :Options

:AddStandardTCP/IPPrinterPortWizard
Rundll32.exe tcpmonui.dll,LocalAddPortUI
cls & goto :Options

:ControlPanel
Rundll32.exe shell32.dll,Control_RunDLL
cls & goto :Options

:DateAndTime
Rundll32.exe shell32.dll,Control_RunDLL timedate.cpl
cls & goto :Options

:DateAndTime-AdditionalClocksTab
Rundll32.exe shell32.dll,Control_RunDLL timedate.cpl,,1
cls & goto :Options

:DesktopIconSettings
Rundll32.exe shell32.dll,Control_RunDLL desk.cpl,,0
cls & goto :Options

:DeviceInstallationSettings
Rundll32.exe %SystemRoot%\System32\newdev.dll,DeviceInternetSettingUi
cls & goto :Options

:DeviceManager
Rundll32.exe devmgr.dll DeviceManager_Execute
cls & goto :Options

:DisplaySettings
Rundll32.exe shell32.dll,Control_RunDLL desk.cpl
cls & goto :Options

:EaseOfAccessCenter
Rundll32.exe shell32.dll,Control_RunDLL access.cpl
cls & goto :Options

:EnvironmentVariables
Rundll32.exe sysdm.cpl,EditEnvironmentVariables
cls & goto :Options

:FileExplorerOptions-GeneralTab
Rundll32.exe shell32.dll,Options_RunDLL 0
cls & goto :Options

:FileExplorerOptions-SearchTab
Rundll32.exe shell32.dll,Options_RunDLL 2
cls & goto :Options

:FileExplorerOptions-ViewTab
Rundll32.exe shell32.dll,Options_RunDLL 7
cls & goto :Options

:FontsFolder
Rundll32.exe shell32.dll,SHHelpShortcuts_RunDLL FontsFolder
cls & goto :Options

:ForgottenPasswordWizard
Rundll32.exe keymgr.dll,PRShowSaveWizardExW
cls & goto :Options

:GameControllers
Rundll32.exe shell32.dll,Control_RunDLL joy.cpl
cls & goto :Options

:HibernateOrSleep
Rundll32.exe powrprof.dll,SetSuspendState
cls & goto :Options

:IndexingOptions
Rundll32.exe shell32.dll,Control_RunDLL srchadmin.dll
cls & goto :Options

:Infared
Rundll32.exe shell32.dll,Control_RunDLL irprops.cpl
cls & goto :Options

:InternetExplorer-DeleteALLBrowsingHistory
Rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 255
cls & goto :Options

:InternetExplorer-DeleteALLBrowsingHistoryAndAdd-OnsHistory
Rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 4351
cls & goto :Options

:InternetExplorer-DeleteCookiesAndWebsiteData
Rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 2
cls & goto :Options

:InternetExplorer-DeleteDownloadHistory
Rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 16384
cls & goto :Options

:InternetExplorer-DeleteFormData
Rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 16
cls & goto :Options

:InternetExplorer-DeleteHistory
Rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 1
cls & goto :Options

:InternetExplorer-DeletePasswords
Rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 32
cls & goto :Options

:InternetExplorer-DeleteTemporaryInternetFilesAndWebsiteFiles
Rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 8
cls & goto :Options

:InternetExplorer-OrganizeFavorites
Rundll32.exe shdocvw.dll,DoOrganizeFavDlg
cls & goto :Options

:InternetProperties-GeneralTab
Rundll32.exe shell32.dll,Control_RunDLL inetcpl.cpl
cls & goto :Options

:InternetProperties-SecurityTab
Rundll32.exe shell32.dll,Control_RunDLL inetcpl.cpl,,1
cls & goto :Options

:InternetProperties-PrivacyTab
Rundll32.exe shell32.dll,Control_RunDLL inetcpl.cpl,,2
cls & goto :Options

:InternetProperties-ContentTab
Rundll32.exe shell32.dll,Control_RunDLL inetcpl.cpl,,3
cls & goto :Options

:InternetProperties-ConnectionsTab
Rundll32.exe shell32.dll,Control_RunDLL inetcpl.cpl,,4
cls & goto :Options

:InternetProperties-ProgramsTab
Rundll32.exe shell32.dll,Control_RunDLL inetcpl.cpl,,5
cls & goto :Options

:InternetProperties-AdvancedTab
Rundll32.exe shell32.dll,Control_RunDLL inetcpl.cpl,,6
cls & goto :Options

:KeyboardProperties
Rundll32.exe shell32.dll,Control_RunDLL main.cpl @1
cls & goto :Options

:LockPC
Rundll32.exe user32.dll,LockWorkStation
cls & goto :Options

:MapNetworkDrivewizard
Rundll32.exe shell32.dll,SHHelpShortcuts_RunDLL Connect
cls & goto :Options

:MouseButtonswapLeftAndRightButtonFunction
Rundll32.exe user32.dll,SwapMouseButton
cls & goto :Options

:MouseProperties-ButtonsTab
Rundll32.exe shell32.dll,Control_RunDLL main.cpl
cls & goto :Options

:MouseProperties-PointersTab
Rundll32.exe shell32.dll,Control_RunDLL main.cpl,,1
cls & goto :Options

:MouseProperties-PointerOptionsTab
Rundll32.exe shell32.dll,Control_RunDLL main.cpl,,2
cls & goto :Options

:MouseProperties-WheelTab
Rundll32.exe shell32.dll,Control_RunDLL main.cpl,,3
cls & goto :Options

:MouseProperties-HardwareTab
Rundll32.exe shell32.dll,Control_RunDLL main.cpl,,4
cls & goto :Options

:NetworkConnections
Rundll32.exe shell32.dll,Control_RunDLL ncpa.cpl
cls & goto :Options

:ODBCDataSourceAdministrator
Rundll32.exe shell32.dll,Control_RunDLL odbccp32.cpl
cls & goto :Options

:OfflineFiles(GeneralTab)
Rundll32.exe Shell32.dll,Control_RunDLL cscui.dll,,0
cls & goto :Options

:OfflineFiles(DiskUsageTab)
Rundll32.exe Shell32.dll,Control_RunDLL cscui.dll,,1
cls & goto :Options

:OfflineFiles(EncryptionTab)
Rundll32.exe Shell32.dll,Control_RunDLL cscui.dll,,2
cls & goto :Options

:OfflineFiles(NetworkTab)
Rundll32.exe Shell32.dll,Control_RunDLL cscui.dll,,3
cls & goto :Options

:PenAndTouch
Rundll32.exe shell32.dll,Control_RunDLL tabletpc.cpl
cls & goto :Options

:Personalization-BackgroundSettings
Rundll32.exe shell32.dll,Control_RunDLL desk.cpl,,2
cls & goto :Options

:PowerOptions
Rundll32.exe shell32.dll,Control_RunDLL powercfg.cpl
cls & goto :Options

:PrinterUserInterface
Rundll32.exe Printui.dll,PrintUIEntry /?
cls & goto :Options

:PrintersFolder
Rundll32.exe shell32.dll,SHHelpShortcuts_RunDLL PrintersFolder
cls & goto :Options

:Processidletasks
Rundll32.exe advapi32.dll,ProcessIdleTasks
cls & goto :Options

:ProgramsAndFeatures
Rundll32.exe shell32.dll,Control_RunDLL appwiz.cpl,,0
cls & goto :Options

:Region-FormatsTab
Rundll32.exe shell32.dll,Control_RunDLL Intl.cpl,,0
cls & goto :Options

:Region-LocationTab
Rundll32.exe shell32.dll,Control_RunDLL Intl.cpl,,1
cls & goto :Options

:Region-AdministrativeTab
Rundll32.exe shell32.dll,Control_RunDLL Intl.cpl,,2
cls & goto :Options

:SafelyRemoveHardware
Rundll32.exe shell32.dll,Control_RunDLL HotPlug.dll
cls & goto :Options

:ScreenSaverSettings
Rundll32.exe shell32.dll,Control_RunDLL desk.cpl,,1
cls & goto :Options

:SecurityAndMaintenance
Rundll32.exe shell32.dll,Control_RunDLL wscui.cpl
cls & goto :Options

:SetProgramAccessAndComputerDefaults
Rundll32.exe shell32.dll,Control_RunDLL appwiz.cpl,,3
cls & goto :Options

:SetUpaNetworkWizard
Rundll32.exe shell32.dll,Control_RunDLL NetSetup.cpl
cls & goto :Options

:SleepOrHibernate
Rundll32.exe powrprof.dll,SetSuspendState
cls & goto :Options

:Sound-PlaybackTab
Rundll32.exe shell32.dll,Control_RunDLL Mmsys.cpl,,0
cls & goto :Options

:Sound-RecordingTab
Rundll32.exe shell32.dll,Control_RunDLL Mmsys.cpl,,1
cls & goto :Options

:Sound-SoundsTab
Rundll32.exe shell32.dll,Control_RunDLL Mmsys.cpl,,2
cls & goto :Options

:Sound-CommunicationsTab
Rundll32.exe shell32.dll,Control_RunDLL Mmsys.cpl,,3
cls & goto :Options

:SpeechProperties-TexttoSpeechTab
Rundll32.exe shell32.dll,Control_RunDLL %SystemRoot%\System32\Speech\SpeechUX\sapi.cpl,,1
cls & goto :Options

:StartSettings
Rundll32.exe shell32.dll,Options_RunDLL 3
cls & goto :Options

:StoredUserNamesAndPasswords
Rundll32.exe keymgr.dll,KRShowKeyMgr
cls & goto :Options

:SystemProperties-ComputerNameTab
Rundll32.exe shell32.dll,Control_RunDLL Sysdm.cpl,,1
cls & goto :Options

:SystemProperties-HardwareTab
Rundll32.exe shell32.dll,Control_RunDLL Sysdm.cpl,,2
cls & goto :Options

:SystemProperties-AdvancedTab
Rundll32.exe shell32.dll,Control_RunDLL Sysdm.cpl,,3
cls & goto :Options

:SystemProperties-SystemProtectionTab
Rundll32.exe shell32.dll,Control_RunDLL Sysdm.cpl,,4
cls & goto :Options

:SystemProperties-RemoteTab
Rundll32.exe shell32.dll,Control_RunDLL Sysdm.cpl,,5
cls & goto :Options

:TaskbarSettings
Rundll32.exe shell32.dll,Options_RunDLL 1
cls & goto :Options

:TextServicesAndInputLanguages
Rundll32.exe Shell32.dll,Control_RunDLL input.dll,,{C07337D3-DB2C-4D0B-9A93-B722A6C106E2}
cls & goto :Options

:UserAccounts
Rundll32.exe shell32.dll,Control_RunDLL nusrmgr.cpl
cls & goto :Options

:WindowsFeatures
Rundll32.exe shell32.dll,Control_RunDLL appwiz.cpl,,2
cls & goto :Options

:WindowsFirewall
Rundll32.exe shell32.dll,Control_RunDLL firewall.cpl
cls & goto :Options

:WindowsToGoStartupOptions
Rundll32.exe pwlauncher.dll,ShowPortableWorkspaceLauncherConfigurationUX
cls & goto :Options