@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_disableBloatServices()
::#
::#
:dk_disableBloatServices
%setlocal%
	%dk_call% dk_debugFunc 0

:: https://gist.github.com/Aldaviva/0eb62993639da319dc456cc01efa3fe5
:: https://github.com/djdallmann/GamingPCSetup/blob/master/CONTENT/DOCS/SERVICES/README.md

::AdobeARMservice							Adobe Acrobat Update Service	
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\AdobeARMservice" 							"Start" "REG_DWORD" "4"
::AdobeUpdateService						AdobeUpdateService	
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\AdobeUpdateService" 						"Start" "REG_DWORD" "4"
::AGMService								Adobe Genuine Monitor Service					CC 5.4.5.550 sometimes fails to load Apps tab when this service is disabled.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\AGMService" 								"Start" "REG_DWORD" "4"
::AGSService								Adobe Genuine Software Integrity Service		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\AGSService" 								"Start" "REG_DWORD" "4"
::AppVClient								Microsoft App-V Client
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\AppVClient" 								"Start" "REG_DWORD" "4"
::BcmBtRSupport								Bluetooth Driver Management Service				Third-party service for Broadcom Bluetooth adapters, NOT required for BT connections.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\BcmBtRSupport" 								"Start" "REG_DWORD" "4"
::brave										Brave Update Service	
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\brave" 										"Start" "REG_DWORD" "4"
::bravem									Brave Update Service	
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\bravem" 									"Start" "REG_DWORD" "4"
::BthAvctpSvc								AVCTP service									Might be needed for Bluetooth audio devices, but NOT other BT devices like game controllers.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\BthAvctpSvc" 								"Start" "REG_DWORD" "4"
::BTAGService								Bluetooth Audio Gateway Service					Needed for Your Phone "Calls" feature, but NOT other BT devices like game controllers.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\BTAGService" 								"Start" "REG_DWORD" "4"
::CertPropSvc								Certificate Propagation		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\CertPropSvc" 								"Start" "REG_DWORD" "4"
::CCleanerPerformanceOptimizerService		CCleaner Performance Optimizer Service
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\CCleanerPerformanceOptimizerService" 		"Start" "REG_DWORD" "4"
::CDPSvc									Connected Devices Platform Service				Needed for Night Light on Windows 10, but NOT 11.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\CDPSvc" 									"Start" "REG_DWORD" "4"
::CDPUserSvc								Connected Devices Platform User Service_*		May only be disabled in registry by setting HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc_*\Start = 0x4.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc" 								"Start" "REG_DWORD" "4"
::diagnosticshub.standardcollector.service	Microsoft (R) Diagnostics Hub Standard Collector Service
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" 	"Start" "REG_DWORD" "4"
::DiagTrack									Connected User Experiences and Telemetry	
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" 									"Start" "REG_DWORD" "4"
::DusmSvc									Data Usage										Shows the "last 30 days" section in Settings › Network & Internet. When disabled, the Windows 11 Settings home screen will always say Disconnected.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\DusmSvc" 									"Start" "REG_DWORD" "4"
::DoSvc										Delivery Optimization							If you have a second Windows computer in the same LAN, they can share Windows Update downloads, reducing your ISP's traffic quota usage.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" 										"Start" "REG_DWORD" "4"
::DeviceAssociationService					Device Association Service						Needed for Bluetooth.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\DeviceAssociationService" 					"Start" "REG_DWORD" "4"
::DisplayEnhancementService					Display Enhancement Service	
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\DisplayEnhancementService" 					"Start" "REG_DWORD" "4"
::DispBrokerDesktopSvc						Display Policy Service
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\DispBrokerDesktopSvc" 						"Start" "REG_DWORD" "4"
::dmwappushservice							Device Management Wireless Application Protocol (WAP) Push message Routing Service
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" 							"Start" "REG_DWORD" "4"
::DPS										Diagnostic Policy Service						Needed for powercfg /batteryreport.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\DPS" 										"Start" "REG_DWORD" "4"
::lfsvc										Geolocation Service
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" 										"Start" "REG_DWORD" "4"
::iphlpsvc									IP Helper										Not needed for IPv6.
	::%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\iphlpsvc" 								"Start" "REG_DWORD" "4"	
::NcdAutoSetup								Network Connected Devices Auto-Setup		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\NcdAutoSetup" 								"Start" "REG_DWORD" "4"
::NetTcpPortSharing							Net.Tcp Port Sharing Service		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\NetTcpPortSharing" 							"Start" "REG_DWORD" "4"
::NVDisplay.ContainerLocalSystem			NVIDIA Display Container LS						Only needed to launch Nvidia Control Panel.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\NVDisplay.ContainerLocalSystem"				"Start" "REG_DWORD" "4"
::OneSyncSvc								Sync Host_*										May only be disabled in registry by setting HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc_*\Start = 0x4.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc" 								"Start" "REG_DWORD" "4"
::PolicyAgent								IPsec Policy Agent								Not needed for IPv6.
	::%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent" 								"Start" "REG_DWORD" "4"	
::QWAVE										Quality Windows Audio Video Experience		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\QWAVE" 										"Start" "REG_DWORD" "4"
::RmSvc										Radio Management Service						Might be needed for Wi-Fi and Bluetooth.
	::%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\RmSvc" 									"Start" "REG_DWORD" "4"
::RasMan									Remote Access Connection Manager		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\RasMan" 									"Start" "REG_DWORD" "4"
::RemoteRegistry							Remote Registry		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\RemoteRegistry" 							"Start" "REG_DWORD" "4"
::RemoteAccess								Routing and Remote Access		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\RemoteAccess" 								"Start" "REG_DWORD" "4"
::smphost									Microsoft Storage Spaces SMP					Might be needed for Storage Spaces.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\smphost" 									"Start" "REG_DWORD" "4"
::ssh-agent									OpenSSH Authentication Agent		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\ssh-agent" 									"Start" "REG_DWORD" "4"
::SEMgrSvc									Payments and NFC/SE Manager		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\sSEMgrSvc" 									"Start" "REG_DWORD" "4"
::shpamsvc									Shared PC Account Manager		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\shpamsvc" 									"Start" "REG_DWORD" "4"
::ScDeviceEnum								Smart Card Device Enumeration Service		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\ScDeviceEnum" 								"Start" "REG_DWORD" "4"
::tzautoupdate								Auto Time Zone Updater	
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\tzautoupdate" 								"Start" "REG_DWORD" "4"
::TapiSrv									Telephony		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\TapiSrv" 									"Start" "REG_DWORD" "4"
::TabletInputService						Touch Keyboard and Handwriting Panel Service	Needed by Windows Terminal (at least in Windows 11).
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\TabletInputService" 						"Start" "REG_DWORD" "4"
::UevAgentService							User Experience Virtualization Service		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\UevAgentService" 							"Start" "REG_DWORD" "4"
::WbioSrvc									Windows Biometric Service						Needed to load Settings › Accounts › Sign-in options and maybe to use fingerprint readers.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\WbioSrvc" 									"Start" "REG_DWORD" "4"
::wcncsvc									Windows Connect Now - Config Registrar		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\wcncsvc" 									"Start" "REG_DWORD" "4"
::WlanSvc									WLAN AutoConfig									Might be needed for Wi-Fi.
	::%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\WlanSvc" 									"Start" "REG_DWORD" "4"


	
::AJRouter									AllJoyn Router Service
::BDESVC									BitLocker Drive Encryption Service				You can disable this service if you don’t use BitLocker to encrypt your hard drive.
::DPS										Diagnostic Policy Service						You can disable it if you don’t use Windows troubleshooters.
::DevicePickerUserSvc						DevicePicker									You can disable it if you don’t use Miracast, DLNA, and DIAL UI.
::Netlogon									Netlogon										This service is only for domain networks. You can disable it if your computer isn’t part of such a network.
::SCPolicySvc								Smart Card Removal Policy						These services are related to authentication on Windows devices. But you can disable them if you prefer using a keyboard for login.
::SCardSvr									Smart Card										These services are related to authentication on Windows devices. But you can disable them if you prefer using a keyboard for login.
::ScDeviceEnum								Smart Card Device Enumeration Service			These services are related to authentication on Windows devices. But you can disable them if you prefer using a keyboard for login.
::SensorService								Sensor Service									Manages integration with sensors like GPS and ambient light sensors.
::Spooler									Print Spooler									
::WalletService								WalletService									You can disable it if you don’t use Wallet on Windows 11.
::WdiServiceHost							Diagnostic Service Host							You can disable it if you don’t use Windows troubleshooters.
::WdiSystemHost								Diagnostic System Host							You can disable it if you don’t use Windows troubleshooters.
::WpcMonSvc									Parental Controls
::defragsvc									Optimize drives									You can disable it if you like to defrag your hard drive manually.
::workfolderssvc							Work Folders									It syncs files between a centralized server and personal computers.
::icssvc									Windows Mobile Hotspot Service					


::AxInstSV
::tzautoupdate
::bthserv
::dmwappushservice
::MapsBroker
::lfsvc
::SharedAccess
::lltdsvc
::AppVClient
::NetTcpPortSharing
::CscService
::PhoneSvc
::Spooler
::PrintNotify
::QWAVE
::RmSvc
::RemoteAccess
::SensorDataService
::SensrSvc
::SensorService
::ShellHWDetection
::SCardSvr
::ScDeviceEnum
::SSDPSRV
::WiaRpc
::TabletInputService
::upnphost
::UserDataSvc
::UevAgentService
::WalletService
::FrameServer
::stisvc
::wisvc
::icssvc
::WSearch
::XblAuthManager
::XblGameSave

%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_disableBloatServices
%endfunction%

