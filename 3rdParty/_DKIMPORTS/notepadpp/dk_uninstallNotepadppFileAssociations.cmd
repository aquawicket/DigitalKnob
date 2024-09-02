@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0

::####################################################################
::# dk_uninstallNotepadppFileAssociations()
::#
:dk_uninstallNotepadppFileAssociations
	call dk_debugFunc 0
	
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate NOTEPADPP_EXE "call %DKIMPORTS_DIR%\notepadpp\dk_installNotepadpp"

	call dk_uninstallFileAssoc .1
	call dk_uninstallFileAssoc .2
	call dk_uninstallFileAssoc .3
	call dk_uninstallFileAssoc .
	call dk_uninstallFileAssoc .androidproj
	call dk_uninstallFileAssoc .backup
	call dk_uninstallFileAssoc .bak
	call dk_uninstallFileAssoc .c
	call dk_uninstallFileAssoc .cmake
	call dk_uninstallFileAssoc .cpp
	call dk_uninstallFileAssoc .css
	call dk_uninstallFileAssoc .data
	call dk_uninstallFileAssoc .gitattributes
	call dk_uninstallFileAssoc .gitconfig
	call dk_uninstallFileAssoc .glsl
	call dk_uninstallFileAssoc .gradle
	call dk_uninstallFileAssoc .h
	call dk_uninstallFileAssoc .htm
	call dk_uninstallFileAssoc .html
	call dk_uninstallFileAssoc .java
	call dk_uninstallFileAssoc .js
	call dk_uninstallFileAssoc .json
	call dk_uninstallFileAssoc .make
	call dk_uninstallFileAssoc .marks
	call dk_uninstallFileAssoc .md
	call dk_uninstallFileAssoc .mk
	call dk_uninstallFileAssoc .php
	call dk_uninstallFileAssoc .plist
	call dk_uninstallFileAssoc .pro
	call dk_uninstallFileAssoc .properties
	::call dk_uninstallFileAssoc .ps1
	call dk_uninstallFileAssoc .rc
	call dk_uninstallFileAssoc .reference
	call dk_uninstallFileAssoc .rsp
	call dk_uninstallFileAssoc .sed
	::call dk_uninstallFileAssoc .sh
	call dk_uninstallFileAssoc .storyboard
	call dk_uninstallFileAssoc .targets
	call dk_uninstallFileAssoc .traineddata
	call dk_uninstallFileAssoc .ts
	call dk_uninstallFileAssoc .ts
	call dk_uninstallFileAssoc .txt
	call dk_uninstallFileAssoc .xml
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
    call dk_uninstallNotepadppFileAssociations
goto:eof
