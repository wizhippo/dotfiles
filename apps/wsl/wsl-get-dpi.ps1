# Get the DPI setting for the primary monitor
$monitor = Get-WmiObject -Class Win32_DesktopMonitor | Select-Object -First 1
$scale = [System.Math]::Round($monitor.PixelsPerXLogicalInch / 96, [System.MidpointRounding]::AwayFromZero)

Write-Output $scale
