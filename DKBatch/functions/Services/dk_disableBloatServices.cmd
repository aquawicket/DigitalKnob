@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ############################################################################
rem # Services/dk_disableBloatServices()
rem #
rem #
:dk_disableBloatServices
%setlocal%

rem https://gist.github.com/Aldaviva/0eb62993639da319dc456cc01efa3fe5
rem https://github.com/djdallmann/GamingPCSetup/blob/master/CONTENT/DOCS/SERVICES/README.md

rem AdobeARMservice							Adobe Acrobat Update Service	
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\AdobeARMservice" 							"Start" "REG_DWORD" "4"
rem AdobeUpdateService						AdobeUpdateService	
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\AdobeUpdateService" 						"Start" "REG_DWORD" "4"
rem AGMService								Adobe Genuine Monitor Service					CC 5.4.5.550 sometimes fails to load Apps tab when this service is disabled.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\AGMService" 								"Start" "REG_DWORD" "4"
rem AGSService								Adobe Genuine Software Integrity Service		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\AGSService" 								"Start" "REG_DWORD" "4"
rem AppVClient								Microsoft App-V Client
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\AppVClient" 								"Start" "REG_DWORD" "4"
rem BcmBtRSupport								Bluetooth Driver Management Service				Third-party service for Broadcom Bluetooth adapters, NOT required for BT connections.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\BcmBtRSupport" 								"Start" "REG_DWORD" "4"
rem brave										Brave Update Service	
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\brave" 										"Start" "REG_DWORD" "4"
rem bravem									Brave Update Service	
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\bravem" 									"Start" "REG_DWORD" "4"
rem BthAvctpSvc								AVCTP service									Might be needed for Bluetooth audio devices, but NOT other BT devices like game controllers.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\BthAvctpSvc" 								"Start" "REG_DWORD" "4"
rem BTAGService								Bluetooth Audio Gateway Service					Needed for Your Phone "Calls" feature, but NOT other BT devices like game controllers.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\BTAGService" 								"Start" "REG_DWORD" "4"
rem CertPropSvc								Certificate Propagation		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\CertPropSvc" 								"Start" "REG_DWORD" "4"
rem CCleanerPerformanceOptimizerService		CCleaner Performance Optimizer Service
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\CCleanerPerformanceOptimizerService" 		"Start" "REG_DWORD" "4"
rem CDPSvc									Connected Devices Platform Service				Needed for Night Light on Windows 10, but NOT 11.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\CDPSvc" 									"Start" "REG_DWORD" "4"
rem CDPUserSvc								Connected Devices Platform User Service_*		May only be disabled in registry by setting HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc_*\Start = 0x4.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc" 								"Start" "REG_DWORD" "4"
rem diagnosticshub.standardcollector.service	Microsoft (R) Diagnostics Hub Standard Collector Service
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" 	"Start" "REG_DWORD" "4"
rem DiagTrack									Connected User Experiences and Telemetry	
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" 									"Start" "REG_DWORD" "4"
rem DusmSvc									Data Usage										Shows the "last 30 days" section in Settings › Network & Internet. When disabled, the Windows 11 Settings home screen will always say Disconnected.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\DusmSvc" 									"Start" "REG_DWORD" "4"
rem DoSvc										Delivery Optimization							If you have a second Windows computer in the same LAN, they can share Windows Update downloads, reducing your ISP's traffic quota usage.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" 										"Start" "REG_DWORD" "4"
rem DeviceAssociationService					Device Association Service						Needed for Bluetooth.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\DeviceAssociationService" 					"Start" "REG_DWORD" "4"
rem DisplayEnhancementService					Display Enhancement Service	
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\DisplayEnhancementService" 					"Start" "REG_DWORD" "4"
rem DispBrokerDesktopSvc						Display Policy Service
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\DispBrokerDesktopSvc" 						"Start" "REG_DWORD" "4"
rem dmwappushservice							Device Management Wireless Application Protocol (WAP) Push message Routing Service
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" 							"Start" "REG_DWORD" "4"
rem DPS										Diagnostic Policy Service						Needed for powercfg /batteryreport.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\DPS" 										"Start" "REG_DWORD" "4"
rem lfsvc										Geolocation Service
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" 										"Start" "REG_DWORD" "4"
rem iphlpsvc									IP Helper										Not needed for IPv6.
	rem %dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\iphlpsvc" 								"Start" "REG_DWORD" "4"	
rem NcdAutoSetup								Network Connected Devices Auto-Setup		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\NcdAutoSetup" 								"Start" "REG_DWORD" "4"
rem NetTcpPortSharing							Net.Tcp Port Sharing Service		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\NetTcpPortSharing" 							"Start" "REG_DWORD" "4"
rem NVDisplay.ContainerLocalSystem			NVIDIA Display Container LS						Only needed to launch Nvidia Control Panel.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\NVDisplay.ContainerLocalSystem"				"Start" "REG_DWORD" "4"
rem OneSyncSvc								Sync Host_*										May only be disabled in registry by setting HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc_*\Start = 0x4.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc" 								"Start" "REG_DWORD" "4"
rem PolicyAgent								IPsec Policy Agent								Not needed for IPv6.
	rem %dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent" 								"Start" "REG_DWORD" "4"	
rem QWAVE										Quality Windows Audio Video Experience		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\QWAVE" 										"Start" "REG_DWORD" "4"
rem RmSvc										Radio Management Service						Might be needed for Wi-Fi and Bluetooth.
	rem %dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\RmSvc" 									"Start" "REG_DWORD" "4"
rem RasMan									Remote Access Connection Manager		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\RasMan" 									"Start" "REG_DWORD" "4"
rem RemoteRegistry							Remote Registry		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\RemoteRegistry" 							"Start" "REG_DWORD" "4"
rem RemoteAccess								Routing and Remote Access		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\RemoteAccess" 								"Start" "REG_DWORD" "4"
rem smphost									Microsoft Storage Spaces SMP					Might be needed for Storage Spaces.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\smphost" 									"Start" "REG_DWORD" "4"
rem ssh-agent									OpenSSH Authentication Agent		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\ssh-agent" 									"Start" "REG_DWORD" "4"
rem SEMgrSvc									Payments and NFC/SE Manager		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\sSEMgrSvc" 									"Start" "REG_DWORD" "4"
rem shpamsvc									Shared PC Account Manager		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\shpamsvc" 									"Start" "REG_DWORD" "4"
rem ScDeviceEnum								Smart Card Device Enumeration Service		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\ScDeviceEnum" 								"Start" "REG_DWORD" "4"
rem tzautoupdate								Auto Time Zone Updater	
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\tzautoupdate" 								"Start" "REG_DWORD" "4"
rem TapiSrv									Telephony		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\TapiSrv" 									"Start" "REG_DWORD" "4"
rem TabletInputService						Touch Keyboard and Handwriting Panel Service	Needed by Windows Terminal (at least in Windows 11).
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\TabletInputService" 						"Start" "REG_DWORD" "4"
rem UevAgentService							User Experience Virtualization Service		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\UevAgentService" 							"Start" "REG_DWORD" "4"
rem WbioSrvc									Windows Biometric Service						Needed to load Settings › Accounts › Sign-in options and maybe to use fingerprint readers.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\WbioSrvc" 									"Start" "REG_DWORD" "4"
rem wcncsvc									Windows Connect Now - Config Registrar		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\wcncsvc" 									"Start" "REG_DWORD" "4"
rem WlanSvc									WLAN AutoConfig									Might be needed for Wi-Fi.
	rem %dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\WlanSvc" 									"Start" "REG_DWORD" "4"


	
rem AJRouter									AllJoyn Router Service
rem BDESVC									BitLocker Drive Encryption Service				You can disable this service if you don’t use BitLocker to encrypt your hard drive.
rem DPS										Diagnostic Policy Service						You can disable it if you don’t use Windows troubleshooters.
rem DevicePickerUserSvc						DevicePicker									You can disable it if you don’t use Miracast, DLNA, and DIAL UI.
rem Netlogon									Netlogon										This service is only for domain networks. You can disable it if your computer isn’t part of such a network.
rem SCPolicySvc								Smart Card Removal Policy						These services are related to authentication on Windows devices. But you can disable them if you prefer using a keyboard for login.
rem SCardSvr									Smart Card										These services are related to authentication on Windows devices. But you can disable them if you prefer using a keyboard for login.
rem ScDeviceEnum								Smart Card Device Enumeration Service			These services are related to authentication on Windows devices. But you can disable them if you prefer using a keyboard for login.
rem SensorService								Sensor Service									Manages integration with sensors like GPS and ambient light sensors.
rem Spooler									Print Spooler									
rem WalletService								WalletService									You can disable it if you don’t use Wallet on Windows 11.
rem WdiServiceHost							Diagnostic Service Host							You can disable it if you don’t use Windows troubleshooters.
rem WdiSystemHost								Diagnostic System Host							You can disable it if you don’t use Windows troubleshooters.
rem WpcMonSvc									Parental Controls
rem defragsvc									Optimize drives									You can disable it if you like to defrag your hard drive manually.
rem workfolderssvc							Work Folders									It syncs files between a centralized server and personal computers.
rem icssvc									Windows Mobile Hotspot Service					


rem AxInstSV
rem tzautoupdate
rem bthserv
rem dmwappushservice
rem MapsBroker
rem lfsvc
rem SharedAccess
rem lltdsvc
rem AppVClient
rem NetTcpPortSharing
rem CscService
rem PhoneSvc
rem Spooler
rem PrintNotify
rem QWAVE
rem RmSvc
rem RemoteAccess
rem SensorDataService
rem SensrSvc
rem SensorService
rem ShellHWDetection
rem SCardSvr
rem ScDeviceEnum
rem SSDPSRV
rem WiaRpc
rem TabletInputService
rem upnphost
rem UserDataSvc
rem UevAgentService
rem WalletService
rem FrameServer
rem stisvc
rem wisvc
rem icssvc
rem WSearch
rem XblAuthManager
rem XblGameSave

%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% Services/dk_disableBloatServices
%endfunction%

