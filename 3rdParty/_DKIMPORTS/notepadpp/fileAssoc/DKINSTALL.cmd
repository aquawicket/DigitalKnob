rem shebang
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


rem ####################################################################
rem # DKINSTALL()
rem #
:DKINSTALL
rem %setlocal%
	
	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	%dk_call% dk_validate notepadpp_exe %dk_call% dk_depend notepadpp
	%dk_call% dk_installFileAssoc .1 %notepadpp_exe%
	%dk_call% dk_installFileAssoc .2 %notepadpp_exe%
	%dk_call% dk_installFileAssoc .3 %notepadpp_exe%
	%dk_call% dk_installFileAssoc . %notepadpp_exe%
	%dk_call% dk_installFileAssoc .androidproj %notepadpp_exe%
	%dk_call% dk_installFileAssoc .backup %notepadpp_exe%
	%dk_call% dk_installFileAssoc .bak %notepadpp_exe%
	%dk_call% dk_installFileAssoc .c %notepadpp_exe%
	%dk_call% dk_installFileAssoc .cmake %notepadpp_exe%
	%dk_call% dk_installFileAssoc .cpp %notepadpp_exe%
	%dk_call% dk_installFileAssoc .css %notepadpp_exe%
	%dk_call% dk_installFileAssoc .data %notepadpp_exe%
	%dk_call% dk_installFileAssoc .gitattributes %notepadpp_exe%
	%dk_call% dk_installFileAssoc .gitconfig %notepadpp_exe%
	%dk_call% dk_installFileAssoc .glsl %notepadpp_exe%
	%dk_call% dk_installFileAssoc .gradle %notepadpp_exe%
	%dk_call% dk_installFileAssoc .h %notepadpp_exe%
	%dk_call% dk_installFileAssoc .htm %notepadpp_exe%
	%dk_call% dk_installFileAssoc .html %notepadpp_exe%
	%dk_call% dk_installFileAssoc .java %notepadpp_exe%
	%dk_call% dk_installFileAssoc .js %notepadpp_exe%
	%dk_call% dk_installFileAssoc .json %notepadpp_exe%
	%dk_call% dk_installFileAssoc .make %notepadpp_exe%
	%dk_call% dk_installFileAssoc .marks %notepadpp_exe%
	%dk_call% dk_installFileAssoc .md %notepadpp_exe%
	%dk_call% dk_installFileAssoc .mk %notepadpp_exe%
	%dk_call% dk_installFileAssoc .php %notepadpp_exe%
	%dk_call% dk_installFileAssoc .plist %notepadpp_exe%
	%dk_call% dk_installFileAssoc .pro %notepadpp_exe%
	%dk_call% dk_installFileAssoc .properties %notepadpp_exe%
	rem %dk_call% dk_installFileAssoc .ps1 %notepadpp_exe%
	%dk_call% dk_installFileAssoc .rc %notepadpp_exe%
	%dk_call% dk_installFileAssoc .reference %notepadpp_exe%
	%dk_call% dk_installFileAssoc .rsp %notepadpp_exe%
	%dk_call% dk_installFileAssoc .sed %notepadpp_exe%
	rem %dk_call% dk_installFileAssoc .sh %notepadpp_exe%
	%dk_call% dk_installFileAssoc .storyboard %notepadpp_exe%
	%dk_call% dk_installFileAssoc .targets %notepadpp_exe%
	%dk_call% dk_installFileAssoc .traineddata %notepadpp_exe%
	%dk_call% dk_installFileAssoc .ts %notepadpp_exe%
	%dk_call% dk_installFileAssoc .ts %notepadpp_exe%
	%dk_call% dk_installFileAssoc .txt %notepadpp_exe%
	%dk_call% dk_installFileAssoc .xml %notepadpp_exe%
%endfunction%
