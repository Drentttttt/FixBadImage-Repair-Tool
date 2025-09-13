::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFB9GSTimM3y0Crod7PvH6euRq04SWqw2e4C7
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQJhZksaHErSXA==
::ZQ05rAF9IBncCkqN+0xwdVsFAlTMbCXqZg==
::ZQ05rAF9IAHYFVzEqQIWIQN2TQCrMWq9A/Uo5+f3jw==
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQIRaAhdQRSOOSf6CbsZpev35umM4l4SWPcrcYDVmqCBYOYa8gXwfZNtVJqmusoITDJVfxWu7O/J6WtQpGuXd8iS8zjoREyG8Vh+W0t7x3fVjyN7c9hhls8Qky67+Un6m+WSMYy/VLwdASPz1KIoLMEFvR67Z0WE2r9QXrbnf/37BibJKntflX/WmcN5h5A5Wi05DhlUj/lr5D+4QZO41zdVJnPSq/7vhhkdc5r4ZKEagg73wD5MjrmhmF8FB25dVRASQQSfQSHRBE/MzK/DZA1k4NWxOL5tbGw1UPlaWDwH1awD4CKxkLo1Md38h3aJBt2YBUx0OaylaHLW7Di7ZCukcMxDige2/aCOjoUuqrfCuq+yOd7g/IR1AuNHFtXadfc=
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFB9GSTimM3y0Crod7PvHyeOfgEwZfe8+f4qV36yLQA==
::YB416Ek+ZW8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
setlocal

:: Timestamp for logging
for /f %%i in ('powershell -Command "Get-Date -Format yyyy-MM-dd_HH-mm-ss"') do set "timestamp=%%i"

:: Define paths
set "scriptPath=%USERPROFILE%\OneDrive\Documents\FixBadImage.ps1"
set "logPath=%TEMP%\FixBadImageLog_%timestamp%.txt"

:: Launch PowerShell elevated with transcript logging
powershell -Command ^
  "Start-Process powershell -Verb RunAs -ArgumentList '-ExecutionPolicy Bypass -NoProfile -Command \"Start-Transcript -Path \"%logPath%\" -Append; & \"%scriptPath%\"; Stop-Transcript\"'"

:: Optional: Restart prompt
echo.
echo Script completed. Do you want to restart your computer now? (Y/N)
choice /c YN /n /m "Press Y to restart or N to exit: "
if errorlevel 1 shutdown /r /t 10

endlocal
