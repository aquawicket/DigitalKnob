cd %USERPROFILE:\=/%/Digital Knob/Development
wsl sh -c ./DKBuilder.sh

echo "Shutting down WSL"
::wsl --shutdown
pause