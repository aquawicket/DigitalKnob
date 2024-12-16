@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_uninstallNotepadppFileAssociations()
::#
:dk_uninstallNotepadppFileAssociations
	call dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate NOTEPADPP_EXE "%dk_call% %DKIMPORTS_DIR%\notepadpp\dk_install.cmd"

	%dk_call% dk_uninstallFileAssoc .1
	%dk_call% dk_uninstallFileAssoc .2
	%dk_call% dk_uninstallFileAssoc .3
	%dk_call% dk_uninstallFileAssoc .
	%dk_call% dk_uninstallFileAssoc .androidproj
	%dk_call% dk_uninstallFileAssoc .backup
	%dk_call% dk_uninstallFileAssoc .bak
	%dk_call% dk_uninstallFileAssoc .c
	%dk_call% dk_uninstallFileAssoc .cmake
	%dk_call% dk_uninstallFileAssoc .cpp
	%dk_call% dk_uninstallFileAssoc .css
	%dk_call% dk_uninstallFileAssoc .data
	%dk_call% dk_uninstallFileAssoc .gitattributes
	%dk_call% dk_uninstallFileAssoc .gitconfig
	%dk_call% dk_uninstallFileAssoc .glsl
	%dk_call% dk_uninstallFileAssoc .gradle
	%dk_call% dk_uninstallFileAssoc .h
	%dk_call% dk_uninstallFileAssoc .htm
	%dk_call% dk_uninstallFileAssoc .html
	%dk_call% dk_uninstallFileAssoc .java
	%dk_call% dk_uninstallFileAssoc .js
	%dk_call% dk_uninstallFileAssoc .json
	%dk_call% dk_uninstallFileAssoc .make
	%dk_call% dk_uninstallFileAssoc .marks
	%dk_call% dk_uninstallFileAssoc .md
	%dk_call% dk_uninstallFileAssoc .mk
	%dk_call% dk_uninstallFileAssoc .php
	%dk_call% dk_uninstallFileAssoc .plist
	%dk_call% dk_uninstallFileAssoc .pro
	%dk_call% dk_uninstallFileAssoc .properties
	::%dk_call% dk_uninstallFileAssoc .ps1
	%dk_call% dk_uninstallFileAssoc .rc
	%dk_call% dk_uninstallFileAssoc .reference
	%dk_call% dk_uninstallFileAssoc .rsp
	%dk_call% dk_uninstallFileAssoc .sed
	::%dk_call% dk_uninstallFileAssoc .sh
	%dk_call% dk_uninstallFileAssoc .storyboard
	%dk_call% dk_uninstallFileAssoc .targets
	%dk_call% dk_uninstallFileAssoc .traineddata
	%dk_call% dk_uninstallFileAssoc .ts
	%dk_call% dk_uninstallFileAssoc .ts
	%dk_call% dk_uninstallFileAssoc .txt
	%dk_call% dk_uninstallFileAssoc .xml
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
    %dk_call% dk_uninstallNotepadppFileAssociations
%endfunction%
