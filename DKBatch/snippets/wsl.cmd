cd %USERPROFILE:\=/%/DigitalKnob/Development
wsl sh -c ./DKBuilder.sh

echo "Shutting down WSL"
::wsl --shutdown
pause