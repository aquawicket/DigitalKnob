# Source: "Shell folders: the best-kept Windows time saving secret" by Mike Williams
# https://www.techradar.com/news/computing/pc/shell-folders-the-best-kept-windows-time-saving-secret-464668
$registrypath = 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\explorer\FolderDescriptions'
$shellfolders = $( Get-ChildItem -Path $registrypath | Get-ItemProperty | Select-Object -Property Name,ParsingName -ErrorAction Ignore | Sort-Object { $_.Name } )
$shellfolders | Out-GridView -Title 'Shell Folders' -PassThru | ForEach-Object { Start-Process -FilePath $( "shell:{0}" -f $_.Name ) }