Clear-Host
function Write-HackerLine {
    param (
        [string]$Text,
        [int]$Speed = 30,
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

function Simular-Exploit {
    $exploits = @(
        "[+] CVE-2021-41773 Apache Path Traversal - STATUS: EXPLOITABLE",
        "[!] Shell obtained at https://vpn.examplecorp.com:8080/shell.jsp",
        "[+] CVE-2017-5638 Apache Struts2 - STATUS: CRITICAL",
        "[!] Command Execution via Content-Type header",
        "[+] CVE-2014-0160 OpenSSL Heartbleed - VULNERABLE",
        "[!] Leaked memory buffer from server... parsing creds..."
    )
    foreach ($exp in $exploits) {
        Write-HackerLine $exp -Speed (Get-Random -Minimum 10 -Maximum 30)
        Start-Sleep -Milliseconds (Get-Random -Minimum 300 -Maximum 700)
    }
}

function Simular-DNS-Scan {
    $lines = @(
        "[DNS] Resolving target: vpn.examplecorp.com",
        "[DNS] A record: 203.0.113.10",
        "[DNS] MX record: mail.examplecorp.com",
        "[DNS] Subdomains found:",
        "     - dev.examplecorp.com",
        "     - staging.examplecorp.com",
        "     - api.examplecorp.com"
    )
    foreach ($line in $lines) {
        Write-HackerLine $line -Speed 15
        Start-Sleep -Milliseconds 300
    }
}

function Simular-Vuln-Scan {
    $results = @(
        "[SCAN] Target Open Ports: 22, 80, 443, 8080",
        "[NMAP] Service Detected: Apache/2.4.29",
        "[NMAP] Service Detected: Jetty 9.4.z",
        "[VULN SCAN] Starting script engine...",
        "[VULN] SSL Heartbleed detected (CVE-2014-0160)",
        "[VULN] Apache Struts2 RCE (CVE-2017-5638)",
        "[INFO] Weak SSL Cipher Suites Enabled",
        "[WARN] SSH outdated version found (OpenSSH 7.2)"
    )
    foreach ($line in $results) {
        Write-HackerLine $line -Speed (Get-Random -Minimum 15 -Maximum 30)
        Start-Sleep -Milliseconds (Get-Random -Minimum 200 -Maximum 500)
    }
}

# LOOP DE DEMOSTRACIÓN
while ($true) {
    Clear-Host
    Write-Host "██████╗░░█████╗░██╗░░██╗░█████╗░░█████╗░███████╗██████╗░" -ForegroundColor Green
    Write-Host "██╔══██╗██╔══██╗██║░░██║██╔══██╗██╔══██╗██╔════╝██╔══██╗" -ForegroundColor Green
    Write-Host "██████╦╝███████║███████║███████║██║░░██║█████╗░░██████╦╝" -ForegroundColor Green
    Write-Host "██╔══██╗██╔══██║██╔══██║██╔══██║██║░░██║██╔══╝░░██╔══██╗" -ForegroundColor Green
    Write-Host "██████╦╝██║░░██║██║░░██║██║░░██║╚█████╔╝███████╗██████╦╝" -ForegroundColor Green
    Write-Host "╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░╚══════╝╚═════╝░" -ForegroundColor Green
    Write-Host "        Hacker Recon & Vulnerability Scan Demo         " -ForegroundColor DarkGray

    Write-SectionTitle "Fase 1 - Reconocimiento DNS"
    Simular-DNS-Scan

    Write-SectionTitle "Fase 2 - Escaneo de Vulnerabilidades"
    Simular-Vuln-Scan

    Write-SectionTitle "Fase 3 - Simulación de Explotación"
    Simular-Exploit

    Write-Host "`n[+] Reiniciando escaneo en 8 segundos..." -ForegroundColor Red
    Start-Sleep -Seconds 8
}
