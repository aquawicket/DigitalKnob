### 
https://anytxt.net/manage-indexing-options-and-settings-for-windows-11-a-tutorial/
###### To start search indexing in Windows 11 ######
sc stop “wsearch” && sc config “wsearch” start=disabled

############ To disable search indexing: ############
sc config “wsearch” start=delayed-auto && sc start “wsearch”