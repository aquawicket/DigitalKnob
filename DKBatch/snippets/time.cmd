@echo off

for /L %%L in (-2147483648,1,2147483648) do @(
	echo !time!
)