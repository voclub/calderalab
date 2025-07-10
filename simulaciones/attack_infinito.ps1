Clear-Host
Write-Host "Simulación de escaneo de vulnerabilidades (modo bucle)..." -ForegroundColor Cyan
Start-Sleep -Seconds 2

function Simular-Comando {
    param (
        [string]$Comando,
        [string[]]$Salida,
        [int]$Delay = 2
    )
    Write-Host "`nPS C:\Users\attacker>" -NoNewline -ForegroundColor Gray
    Write-Host $Comando -ForegroundColor White
    Start-Sleep -Seconds $Delay
    foreach ($line in $Salida) {
        Write-Host $line -ForegroundColor DarkGray
        Start-Sleep -Milliseconds (Get-Random -Minimum 100 -Maximum 300)
    }
}

# Dominio objetivo (puedes cambiarlo si quieres)
$objetivo = "vpn.examplecorp.com"

while ($true) {
    Write-Host "`n---- INICIANDO ESCANEO ----`n" -ForegroundColor Yellow
    Start-Sleep -Seconds 1

    # Nmap + NSE
    Simular-Comando -Comando "nmap -sV --script vuln $objetivo" -Salida @(
        "Starting Nmap 7.93 ( https://nmap.org )",
        "Nmap scan report for $objetivo (203.0.113.10)",
        "Host is up (0.0031s latency).",
        "",
        "PORT     STATE SERVICE    VERSION",
        "22/tcp   open  ssh        OpenSSH 7.2p2 Ubuntu 4ubuntu2.8",
        "443/tcp  open  https      Apache httpd 2.4.29",
        "8080/tcp open  http-proxy Jetty 9.4.z",
        "",
        "VULNERABILITIES:",
        "| ssl-heartbleed:",
        "|   VULNERABLE:",
        "|   The Heartbleed Bug is a serious vulnerability in OpenSSL.",
        "|     State: VULNERABLE",
        "|     Reference: CVE-2014-0160",
        "|_",
        "| http-vuln-cve2017-5638:",
        "|   VULNERABLE: Apache Struts RCE",
        "|     Risk: HIGH | Exploitable: YES",
        "|     Reference: CVE-2017-5638",
        "|_"
    )

    # Nikto
    Simular-Comando -Comando "nikto -h https://$objetivo" -Salida @(
        "- Nikto v2.1.6",
        "---------------------------------------------------------------------------",
        "+ Target: $objetivo (203.0.113.10)",
        "+ Server: Apache/2.4.29 (Ubuntu)",
        "+ X-XSS-Protection header not found.",
        "+ HSTS header not defined.",
        "+ HTTP Methods: GET, POST, OPTIONS",
        "+ /admin/: Possible admin panel.",
        "+ /icons/: Directory indexing enabled.",
        "---------------------------------------------------------------------------"
    )

    # Nessus-style scan
    Simular-Comando -Comando "nessus_scan -target $objetivo" -Salida @(
        "Connecting to Nessus scanner...",
        "Starting scan...",
        "",
        "[HIGH] CVE-2021-41773 – Apache Path Traversal",
        "[MEDIUM] CVE-2020-0796 – SMBv3 RCE",
        "[INFO] SSH version outdated",
        "[INFO] SSL uses SHA1",
        ""
    )

    Write-Host "`n[+] Escaneo finalizado. Reiniciando en 10 segundos..." -ForegroundColor Green
    Start-Sleep -Seconds 10
    Clear-Host
}
