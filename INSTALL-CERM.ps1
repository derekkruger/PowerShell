Add-Content -Path C:\windows\System32\drivers\etc\hosts. -Value "x.x.x.x CERM-ENGINE"
Add-Content -Path C:\windows\System32\drivers\etc\hosts. -Value "x.x.x.x CERM-DATA"
msiexec.exe c:\scripts\install\cerm_drg.msi /passive
