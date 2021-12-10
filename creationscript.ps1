# ----- Variables----- #
$USERPASSWORDS   = "Password123"
$USERLIST = Get-Content .\namesfile.txt
# ------------------------------------------------------ #

$password = ConvertTo-SecureString $USERPASSWORDS -AsPlainText -Force
New-ADOrganizationalUnit -Name _USERS -ProtectedFromAccidentalDeletion $false

foreach ($n in $USERLIST) {
    $first = $n.Split(" ")[0].ToLower()
    $last = $n.Split(" ")[1].ToLower()
    $username = "$($first.Substring(0,1))$($last)".ToLower()
    Write-Host "Creating user: $($username)" -BackgroundColor Black -ForegroundColor Cyan
    
    New-AdUser -AccountPassword $password `-GivenName $first `-Surname $last `-DisplayName $username `
               -Name $username `-EmployeeID $username `-PasswordNeverExpires $true `
               -Path "ou=_USERS,$(([ADSI]`"").distinguishedName)" `-Enabled $true
}