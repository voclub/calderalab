# Simulador de descubrimiento de superficie de ataque
Clear-Host
Write-Host "Iniciando descubrimiento de superficie de ataque..." -ForegroundColor Cyan
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

# Dominio objetivo
$dominio = "examplecorp.com"

Simular-Comando -Comando "whois $dominio" -Salida @(
    "Domain Name: EXAMPLECORP.COM",
    "Registrar: NameCheap, Inc.",
    "Updated Date: 2024-10-01",
    "Creation Date: 2005-08-15",
    "Registry Expiry Date: 2026-08-15",
    "Name Server: NS1.EXAMPLECORP.COM",
    "Name Server: NS2.EXAMPLECORP.COM"
)

Simular-Comando -Comando "nslookup $dominio" -Salida @(
    "Server:  dns.google",
    "Address:  8.8.8.8",
    "",
    "Non-authoritative answer:",
    "Name:    examplecorp.com",
    "Address: 192.0.2.20"
)

# Simulando búsqueda de subdominios
Simular-Comando -Comando "subfinder -d $dominio" -Salida @(
    "www.examplecorp.com",
    "mail.examplecorp.com",
    "vpn.examplecorp.com",
    "dev.examplecorp.com",
    "staging.examplecorp.com",
    "api.examplecorp.com"
)

# Simulando resolución de subdominios
Simular-Comando -Comando "dnsrecon -d $dominio" -Salida @(
    "[+] Enumerating DNS records...",
    "[+] A record found: www.examplecorp.com -> 192.0.2.21",
    "[+] A record found: mail.examplecorp.com -> 192.0.2.22",
    "[+] A record found: vpn.examplecorp.com -> 203.0.113.10",
    "[+] A record found: dev.examplecorp.com -> 10.0.0.5 (INTERNAL!)",
    "[+] MX record found: mail.examplecorp.com",
    "[+] TXT record found: v=spf1 include:_spf.google.com ~all"
)

# Simulación de análisis de puertos expuestos en subdominios
Simular-Comando -Comando "nmap -Pn -p 80,443,22,8080 vpn.examplecorp.com" -Salida @(
    "Starting Nmap 7.80 ( https://nmap.org )",
    "Nmap scan report for vpn.examplecorp.com (203.0.113.10)",
    "Host is up (0.0040s latency).",
    "PORT     STATE SERVICE",
    "22/tcp   open  ssh",
    "443/tcp  open  https",
    "8080/tcp open  http-proxy",
    "Nmap done: 1 IP address (1 host up) scanned in 2.33 seconds"
)

# Cierre de simulación
Write-Host "`n[+] Descubrimiento de superficie completo. Dominio objetivo: $dominio" -ForegroundColor Green
[void][System.Console]::ReadKey($true)
