Get-ADUser -SearchBase 'OU=Users,OU=Accounts,OU=DRG,DC=DRE,DC=NET' -Filter * | ForEach-Object { Add-ADGroupMember 'MimecastUsers' -Members $_ }