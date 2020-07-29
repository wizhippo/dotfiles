param(
   [string] $HostIP,
   [string] $ClientIP,
   [switch] $Elevated
)

function CheckAdmin {
   $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
   $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

$x410DefaultName = "x410"
# $x410DefaultRule = Get-NetFirewallRule -DisplayName $x410DefaultName -ErrorAction Ignore | Where-Object {$_.Enabled -eq $true}

# $name = "X410 WSL (In)"
# $fwRule = Get-NetFirewallRule -DisplayName $name -ErrorAction Ignore
# $fwFilter = Get-NetFirewallRule -DisplayName $name -ErrorAction Ignore | Get-NetFirewallAddressFilter

$x410Process = Get-Process $x410DefaultName -ErrorAction Ignore
if ($null -eq $x410Process) {
   Start-Process x410 -ArgumentList "/wm /listen hyperv /listen wsl2" 
}

# if (($null -eq $fwRule) -or ($fwFilter.LocalAddress -ne $HostIP) -or ($fwFilter.RemoteAddress -ne $ClientIP) -or ($null -ne $x410DefaultRule)) {
#    if ((CheckAdmin) -eq $false) {
#       if ($Elevated) {
#          "Could not elevate to create firewall rules" | Out-Host
#          exit 1
#       }
#       Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated  -HostIP "{1}" -ClientIP "{2}"' -f ($myinvocation.MyCommand.Definition),$HostIP,$ClientIP) -Wait
#       if ($? -ne $true) {
#          "Could not create firewall rules" | Out-Host
#          exit 1
#       }
#    } 
#    else {
#       try {
#          if ($null -ne $x410DefaultRule) {
#             Get-NetFirewallRule -DisplayName $x410DefaultName | Disable-NetFirewallRule
#          }
#          if ($null -ne $fwRule) {
#             Remove-NetFirewallRule -DisplayName $name
#          }
#          New-NetFirewallRule -DisplayName $name -Direction Inbound -LocalAddress $HostIP -RemoteAddress $ClientIP -Action Allow -ErrorAction Stop
#       }
#       catch {
#          exit 1
#       }
#    }
# }

exit 0
