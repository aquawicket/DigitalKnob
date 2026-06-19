@echo off
set dequote=%*
set dequote=###%dequote%###
set dequote=%dequote:"###=%
set dequote=%dequote:###"=%
set dequote=%dequote:###=%
