:: Windows Features apps
@echo off
%dkbatch%

:: list all compoents
dism /online /get-features /format:table

:: enable a component, replace <COMPONONT_NAME>
::dism /online /enable-feature /featurename:<COMPONENT_NAME>

:: disable a component, replace <COMPONONT_NAME>
::dism /online /disable-feature /featurename:<COMPONENT_NAME>
