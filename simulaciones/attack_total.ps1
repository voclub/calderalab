Clear-Host

function Write-HackerLine {
    param (
        [string]$Text,
        [int]$Speed = 15,
        [ConsoleColor]$Color = 'Green'
    )
    Write-Host "" -NoNewline
    foreach ($char in $Text.ToCharArray()) {
        Write-Host $char -NoNewline -ForegroundColor $Color
        Start-Sleep -Milliseconds $Speed
    }
    Write-Host ""
}

function Write-PhaseTitle {
    param (
        [string]$Title
    )
    Write-Host "`n========== $Title ==========" -ForegroundColor Cyan
}

function Show-Banner {
    Clear-Host
    Write-Host "███╗░░░███╗██╗████████╗███████╗██████╗░" -ForegroundColor Green
    Write-Host "████╗░████║██║╚══██╔══╝██╔════╝██╔══██╗" -ForegroundColor Green
    Write-Host "██╔████╔██║██║░░░██║░░░█████╗░░██████╔╝" -ForegroundColor Green
    Write-Host "██║╚██╔╝██║██║░░░██║░░░██╔══╝░░██╔═══╝░" -ForegroundColor Green
    Write-Host "██║░╚═╝░██║██║░░░██║░░░███████╗██║░░░░░" -ForegroundColor Green
    Write-Host "╚═╝░░░░░╚═╝╚═╝░░░╚═╝░░░╚══════╝╚═╝░░░░░" -ForegroundColor Green
    Write-Host "      ATAQUE SIMULADO (MITRE STYLE)     " -ForegroundColor DarkGray
}

# ========== FASES DEL ATAQUE ==========

function Fase-AccesoInicial {
    Write-PhaseTitle "FASE 1 - ACCESO INICIAL"
    Write-HackerLine "[EMAIL] Phishing Email enviado a juan.perez@examplecorp.com"
    Write-HackerLine "[ATTACHMENT] PDF malicioso ejecutado"
    Write-HackerLine "[MALWARE] C2 conexión establecida: 192.168.1.15:443"
    Write-HackerLine "[+] Acceso inicial exitoso en workstation-203"
}

function Fase-Persistencia {
    Write-PhaseTitle "FASE 2 - PERSISTENCIA"
    Write-HackerLine "[REGISTRY] Agregado script de inicio en HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
    Write-HackerLine "[TASK SCHEDULER] Tarea 'Updater' creada para ejecución diaria"
    Write-HackerLine "[+] Persistencia asegurada"
}

function Fase-Escalacion {
    Write-PhaseTitle "FASE 3 - ESCALACIÓN DE PRIVILEGIOS"
    Write-HackerLine "[EXPLOIT] CVE-2021-1732 Win32k Elevation of Privilege"
    Write-HackerLine "[+] Usuario actual elevado a NT AUTHORITY\SYSTEM"
}

function Fase-Evasion {
    Write-PhaseTitle "FASE 4 - EVASIÓN DE DEFENSAS"
    Write-HackerLine "[DEFENSE] Windows Defender evadido con PowerShell Obfuscation"
    Write-HackerLine "[AMSIBYPASS] Código ofuscado ejecutado sin detección"
    Write-HackerLine "[+] Evasión de defensas completa"
}

function Fase-Credenciales {
    Write-PhaseTitle "FASE 5 - ACCESO A CREDENCIALES"
    Write-HackerLine "[MIMIKATZ] Ejecutando sekurlsa::logonpasswords"
    Write-HackerLine "[+] Credenciales encontradas:"
    Write-HackerLine "  - juan.perez:SuperSecret123"
    Write-HackerLine "  - admin.local:Qwerty!2024"
}

function Fase-Descubrimiento {
    Write-PhaseTitle "FASE 6 - DESCUBRIMIENTO"
    Write-HackerLine "[DISCOVERY] Enumerando hosts de red con ping sweep..."
    Write-HackerLine "[DISCOVERY] Enumerando usuarios y grupos..."
    Write-HackerLine "[+] Dominio detectado: EXAMPLECORP.LOCAL"
}

function Fase-Lateral {
    Write-PhaseTitle "FASE 7 - MOVIMIENTO LATERAL"
    Write-HackerLine "[PSREMAP] Credenciales reutilizadas para RDP a HR-WS01"
    Write-HackerLine "[SMB] PsExec lanzado en contabilidad-02"
    Write-HackerLine "[+] Movimiento lateral exitoso"
}

function Fase-Coleccion {
    Write-PhaseTitle "FASE 8 - COLECCIÓN"
    Write-HackerLine "[DOCS] Encontrado archivo: salarios2025.xlsx"
    Write-HackerLine "[EMAILS] Exportando buzón de Outlook: 2.3GB"
    Write-HackerLine "[DB] Conexión a SQL Server - extrayendo tabla Clientes"
}

function Fase-Exfiltracion {
    Write-PhaseTitle "FASE 9 - EXFILTRACIÓN"
    Write-HackerLine "[ZIP] Archivos sensibles comprimidos: data-leak.zip (900MB)"
    Write-HackerLine "[C2] Enviando datos a http://exfil.malicious.site/upload"
    Write-HackerLine "[+] Exfiltración completada"
}

function Fase-Impacto {
    Write-PhaseTitle "FASE 10 - IMPACTO"
    Write-HackerLine "[ENCRYPTION] Cifrando archivos en file server..."
    Write-HackerLine "[RANSOM] Nota de rescate colocada: readme_ransomware.txt"
    Write-HackerLine "[!!!] Servicio crítico interrumpido: ERP Offline"
    Write-HackerLine "[+] Ataque completado"
}

# ========== LOOP INFINITO ==========

while ($true) {
    Show-Banner
    Start-Sleep -Seconds 1

    Fase-AccesoInicial
    Start-Sleep -Seconds 1

    Fase-Persistencia
    Start-Sleep -Seconds 1

    Fase-Escalacion
    Start-Sleep -Seconds 1

    Fase-Evasion
    Start-Sleep -Seconds 1

    Fase-Credenciales
    Start-Sleep -Seconds 1

    Fase-Descubrimiento
    Start-Sleep -Seconds 1

    Fase-Lateral
    Start-Sleep -Seconds 1

    Fase-Coleccion
    Start-Sleep -Seconds 1

    Fase-Exfiltracion
    Start-Sleep -Seconds 1

    Fase-Impacto
    Start-Sleep -Seconds 3

    Write-Host "`n[+] Ciclo de ataque completado. Reiniciando en 8 segundos..." -ForegroundColor Red
    Start-Sleep -Seconds 8
    Clear-Host
}
