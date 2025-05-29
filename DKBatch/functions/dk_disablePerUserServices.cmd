@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_disablePerUserServices()
::#
::#
:dk_disablePerUserServices
%setlocal%

	%dk_call% dk_registrySetKey "HKLM\SYSTEM\ControlSet001\Services\AarSvc" 						"UserServiceFlags" "REG_DWORD" "0"
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\ControlSet001\Services\CaptureService" 				"UserServiceFlags" "REG_DWORD" "0"
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\ControlSet001\Services\cbdhsvc" 						"UserServiceFlags" "REG_DWORD" "0"
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\ControlSet001\Services\CDPUserSvc" 					"UserServiceFlags" "REG_DWORD" "0"
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\ControlSet001\Services\ConsentUxUserSvc" 				"UserServiceFlags" "REG_DWORD" "0"
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\ControlSet001\Services\DeviceAssociationBrokerSvc" 	"UserServiceFlags" "REG_DWORD" "0"
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\ControlSet001\Services\DevicePickerUserSvc" 			"UserServiceFlags" "REG_DWORD" "0"
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\ControlSet001\Services\DevicesFlowUserSvc" 			"UserServiceFlags" "REG_DWORD" "0"
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\ControlSet001\Services\P9RdrService" 					"UserServiceFlags" "REG_DWORD" "0"
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\ControlSet001\Services\PenService" 					"UserServiceFlags" "REG_DWORD" "0"
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\ControlSet001\Services\UdkUserSvc" 					"UserServiceFlags" "REG_DWORD" "0"
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\ControlSet001\Services\WpnUserService" 				"UserServiceFlags" "REG_DWORD" "0"
	
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\AarSvc" 					"UserServiceFlags" "REG_DWORD" "0"
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\CaptureService" 			"UserServiceFlags" "REG_DWORD" "0"
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\cbdhsvc" 					"UserServiceFlags" "REG_DWORD" "0"
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc" 				"UserServiceFlags" "REG_DWORD" "0"
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\ConsentUxUserSvc" 			"UserServiceFlags" "REG_DWORD" "0"
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\DeviceAssociationBrokerSvc" "UserServiceFlags" "REG_DWORD" "0"
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\DevicePickerUserSvc" 		"UserServiceFlags" "REG_DWORD" "0"
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\DevicesFlowUserSvc" 		"UserServiceFlags" "REG_DWORD" "0"
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\P9RdrService" 				"UserServiceFlags" "REG_DWORD" "0"
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\PenService" 				"UserServiceFlags" "REG_DWORD" "0"
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\UdkUserSvc" 				"UserServiceFlags" "REG_DWORD" "0"
	%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\WpnUserService" 			"UserServiceFlags" "REG_DWORD" "0"

%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_disablePerUserServices
%endfunction%

