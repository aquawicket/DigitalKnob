:: View Ip Address information
@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

netsh interface ipv4 show config
