@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_disableBloatServices()
::#
::#
:dk_disableBloatServices
%setlocal%
	%dk_call% dk_debugFunc 0

	::AdobeARMservice							Adobe Acrobat Update Service	
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\AdobeARMservice" 	"Start" "REG_DWORD" "4"
	::AGMService								Adobe Genuine Monitor Service					CC 5.4.5.550 sometimes fails to load Apps tab when this service is disabled.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\AGMService" 		"Start" "REG_DWORD" "4"
	::AGSService								Adobe Genuine Software Integrity Service		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\AGSService" 		"Start" "REG_DWORD" "4"
	::AdobeUpdateService						AdobeUpdateService	
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\AdobeUpdateService" "Start" "REG_DWORD" "4"
	::tzautoupdate								Auto Time Zone Updater	
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\tzautoupdate" 		"Start" "REG_DWORD" "4"
	::BthAvctpSvc								AVCTP service									Might be needed for Bluetooth audio devices, but not other BT devices like game controllers.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\BthAvctpSvc" 		"Start" "REG_DWORD" "4"
	::BTAGService								Bluetooth Audio Gateway Service					Needed for Your Phone "Calls" feature, but not other BT devices like game controllers.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\BTAGService" 		"Start" "REG_DWORD" "4"
	::BcmBtRSupport								Bluetooth Driver Management Service				Third-party service for Broadcom Bluetooth adapters, not required for BT connections.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\BcmBtRSupport" 		"Start" "REG_DWORD" "4"
	::CertPropSvc								Certificate Propagation		
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\CertPropSvc" 		"Start" "REG_DWORD" "4"
	::CDPSvc									Connected Devices Platform Service				Needed for Night Light on Windows 10, but not 11.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\CDPSvc" 			"Start" "REG_DWORD" "4"
	::CDPUserSvc								Connected Devices Platform User Service_*		May only be disabled in registry by setting HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc_*\Start = 0x4.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc" 		"Start" "REG_DWORD" "4"
	::DiagTrack									Connected User Experiences and Telemetry	
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" 			"Start" "REG_DWORD" "4"	
	::DusmSvc									Data Usage										Shows the "last 30 days" section in Settings › Network & Internet. When disabled, the Windows 11 Settings home screen will always say Disconnected.
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\DusmSvc" 			"Start" "REG_DWORD" "4"	
	::DoSvc										Delivery Optimization							If you have a second Windows computer in the same LAN, they can share Windows Update downloads, reducing your ISP's traffic quota usage.
	::DeviceAssociationService					Device Association Service						Needed for Bluetooth.
	::dmwappushservice							Device Management Wireless Application Protocol (WAP) Push message Routing Service		
	::DPS										Diagnostic Policy Service						Needed for powercfg /batteryreport.
	::DisplayEnhancementService					Display Enhancement Service		
	::DispBrokerDesktopSvc						Display Policy Service		
	::lfsvc										Geolocation Service		
	::iphlpsvc									IP Helper										Not needed for IPv6.
	::PolicyAgent								IPsec Policy Agent								Not needed for IPv6.
	::diagnosticshub.standardcollector.service	Microsoft (R) Diagnostics Hub Standard Collector Service		
	::AppVClient								Microsoft App-V Client		
	::smphost									Microsoft Storage Spaces SMP					Might be needed for Storage Spaces.
	::NetTcpPortSharing							Net.Tcp Port Sharing Service		
	::NcdAutoSetup								Network Connected Devices Auto-Setup		
	::NVDisplay.ContainerLocalSystem			NVIDIA Display Container LS						Only needed to launch Nvidia Control Panel.
	::ssh-agent									OpenSSH Authentication Agent		
	::SEMgrSvc									Payments and NFC/SE Manager		
	::QWAVE										Quality Windows Audio Video Experience		
	::RmSvc										Radio Management Service						Might be needed for Wi-Fi and Bluetooth.
	::RasMan									Remote Access Connection Manager		
	::RemoteRegistry							Remote Registry		
	::RemoteAccess								Routing and Remote Access		
	::shpamsvc									Shared PC Account Manager		
	::ScDeviceEnum								Smart Card Device Enumeration Service		
	::OneSyncSvc_*								Sync Host_*										May only be disabled in registry by setting HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc_*\Start = 0x4.
	::TapiSrv									Telephony		
	::TabletInputService						Touch Keyboard and Handwriting Panel Service	Needed by Windows Terminal (at least in Windows 11).
	::UevAgentService							User Experience Virtualization Service		
	::WbioSrvc									Windows Biometric Service						Needed to load Settings › Accounts › Sign-in options and maybe to use fingerprint readers.
	::wcncsvc									Windows Connect Now - Config Registrar		
	::WlanSvc									WLAN AutoConfig									Might be needed for Wi-Fi.
	


%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_disableBloatServices
%endfunction%

