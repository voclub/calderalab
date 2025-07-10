Clear-Host

function Write-HackerLine {
    param (
        [string]$Text,
        [int]$Speed = 20,
        [ConsoleColor]$Color = 'Green'
    )
    Write-Host "" -NoNewline
    foreach ($char in $Text.ToCharArray()) {
        Write-Host $char -NoNewline -ForegroundColor $Color
        Start-Sleep -Milliseconds $Speed
    }
    Write-Host ""
}

function Write-SectionTitle {
    param (
        [string]$Title
    )
    Write-Host "`n========== $Title ==========" -ForegroundColor Cyan
}

function Simular-Whois {
    $whois = @(
        "Domain Name: EXAMPLECORP.COM",
        "Registrar: NameCheap, Inc.",
        "Created On: 2005-08-15",
        "Expires On: 2026-08-15",
        "Name Servers: ns1.examplecorp.com, ns2.examplecorp.com"
    )
    foreach ($line in $whois) {
        Write-HackerLine $line -Speed 15
        Start-Sleep -Milliseconds 300
    }
}

function Simular-DNS {
    $dns = @(
        "[DNS] Resolving: examplecorp.com -> 192.0.2.20",
        "[DNS] Subdomains found:",
        " - www.examplecorp.com",
        " - mail.examplecorp.com",
        " - vpn.examplecorp.com",
        " - dev.examplecorp.com",
        " - staging.examplecorp.com"
    )
    foreach ($line in $dns) {
        Write-HackerLine $line -Speed 15
        Start-Sleep -Milliseconds 300
    }
}

function Simular-Puertos {
    $puertos = @(
        "[SCAN] Scanning target: vpn.examplecorp.com",
        "[OPEN] Port 22/tcp - ssh (OpenSSH 7.2p2)",
        "[OPEN] Port 443/tcp - https (Apache 2.4.29)",
        "[OPEN] Port 8080/tcp - http-proxy (Jetty 9.4.z)"
    )
    foreach ($line in $puertos) {
        Write-HackerLine $line -Speed 15
        Start-Sleep -Milliseconds 300
    }
}

function Simular-Vulnerabilidades {
    $vulns = @(
        "[VULN] CVE-2014-0160 - OpenSSL Heartbleed - CRITICAL",
        "[VULN] CVE-2017-5638 - Apache Struts RCE - HIGH",
        "[VULN] CVE-2021-41773 - Path Traversal - CRITICAL",
        "[INFO] Weak SSL cipher suite detected (SHA1)",
        "[INFO] SSH outdated version: OpenSSH 7.2"
    )
    foreach ($v in $vulns) {
        Write-HackerLine $v -Speed (Get-Random -Minimum 10 -Maximum 30)
        Start-Sleep -Milliseconds (Get-Random -Minimum 200 -Maximum 500)
    }
}

function Simular-Explotacion {
    $exp = @(
        "[EXPLOIT] Sending payload to /cgi-bin/test.cgi",
        "[SHELL] Remote command execution succeeded!",
        "[SHELL] whoami -> apache",
        "[SHELL] cat /etc/passwd -> dumping...",
        "[DATA] Extracted credentials: admin:SuperSecret123!",
        "[DATA] Uploading reverse shell to /tmp/rev.sh",
        "[+] Connection back established: 192.168.1.15:4444"
    )
    foreach ($e in $exp) {
        Write-HackerLine $e -Speed (Get-Random -Minimum 10 -Maximum 30) -Color Red
        Start-Sleep -Milliseconds (Get-Random -Minimum 300 -Maximum 800)
    }
}

# BANNER ASCII
function Show-Banner {
    Clear-Host
    Write-Host "██████╗░░█████╗░██╗░░██╗░█████╗░░█████╗░███████╗██████╗░" -ForegroundColor Green
    Write-Host "██╔══██╗██╔══██╗██║░░██║██╔══██╗██╔══██╗██╔════╝██╔══██╗" -ForegroundColor Green
    Write-Host "██████╦╝███████║███████║███████║██║░░██║█████╗░░██████╦╝" -ForegroundColor Green
    Write-Host "██╔══██╗██╔══██║██╔══██║██╔══██║██║░░██║██╔══╝░░██╔══██╗" -ForegroundColor Green
    Write-Host "██████╦╝██║░░██║██║░░██║██║░░██║╚█████╔╝███████╗██████╦╝" -ForegroundColor Green
    Write-Host "╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░╚══════╝╚═════╝░" -ForegroundColor Green
    Write-Host "   Simulación de Reconocimiento, Escaneo y Explotación  " -ForegroundColor DarkGray
    Write-Host ""
}

# BUCLE PRINCIPAL
while ($true) {
    Show-Banner

    Write-SectionTitle "FASE 1 - RECONOCIMIENTO"
    Simular-Whois
    Simular-DNS

    Write-SectionTitle "FASE 2 - ESCANEO DE SUPERFICIE"
    Simular-Puertos

    Write-SectionTitle "FASE 3 - ESCANEO DE VULNERABILIDADES"
    Simular-Vulnerabilidades

    Write-SectionTitle "FASE 4 - EXPLOTACIÓN"
    Simular-Explotacion

    Write-Host "`n[+] Escenario completo. Reiniciando en 10 segundos..." -ForegroundColor Yellow
    Start-Sleep -Seconds 10
}
