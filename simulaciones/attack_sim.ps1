# Simulador de consola de atacante para presentaciones
Clear-Host
Write-Host "Cargando herramienta de ataque..." -ForegroundColor Green
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

# Simulación de reconocimiento
Simular-Comando -Comando "whoami" -Salida @("attacker-PC\attacker")
Simular-Comando -Comando "ipconfig" -Salida @(
    "Ethernet adapter Ethernet:",
    "   Connection-specific DNS Suffix  . :",
    "   IPv4 Address. . . . . . . . . . . : 192.168.1.15",
    "   Subnet Mask . . . . . . . . . . . : 255.255.255.0",
    "   Default Gateway . . . . . . . . . : 192.168.1.1"
)

# Simulación de escaneo de red
Simular-Comando -Comando "ping -n 1 192.168.1.1" -Salida @(
    "Pinging 192.168.1.1 with 32 bytes of data:",
    "Reply from 192.168.1.1: bytes=32 time<1ms TTL=64"
)

Simular-Comando -Comando "nmap -sP 192.168.1.0/24" -Salida @(
    "Starting Nmap 7.80 ( https://nmap.org )",
    "Nmap scan report for 192.168.1.1",
    "Host is up (0.0020s latency).",
    "Nmap scan report for 192.168.1.10",
    "Host is up (0.0030s latency).",
    "Nmap done: 256 IP addresses (2 hosts up)"
)

# Simulación de acceso remoto
Simular-Comando -Comando "ssh user@192.168.1.10" -Salida @(
    "Connecting to 192.168.1.10...",
    "user@192.168.1.10's password: ********",
    "Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.4.0-66-generic x86_64)",
    "Last login: Fri May 16 12:34:56 2025 from 192.168.1.15"
)

# Enumeración del sistema
Simular-Comando -Comando "ls /home/user" -Salida @("documents", "downloads", "scripts", "secrets.txt")

# Extracción simulada
Simular-Comando -Comando "cat /home/user/secrets.txt" -Salida @(
    "admin:SuperSecret123!",
    "token=abc123xyz987"
)

Write-Host "`n[+] Simulación completa. Presione cualquier tecla para salir..." -ForegroundColor Green
[void][System.Console]::ReadKey($true)
