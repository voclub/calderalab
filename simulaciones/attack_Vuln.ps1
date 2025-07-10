# Simulador de escaneo de vulnerabilidades para presentaciones
Clear-Host
Write-Host "Iniciando escaneo de vulnerabilidades..." -ForegroundColor Yellow
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

# Objetivo
$objetivo = "vpn.examplecorp.com"

# Simulación de escaneo con nmap + NSE
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
    "|   The Heartbleed Bug is a serious vulnerability in the popular OpenSSL cryptographic software library.",
    "|     State: VULNERABLE",
    "|     References:",
    "|       https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-0160",
    "|_",
    "| http-vuln-cve2017-5638:",
    "|   VULNERABLE: Apache Struts Remote Code Execution",
    "|     State: VULNERABLE",
    "|     IDs:  CVE-2017-5638",
    "|     Risk factor: HIGH",
    "|     Exploitation possible via crafted Content-Type header.",
    "|_    https://nvd.nist.gov/vuln/detail/CVE-2017-5638"
)

# Simulación de escaneo web con Nikto
Simular-Comando -Comando "nikto -h https://$objetivo" -Salida @(
    "- Nikto v2.1.6",
    "---------------------------------------------------------------------------",
    "+ Target IP:          203.0.113.10",
    "+ Target Hostname:    $objetivo",
    "+ Target Port:        443",
    "+ Start Time:         2025-05-16 10:00:00",
    "---------------------------------------------------------------------------",
    "+ Server: Apache/2.4.29 (Ubuntu)",
    "+ The X-XSS-Protection header is not defined. This header can hint to the user agent to protect against some forms of XSS",
    "+ The site uses SSL and the Strict-Transport-Security HTTP header is not defined.",
    "+ Allowed HTTP Methods: GET, POST, OPTIONS",
    "+ OSVDB-3092: /admin/: This might be an administrative login page.",
    "+ OSVDB-3233: /icons/: Directory indexing found.",
    "+ End Time:           2025-05-16 10:00:15",
    "---------------------------------------------------------------------------",
    "+ 6 host(s) tested"
)

# Simulación de escaneo de CVEs con un escáner comercial
Simular-Comando -Comando "nessus_scan -target $objetivo" -Salida @(
    "Connecting to Nessus scanner...",
    "Starting scan for $objetivo...",
    "",
    "[HIGH] CVE-2021-41773 – Apache Path Traversal Vulnerability",
    "       Affected Software: Apache HTTP Server 2.4.49",
    "       Exploitable: Yes – Remote Code Execution Possible",
    "",
    "[MEDIUM] CVE-2020-0796 – SMBv3 Compression Remote Code Execution",
    "       Affected Software: Windows Server 2019",
    "       Exploitable: Yes, but mitigated with latest patch.",
    "",
    "[INFO] Outdated SSH version detected (OpenSSH 7.2)",
    "[INFO] SSL Certificate uses weak hashing algorithm (SHA1)"
)

# Cierre
Write-Host "`n[+] Escaneo de vulnerabilidades finalizado. Se detectaron vulnerabilidades críticas." -ForegroundColor Red
[void][System.Console]::ReadKey($true)
