function CheckAdmin {
   $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
   $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

$wslPagentDir = "${env:APPDATA}/wsl-ssh-pageant"
$wslPagentFile = "${wslPagentDir}/wsl-ssh-pageant-amd64-gui.exe"
$wslJob = Get-ScheduledJob -Name wsl-ssh-pageant -ErrorAction Ignore

if (-Not (Test-Path $wslPagentFile -PathType Leaf)) {
   New-Item -Path $wslPagentDir -ItemType "directory" -ErrorAction Ignore
   $response = Invoke-RestMethod -Uri 'https://api.github.com/repos/benpye/wsl-ssh-pageant/releases/latest'
   $wslPagentDownloadUrl = ($response.assets | Where-Object name -eq 'wsl-ssh-pageant-amd64-gui.exe').browser_download_url
   Invoke-WebRequest -Uri $wslPagentDownloadUrl -OutFile $wslPagentFile
}

if ($null -eq $wslJob) {
   if ((CheckAdmin) -eq $false) {
      if ($Elevated) {
         "Could not elevate to create scheduled job" | Out-Host
         exit 1
      }
      Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition)) -Wait
      if ($? -ne $true) {
         "Could not create job" | Out-Host
         exit 1
      }
   } 
   else {
      try {
         $User = "$env:USERDOMAIN\$env:USERNAME"
         $Trigger = New-ScheduledTaskTrigger -AtLogOn -User $User
         $Principal = New-ScheduledTaskPrincipal -UserID "$User"
         $Action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument 'invoke-command -scriptblock {& "${env:APPDATA}/wsl-ssh-pageant/wsl-ssh-pageant-amd64-gui.exe" --systray --winssh ssh-pageant}'
         $Job = Register-ScheduledTask -TaskName wsl-ssh-pageant -Trigger $Trigger -Principal $Principal -Action $Action
      }
      catch {
         exit 1
      }
   }
}

$wslPagent = Get-Process wsl-ssh-pageant-amd64-gui.exe -ErrorAction SilentlyContinue
if (-Not $wslPagent) {
   Start-ScheduledTask -TaskName wsl-ssh-pageant
}
