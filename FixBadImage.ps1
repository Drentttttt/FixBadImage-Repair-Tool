# FixBadImage Repair Tool
# Author: Dre
# Version: 1.0

# Start transcript for logging
$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$logPath = "$env:TEMP\FixBadImageLog_$timestamp.txt"
Start-Transcript -Path $logPath -Append

# Define repair steps
$steps = @(
    @{ Name = "Checking system integrity (SFC)"; Action = {
        try {
            sfc /scannow
        } catch {
            Write-Host "❌ SFC scan failed: $_" -ForegroundColor Red
        }
    }},
    @{ Name = "Running DISM repair"; Action = {
        try {
            DISM /Online /Cleanup-Image /RestoreHealth
        } catch {
            Write-Host "❌ DISM failed: $_" -ForegroundColor Red
        }
    }},
    @{ Name = "Installing Visual C++ Redistributables"; Action = {
        try {
            $vcUrl = "https://aka.ms/vs/17/release/vc_redist.x64.exe"
            $vcPath = "$env:TEMP\vc_redist.x64.exe"
            Invoke-WebRequest -Uri $vcUrl -OutFile $vcPath -UseBasicParsing
            Start-Process -FilePath $vcPath -ArgumentList "/install", "/quiet", "/norestart" -Wait
        } catch {
            Write-Host "❌ Redistributable install failed: $_" -ForegroundColor Red
        }
    }},
    @{ Name = "Final cleanup"; Action = {
        Write-Host "✅ Repair steps completed." -ForegroundColor Green
    }}
)

# Run steps with progress bar
for ($i = 0; $i -lt $steps.Count; $i++) {
    $percent = ($i / $steps.Count) * 100
    Write-Progress -Activity "FixBadImage Repair Tool" -Status $steps[$i].Name -PercentComplete $percent
    & $steps[$i].Action
    Start-Sleep -Seconds 2
}

Write-Progress -Activity "FixBadImage Repair Tool" -Completed

# End transcript
Stop-Transcript

# Optional restart prompt
Write-Host "`nWould you like to restart your PC now? (Y/N)" -ForegroundColor Cyan
$choice = Read-Host "Type Y to restart or N to exit"
if ($choice -eq "Y") {
    shutdown /r /t 10
}
