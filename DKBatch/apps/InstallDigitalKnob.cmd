@echo off
setlocal enableDelayedExpansion

set "ONLINE=1"
set "DKSTORAGE_DIR=%SystemDrive%/DKStorage"
set "RELOAD_REPO=1"
set "RELOAD_BUNDLE=1"
set "GIT_COMMIT=1"
set "USERNAME=aquawicket"
set "EMAIL=aquawicket@hotmail.com"
set "BRANCH=Development"
set "REPO_URL=https://github.com/aquawicket/DigitalKnob.git"
set "REPO_PATH=%USERPROFILE:\=/%/DigitalKnob/%BRANCH%"
set "REPO_BUNDLE=%DKSTORAGE_DIR%/DigitalKnob.git"
set "GIT_URL=https://github.com/git-for-windows/git/releases/download/v2.46.2.windows.1/PortableGit-2.46.2-64-bit.7z.exe"
set "GIT_INSTALL=%DKSTORAGE_DIR%/PortableGit-2.46.2-64-bit.7z.exe"
set "git_exe=%DKSTORAGE_DIR%/PortableGit/bin/git.exe"


	rem # Download: https://github.com/git-for-windows/git/releases/download/v2.46.2.windows.1/PortableGit-2.46.2-64-bit.7z.exe
	if "%ONLINE%" equ "1" (
		echo ######### ONLINE #########
		if NOT EXIST "!GIT_INSTALL!" (
			echo ### Downloading PortableGit-2.46.2-64-bit.7z.exe
			set "CURL_EXE=%windir:\=/%/System32/curl.exe"
			"!CURL_EXE!" -L "!GIT_URL!" -o "!GIT_INSTALL!"
		)
	)
	
	
rem ######### OFFLINE #########
if NOT EXIST "%git_exe%" (
	echo ### Installing git
	"!GIT_INSTALL!"
)

echo ### Configuring git
"%git_exe%" config --global init.defaultBranch main
"%git_exe%" config --global credential.helper store
"%git_exe%" config --global user.email %EMAIL%
"%git_exe%" config --global user.name %USERNAME%

if "%RELOAD_REPO%" equ "1" (
	echo ### Reloading the local repository 
	if EXIST "%REPO_PATH%" (rd /s /q "%REPO_PATH%")
)
if NOT EXIST "%REPO_PATH%/.git" (
	rem ######### ONLINE #########
	if "%ONLINE%" equ "1" (
		echo ######### ONLINE #########
		echo ### Clone DigitalKnob repository from Github
		"%git_exe%" clone %REPO_URL% "%REPO_PATH%"
		
	rem ######### OFFLINE #########
	) else (
		echo ### Cloning DigitalKnob repository from local file
		"%git_exe%" clone "%REPO_BUNDLE%" "%REPO_PATH%"
	)
)

echo ### Git updating local repository
"%git_exe%" -C "%REPO_PATH%" pull --all
"%git_exe%" -C "%REPO_PATH%" checkout -- .
"%git_exe%" -C "%REPO_PATH%" checkout %BRANCH%


if "%RELOAD_BUNDLE%" equ "1" (
	if EXIST "%REPO_BUNDLE%" (del "%REPO_BUNDLE:/=\%")
)
if NOT EXIST "%REPO_BUNDLE%" (
	echo ### Backing up repository to bundle file
	"%git_exe%" -C "%REPO_PATH%" bundle create "%REPO_BUNDLE%" --all
)



rem ###########################################################################
rem ############################ MAKE CODE CHANGES ############################
rem ###########################################################################
echo ############################ MAKE CODE CHANGES NOW ############################
pause






if "%GIT_COMMIT%" equ "1" (
	rem ######### OFFLINE #########
	echo ### Save changes to local repository
	if "%commit_msg%" equ "" (set "commit_msg=git commit %date%")
	"%git_exe%" -C "%REPO_PATH%" commit -a -m "%commit_msg%"
 
	echo ### Backing up repository to bundle file
	"%git_exe%" -C "%REPO_PATH%" bundle create "%REPO_BUNDLE%" --all 

	rem ######### ONLINE #########	
	if "%ONLINE%" equ "1" (
		echo ######### ONLINE #########
		echo ### Pushing changes to Github
		"%git_exe%" -C "%REPO_PATH%" remote set-url origin %REPO_URL%
		"%git_exe%" -C "%REPO_PATH%" push
	)
)

pause
exit /b 0