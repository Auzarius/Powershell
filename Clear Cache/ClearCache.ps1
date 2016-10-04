$command1 = 'cmd.exe /C RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2'
$command2 = 'cmd.exe /C RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8'

Remove-Item "$env:TEMP\*" -Force -Recurse -ErrorAction SilentlyContinue
#Remove-Item "$env:TMP\*"-Force -Recurse
Get-ChildItem ([environment]::GetEnvironmentVariable("temp","machine")) -Recurse -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$env:ALLUSERSPROFILE\TEMP\*" -Force -Recurse -ErrorAction SilentlyContinue

Invoke-Expression -Command:$command1
Invoke-Expression -Command:$command2

Remove-Item "$env:LOCALAPPDATA\Microsoft\Windows\Tempor~1\*" -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item "$env:LOCALAPPDATA\Mozilla\Firefox\Profiles\*" -Force -Recurse -ErrorAction SilentlyContinue

Get-ChildItem -Path "$env:LOCALAPPDATA\Google\Chrome\User Data" -Exclude Default, "First Run", "Local State" | foreach ($_) {
       Remove-Item $_.fullname -Force -Recurse -ErrorAction SilentlyContinue
}

Get-ChildItem -Path "$env:LOCALAPPDATA\Google\Chrome\User Data\Default" -Exclude "Bookmarks", "Bookmarks.bak", "Extensions", "Login Data", "Login Data-journal", "Secure Preferences", "Preferences" | foreach ($_) {
       Remove-Item $_.fullname -Force -Recurse -ErrorAction SilentlyContinue
}

"All Tasks have been completed!"